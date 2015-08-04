//
//  Animal.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "Animal.h"

@implementation Animal

@synthesize AnimalImageNameStr, AnimalNameStr, AnimalStatusInt;

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


@end

