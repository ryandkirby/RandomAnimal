//
//  Animal.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property (nonatomic) NSUInteger AnimalStatusInt;
@property (nonatomic, copy) NSString* AnimalImageNameStr;
@property (nonatomic, copy) NSString* AnimalNmaeStr;

@end
