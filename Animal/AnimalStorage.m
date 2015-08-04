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

- (id)init
{
    self = [super init];
    if (self)
    {
        allItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(NSArray *)allItems
{
    return allItems;
}

- (Animal *)createItem
{
    Animal *a = [[Animal alloc] init];
    
    [allItems addObject:a];
    
    return a;
}

@end
