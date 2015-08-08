//
//  AnimalStorageImage.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/7/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "AnimalStorageImage.h"

@implementation AnimalStorageImage

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

+ (AnimalStorageImage *)sharedStore
{
    // Set up the static sharedStore variable here
    static AnimalStorageImage *sharedStore = nil;
    
    if (!sharedStore)
    {
        sharedStore = [[super allocWithZone:NULL] init];
    }
    
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        dictionary = [[NSMutableDictionary alloc] init];
        
        // Set up a notification for Low Memory Warnings
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    
    return self;
}

#pragma mark BNRImageStore Methods

-(void)setImage:(UIImage *)image forKey:(NSString *)s
{
    [dictionary setObject:image forKey:s];
    
    NSString *imagePath = [self imagePathForKey:s];
    
    // Turn the image into JPEG data
    //NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    // Turn the image into a PNG
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // Now write the data to the path
    [imageData writeToFile:imagePath atomically:YES];
}


-(UIImage *)imageForKey:(NSString *)s
{
    //return [dictionary objectForKey:s];
    
    // Load the image is we have it
    UIImage *result = [dictionary objectForKey:s];
    
    // If we found the image, load it
    if (!result)
    {
        //Create an UIImage from the object
        result = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];
        
        if (result)
        {
            [dictionary setObject:result forKey:s];
        }
        else
        {
            NSLog(@"Error loading image %@", [self imagePathForKey:s]);
        }
    }
    
    return result;
    
}

-(void)deleteImageForKey:(NSString *)s
{
    if (!s)
    {
        return;
    }
    
    [dictionary removeObjectForKey:s];
    
    // Also delete the image from the image store
    NSString *path = [self imagePathForKey:s];
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

-(NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

#pragma mark BNRImageStore Notification Handlers

-(void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing out %lu image from cache", (unsigned long)[dictionary count]);
    [dictionary removeAllObjects];
}

@end
