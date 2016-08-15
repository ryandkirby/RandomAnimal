//
//  AnimalViewController.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/5/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"
#import "AnimalStorageImage.h"
#import "AnimalRosterTableViewController.h"
#import "AnimalEditViewController.h"

@interface AnimalViewController : UIViewController <UINavigationControllerDelegate, UITextFieldDelegate>
{

}

//@property (nonatomic, strong) Animal *item;
@property (nonatomic, weak) IBOutlet UILabel *animalName;
@property (nonatomic, weak) IBOutlet UILabel *availablityText;
@property (nonatomic, weak) IBOutlet UILabel *actualNameReadOnly;
@property (nonatomic, weak) IBOutlet UIImageView *animalImage;
@property (nonatomic, retain) IBOutlet UISwitch *animalAvailableSwitch;
@property (nonatomic, weak)  Animal *animal;
@property CGPoint originalCenter;

@end
