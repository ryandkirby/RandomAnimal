//
//  Animal.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "Animal.h"

@implementation Animal

@synthesize AnimalImageNameStr, AnimalNameStr, AnimalStatusInt, imageKey, thumbnail, thumbnailData;

- (id)initWithItemName:(NSInteger)status
           animalImage:(NSString *)imageStr
            animalName:(NSString *)name
{
    // Call the superclass's designated initializer
    self = [super init];
    
    // Did the superclass's designated initializer succeed?
    if(self)
    {
        // Give the instance variables initial values
        [self setAnimalStatusInt:status];
        [self setAnimalNameStr:name];
        [self setAnimalImageNameStr:imageStr];
    }
    
    // Return the address of the newly initialized object
    return self;
}

-(void)setThumbnailDataFromImage:(UIImage *)image
{
    CGSize origImageSize = [image size];
    
    // Make the size of the thumbnail
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    // Scale while maintaining the same aspect ratio
    float ratio = MAX(newRect.size.width / origImageSize.width,
                      newRect.size.height / origImageSize.height);
    
    //Create a transparent bitmap with the scaling factor we calculated
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    // Create a patch that is a rounded rect
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    // Make all clipping to this rounded rect
    [path addClip];
    
    // Center the image into the thumbnail
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x  = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y  = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [image drawInRect:projectRect];
    
    // Get the image from the image content, keep it as our thumbnail
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbnail:smallImage];
    
    // Get the PNG representation of the image and set it as our archivable data
    NSData *data = UIImagePNGRepresentation(smallImage);
    [self setThumbnailData:data];
    
    // Cleanup our resources
    UIGraphicsEndImageContext();
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setAnimalStatusInt:[aDecoder decodeIntegerForKey:@"status"]];
        [self setAnimalNameStr:[aDecoder decodeObjectForKey:@"name"]];
        [self setImageKey:[aDecoder decodeObjectForKey:@"imageKey"]];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:AnimalStatusInt forKey:@"status"];
    [aCoder encodeObject:AnimalNameStr forKey:@"name"];
    [aCoder encodeObject:imageKey forKey:@"imageKey"];
    
}

@end

