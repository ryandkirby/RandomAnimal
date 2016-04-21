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

@synthesize animal, actualNameEdit, animalName, animalImage, backButton, doneButton, cancelButton, deleteButton, isNewAnimal, tempAnimalImage, tempAnimalName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (animal.AnimalNameStr == nil && animal.AnimalImageNameStr == nil)
    {
        isNewAnimal = true;
        [deleteButton setHidden:YES];
    }
    
    if (animal.AnimalNameStr != nil)
    {
        self.title = animal.AnimalNameStr;
        actualNameEdit.text = animal.AnimalNameStr;
    }
    
    actualNameEdit.delegate = self;
    
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
    // Display the image selection Action Sheet
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Cancel Button
    [actionSheet addAction:[UIAlertAction actionWithTitle:CANCEL_BUTTON_TEXT style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];

    // Selection Photo Gallary Button
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        [actionSheet addAction:[UIAlertAction actionWithTitle:IMAGE_SELECTION_PHOTO_GALLARY style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self selectImage:sender source:TRUE];
        }]];
    }

    // Selection Take Photo Button
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [actionSheet addAction:[UIAlertAction actionWithTitle:IMAGE_SELECTION_TAKE_PHOTO style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self selectImage:sender source:FALSE];
        }]];
    }
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)selectImage:(id)sender source:(BOOL)fromPhotoGallary
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
    [imagePicker setDelegate:self];
    
    if (fromPhotoGallary)
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
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
    tempAnimalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Put that image into the screen
    [animalImage setImage:tempAnimalImage];
    
    [doneButton setEnabled:TRUE];
    
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
    if (isNewAnimal)
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
    // If the user select done, and not cancel or back, we save off the image.
    [animal setThumbnailDataFromImage:tempAnimalImage];
    
    //Store this image in our Animal by creating a GUID for it
    CFUUIDRef newGUID = CFUUIDCreate(kCFAllocatorDefault);
    
    CFStringRef newGUIDIDString = CFUUIDCreateString(kCFAllocatorDefault, newGUID);
    
    //Now store the image and key into the dictionary
    NSString *key = (__bridge NSString *)newGUIDIDString;
    [animal setImageKey:key];
    
    [[AnimalStorageImage sharedStore] setImage:tempAnimalImage forKey:[animal imageKey]];
    
    // Clear up the memory from the strings above!
    CFRelease(newGUID);
    CFRelease(newGUIDIDString);
    
    // Store the new Animal Name
    animal.AnimalNameStr = tempAnimalName;
    
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
    
    //NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    //NSLog(@"Center Y: %f View height: %f, Keyboard height %f", self.originalCenter.y, self.view.bounds.size.height, keyboardHeight);

    self.view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y-keyboardHeight);
    
    
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
        tempAnimalName = newName;
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
