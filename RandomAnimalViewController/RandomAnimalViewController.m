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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = APP_NAME_STR;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    animalName.text = @"";
    [animalImage setImage:nil];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[UIColor blueColor].CGColor,
                       (id)[UIColor redColor].CGColor,
                       nil];
    [layer setColors:colors];
    [layer setFrame:randomAnimalButton.bounds];
    [randomAnimalButton.layer insertSublayer:layer atIndex:0];
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
        
                if (img !=nil)
                {
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
