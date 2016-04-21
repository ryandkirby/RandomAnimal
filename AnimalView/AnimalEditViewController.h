//
//  AnimalEditViewController.h
//  RandomAnimal
//
//  Created by Ryan Kirby on 10/3/15.
//  Copyright © 2015 Engby LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"
#import "AnimalStorageImage.h"
#import "AppShared.h"

@interface AnimalEditViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UITextFieldDelegate>
{
    UIPopoverController *imagePickerPopover;
}

//@property (nonatomic, strong) Animal *item;
@property (nonatomic, weak) IBOutlet UILabel *animalName;
@property (nonatomic, weak) IBOutlet UILabel *availablityText;
@property (nonatomic, weak) IBOutlet UITextField *actualNameEdit;
@property (nonatomic, weak) IBOutlet UILabel *actualNameReadOnly;
@property (nonatomic, weak) IBOutlet UIImageView *animalImage;
@property (nonatomic, weak) IBOutlet UIButton *takePhotoButton;
@property (nonatomic, weak) IBOutlet UIButton *deleteButton;
@property (nonatomic, weak) IBOutlet UIImage *tempAnimalImage;
@property (nonatomic, weak)  Animal *animal;
@property CGPoint originalCenter;
@property BOOL isNewAnimal;
@property (nonatomic, retain) UIBarButtonItem *cancelButton;
@property (nonatomic, retain) UIBarButtonItem *backButton;
@property (nonatomic, retain) UIBarButtonItem *doneButton;


- (IBAction)takePicture:(id)sender;
- (IBAction)deleteAnimal:(id)sender;

@end
