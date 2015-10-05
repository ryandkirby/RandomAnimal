//
//  AnimalViewController.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/5/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "AnimalViewController.h"

@interface AnimalViewController ()

@end


@implementation AnimalViewController

@synthesize animalImage, animalName, animal, animalAvailableSwitch, availablityText, actualNameReadOnly, takePhotoButton, originalCenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (animal != nil)
    {
        if (animal != nil)
        {
            self.title = animal.AnimalNameStr;
        }
        
        // Set the control states depending on the edit state
        if (animal.AnimalNameStr.length == 0)
        {
            [self setEditing:YES];
        }
                
        // Set the title of the screen
        if (animal.AnimalNameStr != nil)
        {
            animalName.text = animal.AnimalNameStr;
            // Set the animal name if it's available
            [actualNameReadOnly setText:animal.AnimalNameStr];
        }
        
        // Set the image
        UIImage *img = [[AnimalStorageImage sharedStore] imageForKey:[animal imageKey]];
        if (img)
        {
            [animalImage setImage:img];
        }
        
        // Set the switch state
        if (animal.AnimalStatusInt)
        {
            animalAvailableSwitch.on = true;
        }
        else
        {
            animalAvailableSwitch.on = false;
        }
        
        [animalAvailableSwitch addTarget:self action:@selector(setSwitchState:) forControlEvents:UIControlEventValueChanged];
    }
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSwitchState:(id)sender
{
    BOOL state = [sender isOn];
    animal.AnimalStatusInt = state;
}

 - (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    AnimalEditViewController *animalEditViewController = [[AnimalEditViewController alloc] init];
    animalEditViewController.animal = animal;
    
     // Set the back button of the next navigation controller 'Animal View'
     animalEditViewController.navigationItem.leftBarButtonItem =
     [[UIBarButtonItem alloc] initWithTitle:CANCEL_BUTTON_TEXT
     style:UIBarButtonItemStylePlain
     target:nil
     action:nil];
    
    // Push the view controller.
    [self.navigationController pushViewController:animalEditViewController animated:NO];
}

@end
