//
//  RandomAnimalViewController.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "RandomAnimalViewController.h"
#import "AnimalRosterTableViewController.h"
#import "OffsetLabel.h"

@interface RandomAnimalViewController ()

@end

@implementation RandomAnimalViewController

@synthesize animalImage, previousScreenSize;

const float RANDOM_BUTTON_RADIUS = 60.0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = APP_NAME_STR;

    // Set the System Bar Color
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    // Set the right gear settings icon
    UIImage *settingsGearImage = [UIImage imageNamed:APP_SETTINGS_GEAR];
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingsButton.bounds = CGRectMake( 0, 0, SETTING_BUTTON_SIZE, SETTING_BUTTON_SIZE);
    [settingsButton setImage:settingsGearImage forState:UIControlStateNormal];
    UIBarButtonItem *settingsGearBarBtn = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    [settingsButton addTarget:self action:@selector(launchAnimalRoster:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = settingsGearBarBtn;

    // Set up the navigation bar color
    UIColor *headerColor = [[UIColor alloc] initWithRed:(22/255.0) green:(145/255.0) blue:(226/255.0) alpha:1];
    
    self.navigationController.navigationBar.barTintColor = headerColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Background Color
    UIColor *bgColor = [[UIColor alloc]initWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.view.backgroundColor = bgColor;
    
    // Set the back button of the next navigation controller 'Animal Roster'
    UIBarButtonItem *backbutton =  [[UIBarButtonItem alloc] initWithTitle:BACK_BUTTON_TEXT style:UIBarButtonItemStylePlain target:self action:nil];
    
    [backbutton setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont fontWithName:ANIMAL_APP_FONT size:21.0],
                                         NSForegroundColorAttributeName: [UIColor whiteColor]
                                         } forState:UIControlStateNormal];
    
    self.navigationItem.backBarButtonItem = backbutton;
        
    // Setting the status bar to White
   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // Set up default screensize
    previousScreenSize = self.view.bounds;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    animalName.text = @"";
    
    [animalImage setImage:nil];
    [self ImageDropShadowEnabled:FALSE];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Set the title bar font
    CGRect layerRect = self.view.bounds;
    
    if (layerRect.size.height != previousScreenSize.size.height &&
        layerRect.size.width != previousScreenSize.size.width)
    {
        previousScreenSize = layerRect;
    
        OffsetLabel *label = [[OffsetLabel alloc] initWithFrame:CGRectMake(0, 0, layerRect.size.width, 44)];
        
        label.font = [UIFont fontWithName:ANIMAL_APP_FONT size:21.0];
        label.shadowColor = [UIColor clearColor];
        label.textColor =[UIColor whiteColor];
        label.text = self.title;
        label.textAlignment = NSTextAlignmentCenter;
        [label setRightOffset:SETTING_BUTTON_SIZE];
        self.navigationItem.titleView = label;
    
        // Add Gradient to button
        CAGradientLayer *layer = [CAGradientLayer layer];
        NSArray *colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:(7/255.0) green:(183/255.0) blue:(247/255.0) alpha:1].CGColor,
                       (id)[UIColor colorWithRed:(22/255.0) green:(145/255.0) blue:(226/255.0) alpha:1].CGColor,
                       nil];
        [layer setColors:colors];
        layerRect.origin.y = layerRect.size.height - 70;
        layerRect.size.height = 70;
        [layer setFrame:layerRect];
        [self.view.layer insertSublayer:layer atIndex:0];
    
        // Set up round button
        randomAnimalButton = [UIButton alloc];
        randomAnimalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //randomAnimalButton.imageView.bounds = CGRectMake( 0, 0, SETTING_BUTTON_SIZE, SETTING_BUTTON_SIZE);

        //randomAnimalButton.bounds = CGRectMake( 0, 0, SETTING_BUTTON_SIZE, SETTING_BUTTON_SIZE);
        //UIImage *settingsGearImage = [UIImage imageNamed:RANDOM_BUTTON_PAW_IMAGE_NAME];
        //UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //settingsButton.bounds = CGRectMake( 0, 0, SETTING_BUTTON_SIZE, SETTING_BUTTON_SIZE);
        
        [randomAnimalButton setImage:[UIImage imageNamed:RANDOM_BUTTON_PAW_IMAGE_NAME] forState:UIControlStateNormal];
        [randomAnimalButton setImage:[UIImage imageNamed:RANDOM_BUTTON_PAW_IMAGE_NAME] forState:UIControlStateHighlighted];

    
        [randomAnimalButton addTarget:self action:@selector(findRandomAnimal:) forControlEvents:UIControlEventTouchUpInside];
    
        //width and height should be same value
        randomAnimalButton.frame = CGRectMake((layerRect.size.width/2)-(RANDOM_BUTTON_RADIUS/2), layerRect.origin.y+5, RANDOM_BUTTON_RADIUS, RANDOM_BUTTON_RADIUS);
        randomAnimalButton.clipsToBounds = YES;
        randomAnimalButton.layer.cornerRadius = RANDOM_BUTTON_RADIUS/2;//half of the width
        //randomAnimalButton.layer.borderColor=[UIColor redColor].CGColor;
        randomAnimalButton.layer.borderWidth=0.0f;
        randomAnimalButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
        // Drop Shadow
        randomAnimalButton.layer.shadowColor = [UIColor blackColor].CGColor;
        randomAnimalButton.layer.shadowOpacity = 0.3;
        randomAnimalButton.layer.shadowRadius = RANDOM_BUTTON_RADIUS/2;
        randomAnimalButton.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    
        [self.view addSubview:randomAnimalButton];
    
        // Image border
        UIColor *imageBorderColor = [[UIColor alloc]initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
        [animalImage.layer setBorderColor: [imageBorderColor CGColor]];
        [animalImage.layer setBorderWidth: 1.0];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)launchAnimalRoster:(id)sender
{
    animalName.text = @"";
    AnimalRosterTableViewController *animalRosterTableVC = [[AnimalRosterTableViewController alloc] init];
    //AnimalViewController *animalVC = [[AnimalViewController alloc] init];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        /*
        // Create a view controller for the detail view
        UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:animalVC];
        
        // Create an array of the Animal items
        NSArray *animalRosterItems = [NSArray  arrayWithObjects:animalRosterTableVC, detailNav, nil];
        
        // Create the split view
        UISplitViewController *animalRosterSVC = [[UISplitViewController alloc] init];
     
        // Set the deliate of the split view controller to be the detail VC.
        [animalRosterSVC setDelegate:animalVC];
        [animalRosterSVC setViewControllers:animalRosterItems];
        
        AppDelegate *wibAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        wibAppDelegate.window.rootViewController = animalRosterSVC;
        */
        
        [[self navigationController] pushViewController:animalRosterTableVC animated:YES];
    }
    else
    {
        [[self navigationController] pushViewController:animalRosterTableVC animated:YES];
    }
}

