//
//  AnimalEditViewController.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 10/3/15.
//  Copyright © 2015 Engby LLC. All rights reserved.
//

#import "AnimalEditViewController.h"

@interface AnimalEditViewController ()

@end

@implementation AnimalEditViewController

@synthesize animal, actualNameEdit, animalName, animalImage, backButton, doneButton, cancelButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (animal != nil)
    {
        self.title = animal.AnimalNameStr;
        actualNameEdit.delegate = self;
        actualNameEdit.text = animal.AnimalNameStr;
    }
    
    // Set up the left and right buttons on the view
    cancelButton = [[UIBarButtonItem alloc] initWithTitle:CANCEL_BUTTON_TEXT style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    doneButton = [[UIBarButtonItem alloc] initWithTitle:SAVE_BUTTON_TEXT style:UIBarButtonItemStylePlain target:self action:@selector(doneAction:)];
    backButton = [[UIBarButtonItem alloc] initWithTitle:BACK_BUTTON_TEXT style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
    // Set button font and color
    [cancelButton setTitleTextAttributes:@
     { NSFontAttributeName: [UIFont fontWithName:ANIMAL_APP_FONT size:21.0], NSForegroundColorAttributeName: [UIColor whiteColor]
     } forState:UIControlStateNormal];
    
    // Set Done button enable/disable
    [doneButton setTitleTextAttributes:@
     { NSFontAttributeName: [UIFont fontWithName:ANIMAL_APP_FONT size:21.0], NSForegroundColorAttributeName: [UIColor whiteColor]
     } forState:UIControlStateNormal];
    [doneButton setTitleTextAttributes:@
    { NSFontAttributeName: [UIFont fontWithName:ANIMAL_APP_FONT size:21.0], NSForegroundColorAttributeName: [UIColor colorWithWhite:1.0 alpha:0.5]
    } forState:UIControlStateDisabled];
    
    [backButton setTitleTextAttributes:@
     { NSFontAttributeName: [UIFont fontWithName:ANIMAL_APP_FONT size:21.0], NSForegroundColorAttributeName: [UIColor whiteColor]
     } forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = cancelButton;

    [doneButton setEnabled:FALSE];
    
    // Register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    // Setting done button on keyboard
    [actualNameEdit setReturnKeyType:UIReturnKeyDone];
    
    // Set the image
    UIImage *img = [[AnimalStorageImage sharedStore] imageForKey:[animal imageKey]];
    if (img)
    {
        [animalImage setImage:img];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // Record the original center for the keyboard popup
    if (self.originalCenter.x == 0 && self.originalCenter.y == 0)
    {
        self.originalCenter = self.view.center;
        NSLog(@"Center X:%f Y:%f", self.view.center.x, self.view.center.y);
    }
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
    
    [doneButton setEnabled:TRUE];
    
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

-(IBAction)cancelAction:(id)sender
{
    if (animal.AnimalNameStr == nil)
    {
        [[AnimalStorage sharedStorage] removeItem:animal];
    }
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)backAction:(id)sender
{
    [actualNameEdit resignFirstResponder];
}

-(IBAction)doneAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)deleteAnimal:(id)sender
{
    [[AnimalStorage sharedStorage] removeItem:animal];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)keyboardDidShow:(NSNotification *)note

{
    NSDictionary *info  = note.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    self.view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y-keyboardHeight+ KEYBOARD_ADJUST_HEIGHT);
    
    // Adjust the cancel button to edit
    self.navigationItem.leftBarButtonItem = backButton;
    
    // Disable navigation controls while keyboard is displayed
    self.navigationItem.rightBarButtonItem = NULL;
    
}

- (void)keyboardDidHide:(NSNotification *)note
{
    self.view.center = self.originalCenter;
    
    // Enable navigation controls when keyboard is dismissed
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSString *newName = textField.text;
    
    if (newName.length > 0)
    {
        [doneButton setEnabled:TRUE];
        animal.AnimalNameStr = newName;
        self.title = newName;
        self.navigationItem.rightBarButtonItem.enabled = TRUE;
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [actualNameEdit resignFirstResponder];
}

- (void)setDoneButtonState:(bool)enable_button
{
    [doneButton setEnabled:enable_button];
    
}

@end
