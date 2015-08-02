//
//  AnimalStorage.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "AnimalStorage.h"

@implementation AnimalStorage

+ (AnimalStorage *)sharedStorage;
{
    static AnimalStorage *sharedStorage = nil;
    if (!sharedStorage)
    {
        sharedStorage = [[super allocWithZone:nil] init];
    }
    
    return sharedStorage;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedStorage];
}

@end
