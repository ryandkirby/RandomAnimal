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

@synthesize animalImage, animalName, animal;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (animal != nil)
    {
        self.title = animal.AnimalNameStr;
        
        if (animal.AnimalNameStr != nil)
        {
            animalName.text = animal.AnimalNameStr;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [animalImage setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
