//
//  AnimalViewController.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/5/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"

@interface AnimalViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *animalName;
@property (nonatomic, weak) IBOutlet UIImageView *animalImageImage;
@property (nonatomic, weak)  Animal *animal;

@end
