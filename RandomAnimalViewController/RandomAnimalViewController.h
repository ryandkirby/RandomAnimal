//
//  RandomAnimalViewController.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimalRosterTableViewController.h"
#import "AppShared.h"
#import "AnimalStorage.h"
#import "AppDelegate.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface RandomAnimalViewController : UIViewController
{
    __weak IBOutlet UILabel *animalName;
    UIButton *randomAnimalButton;
    
}

@property (nonatomic) AnimalRosterTableViewController *animalRosterTableViewontroller;
@property (nonatomic, weak) IBOutlet UIImageView *animalImage;

- (IBAction)launchAnimalRoster:(id)sender;
- (IBAction)findRandomAnimal:(id)sender;
- (UIImage *)squareImageWithColor:(UIColor *)color dimensionWidth:(int)dimWidth dimensionHeight:(int)dimHeight;
- (void)generateRandomAnimal;
@property CGRect previousScreenSize;

@end
