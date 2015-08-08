//
//  Animal.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface Animal : NSObject

@property (nonatomic) NSInteger AnimalStatusInt;
@property (nonatomic, copy) NSString* AnimalImageNameStr;
@property (nonatomic, copy) NSString* AnimalNameStr;
@property (nonatomic, retain) NSData * thumbnailData;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, retain) NSString * imageKey;

- (id)initWithItemName:(NSInteger)status
              animalImage:(NSString *)imageStr
             animalName:(NSString *)name;

- (void)setThumbnailDataFromImage:(UIImage *)image;

@end
