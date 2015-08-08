//
//  AnimalStorageImage.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/7/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimalStorage.h"

@interface AnimalStorageImage : NSObject
{
    NSMutableDictionary *dictionary;
}

+ (AnimalStorageImage*)sharedStore;

-(void)setImage:(UIImage *)image forKey:(NSString *)s;
-(UIImage *)imageForKey:(NSString *)s;
-(void)deleteImageForKey:(NSString *)s;
- (NSString *)imagePathForKey:(NSString *)key;

@end
