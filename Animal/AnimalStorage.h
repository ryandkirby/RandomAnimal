//
//  AnimalStorage.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animal.h"

@class Animal;

@interface AnimalStorage : NSObject
{
    NSMutableArray *allItems;
}


+ (AnimalStorage *)sharedStorage;

-(NSArray *)allItems;
-(Animal *)createItem;

@end
