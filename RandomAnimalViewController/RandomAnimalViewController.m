//
//  RandomAnimalViewController.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "RandomAnimalViewController.h"
#import "AnimalRosterTableViewController.h"

@interface RandomAnimalViewController ()

@end

@implementation RandomAnimalViewController

@synthesize animalImage;
@synthesize randomAnimalButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = APP_NAME_STR;

    // Set up the navigation bar setting icon
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStylePlain target:self  action:@selector(launchAnimalRoster:)];

    UIFont *customFont = [UIFont fontWithName:@"Helvetica" size:30.0];
    NSDictionary *fontDictionary = @{NSFontAttributeName : customFont};
    [settingsButton setTitleTextAttributes:fontDictionary forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = settingsButton;
 
    // Set up the navigation bar color
    UIColor *headerColor = [[UIColor alloc] initWithRed:(7/255.0) green:(183/255.0) blue:(247/255.0) alpha:1];
    
    self.navigationController.navigationBar.barTintColor = headerColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.translucent = YES;
    
    // Background Color
    UIColor *bgColor = [[UIColor alloc]initWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.view.backgroundColor = bgColor;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    animalName.text = @"";
    [animalImage setImage:nil];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Add Gradient to button
    CAGradientLayer *layer = [CAGradientLayer layer];
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:(7/255.0) green:(183/255.0) blue:(247/255.0) alpha:1].CGColor,
                       (id)[UIColor colorWithRed:(22/255.0) green:(145/255.0) blue:(226/255.0) alpha:1].CGColor,
                       nil];
    [layer setColors:colors];
    CGRect layerRect = self.view.bounds;
    layerRect.origin.y = layerRect.size.height - 70;
    layerRect.size.height = 70;
    [layer setFrame:layerRect];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    randomAnimalButton.layer.cornerRadius = 10.0f;
    randomAnimalButton.layer.borderWidth = 1.0f;
    randomAnimalButton.clipsToBounds = YES;
    [randomAnimalButton.layer setMasksToBounds:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)launchAnimalRoster:(id)sender
{
    animalName.text = @"";
    AnimalRosterTableViewController *animalRosterTableVC = [[AnimalRosterTableViewController alloc] init];
    [[self navigationController] pushViewController:animalRosterTableVC animated:YES];
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
        
                if (img != nil)
                {
                    // Add drop shadow
                    animalImage.layer.shadowColor = [UIColor blackColor].CGColor;
                    animalImage.layer.shadowOffset = CGSizeMake(4, 4);
                    animalImage.layer.shadowOpacity = 0.5;
                    animalImage.layer.shadowRadius = 2.0;
                    animalImage.clipsToBounds = NO;
                    
                    [animalImage setImage:img];
                }
            }
        } while (activeAnimalFound == FALSE);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