-(IBAction)findRandomAnimal:(id)sender
{
    NSArray* animalRoster = [[AnimalStorage sharedStorage] allItems];
    [animalImage setImage:nil];
    BOOL activeAnimalFound = FALSE;
    
    if (animalRoster.count > 0)
    {
        NSUInteger randomVal = 0;
        
        // Loop until an active animal is found
        do
        {
            randomVal = arc4random() % animalRoster.count;
        
            Animal *randomA =  [animalRoster objectAtIndex:randomVal];
            
            if (randomA.AnimalStatusInt == 1)
            {
                activeAnimalFound= TRUE;
                animalName.text = randomA.AnimalNameStr;

                // Load the image if it exists
                UIImage *img = [[AnimalStorageImage sharedStore] imageForKey:[randomA imageKey]];
                
                int actualHeight = img.size.height;
                int actualWidth = img.size.width;
                
                if (img != nil)
                {
                    [self ImageDropShadowEnabled:FALSE];
                    
                    // Set up a default background image that can be used as a transition layer
                    UIColor *defaultBGImageColor = [[UIColor alloc]initWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
                    
                    UIImage *defaultBGimage = [self squareImageWithColor:defaultBGImageColor dimensionWidth:actualWidth dimensionHeight:actualHeight];
                    
                    // Create a transition for showing the image
                    [UIView transitionWithView:self.animalImage
                                      duration:0.0f
                                       options:UIViewAnimationOptionTransitionCrossDissolve
                                    animations:^{
                                        animalImage.image = defaultBGimage;
                                    }
                                    completion:^(BOOL finished)
                    {
                                        if (finished)
                                        {
                                            [self ImageDropShadowEnabled:TRUE];
                                            [UIView transitionWithView:self.animalImage
                                                              duration:SELECTION_ANIMATION_SPEED
                                                               options:UIViewAnimationOptionTransitionCrossDissolve
                                                            animations:^{
                                                                animalImage.image = img;
                                                            } completion:nil];
                                        }
                                    }];
                }
                else
                {
                    [self ImageDropShadowEnabled:FALSE];
                }
            }
        } while (activeAnimalFound == FALSE);
    }
    else
    {
        NSString *noAnimalText = nil;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            noAnimalText = NO_ANIMALS_BUTTON_TEXT;
        }
        else
        {
            noAnimalText = NO_ANIMALS_BUTTON_TEXT_IPHONE;
        }
        
        NSLog(@"No items available to randomize.");
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:noAnimalText preferredStyle:UIAlertControllerStyleActionSheet];
        
        // Cancel Button
        [actionSheet addAction:[UIAlertAction actionWithTitle:GOT_IT_BUTTON_TEXT style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        // Set the position of the popup warning
        actionSheet.popoverPresentationController.sourceView = self.view;
        CGRect settingModalPosition = CGRectMake(self.navigationController.navigationBar.bounds.origin.x, self.navigationController.navigationBar.bounds.origin.y, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height);
        settingModalPosition.origin.x = self.view.bounds.size.width;
        settingModalPosition.origin.y = settingModalPosition.size.height *2.5;
        actionSheet.popoverPresentationController.sourceRect = settingModalPosition;
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
}

-(void)generateRandomAnimal
{
    
}

- (UIImage *)squareImageWithColor:(UIColor *)color dimensionWidth:(int)dimWidth dimensionHeight:(int)dimHeight
{
    CGRect rect = CGRectMake(0, 0, dimWidth, dimHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)ImageDropShadowEnabled:(BOOL)enable
{
    if (enable)
    {
        // Add drop shadow
        animalImage.layer.shadowColor = [UIColor blackColor].CGColor;
        animalImage.layer.shadowOffset = CGSizeMake(4, 4);
        animalImage.layer.shadowOpacity = 0.5;
        animalImage.layer.shadowRadius = 2.0;
        animalImage.clipsToBounds = NO;
        [animalImage.layer setBorderWidth: 0.0];
    }
    else
    {
        // Remove drop shadow
        animalImage.layer.shadowColor = [UIColor blackColor].CGColor;
        animalImage.layer.shadowOffset = CGSizeMake(0, 0);
        animalImage.layer.shadowOpacity = 0.0;
        animalImage.layer.shadowRadius = 0.0;
        animalImage.clipsToBounds = NO;
        [animalImage.layer setBorderWidth: 1.0];
    }
}

@end
