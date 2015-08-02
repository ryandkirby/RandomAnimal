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

@interface RandomAnimalViewController : UIViewController

@property (nonatomic) AnimalRosterTableViewController *animalRosterTableViewontroller;

- (IBAction)launchAnimalRoster:(id)sender;
- (IBAction)findRandomAnimal:(id)sender;

@end
