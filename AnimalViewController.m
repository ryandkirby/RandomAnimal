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

@synthesize animalImage, animalName, animal, animalAvailableSwitch, availablityText, actualNameEdit, actualNameReadOnly, takePhotoButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (animal != nil)
    {
        self.title = animal.AnimalNameStr;

        // Set the control states depending on the edit state
        [self setEditControlState];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture:(id)sender
{
    // If the popup is already displayed, close it.
    if ([imagePickerPopover isPopoverVisible])
    {
        // Close the popup here
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    [imagePicker allowsEditing];
    
    // If our device supports a camera, use it
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    
    [imagePicker setDelegate:self];
    
    // Below the code will make a popup use this if the device is an iPad.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        // Create the popup controller
        imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        
        // Set the delgate of the popover to be this class
        [imagePickerPopover setDelegate:self];
        
        // Set the content
        [imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
    else
    {
        // This is the display for the iPhone.
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Clean out any old images
    NSString *oldKey = [animal imageKey];
    
    if (oldKey)
    {
        [[AnimalStorageImage sharedStore] deleteImageForKey:oldKey];
    }
    
    //Get the selected image
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    [animal setThumbnailDataFromImage:image];
    
    // Put that image into the screen
    [animalImage setImage:image];
    
    //Store this image in our Animal by creating a GUID for it
    CFUUIDRef newGUID = CFUUIDCreate(kCFAllocatorDefault);
    
    CFStringRef newGUIDIDString = CFUUIDCreateString(kCFAllocatorDefault, newGUID);
    
    //Now store the image and key into the dictionary
    NSString *key = (__bridge NSString *)newGUIDIDString;
    [animal setImageKey:key];
    
    [[AnimalStorageImage sharedStore] setImage:image forKey:[animal imageKey]];
    
    // Clear up the memory from the strings above!
    CFRelease(newGUID);
    CFRelease(newGUIDIDString);
    
    // Take the imagepicker off the screen.  Control this behavior depending on the device type
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
    }
}

-(void)setEditControlState
{
    if (self.editing)
    {
        // Set the state of the dialog Edit vs. Readonly
        [actualNameEdit setHidden:FALSE];
        [actualNameReadOnly setHidden:TRUE];
        [takePhotoButton setHidden:FALSE];
        
    }
    else
    {
        [actualNameEdit setHidden:TRUE];
        [actualNameReadOnly setHidden:FALSE];
        [takePhotoButton setHidden:TRUE];
    }
}

- (void)setSwitchState:(id)sender
{
    BOOL state = [sender isOn];
    animal.AnimalStatusInt = state;
}

 - (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self setEditControlState];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
