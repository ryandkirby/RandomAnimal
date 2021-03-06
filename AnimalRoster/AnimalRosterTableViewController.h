//
//  AnimalRosterTableViewController.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppShared.h"
#import "AnimalStorage.h"
#import "AnimalRosterTableViewCell.h"
#import "AnimalViewController.h"
#import "AnimalEditViewController.h"
#import "AnimalStorageImage.h"

@interface AnimalRosterTableViewController : UITableViewController

-(IBAction)addAnimal:(id)sender;

@end
