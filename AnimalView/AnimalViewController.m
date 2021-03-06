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

@synthesize animalImage, animalName, animal, animalAvailableSwitch, availablityText, actualNameReadOnly;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (animal != nil)
    {        
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
    }
    
    // Set the title bar font and color
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:ANIMAL_APP_FONT size:21], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    // Set Right button action, text, and color
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:EDIT_BUTTON_TEXT style:UIBarButtonItemStylePlain target:self action:@selector(EditAnimal:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{
                                                                    NSFontAttributeName: [UIFont fontWithName:ANIMAL_APP_FONT size:21.0],
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                    } forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Set the image if it was set on the edit screen
    UIImage *img = [[AnimalStorageImage sharedStore] imageForKey:[animal imageKey]];
    if (img)
    {
        [animalImage setImage:img];
    }
    
    // Reset the name if it's valid
    if (animal.AnimalNameStr != nil)
    {
        animalName.text = animal.AnimalNameStr;
        // Set the animal name if it's available
        [actualNameReadOnly setText:animal.AnimalNameStr];
    }
    
    if ([self animal] == nil)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animalAvailableSwitch:(id)sender
{
    BOOL state = [sender isOn];
    animal.AnimalStatusInt = state;
}

-(IBAction)EditAnimal:(id)sender
{
    AnimalEditViewController *animalEditViewController = [[AnimalEditViewController alloc] init];
    animalEditViewController.animal = animal;
    
     // Set the back button of the next navigation controller 'Animal View'
     animalEditViewController.navigationItem.leftBarButtonItem =
     [[UIBarButtonItem alloc] initWithTitle:CANCEL_BUTTON_TEXT
     style:UIBarButtonItemStylePlain
     target:nil
     action:nil];
    
    // Push the view controller with fading transition.
    CATransition* transition = [CATransition animation];
    transition.duration = EDIT_TRANSITION_TIME;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:animalEditViewController animated:NO];
}

@end
