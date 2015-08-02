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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Random Animal Generator";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)launchAnimalRoster:(id)sender
{
    AnimalRosterTableViewController *animalRosterTableVC = [[AnimalRosterTableViewController alloc] init];
    [[self navigationController] pushViewController:animalRosterTableVC animated:YES];
}

-(IBAction)findRandomAnimal:(id)sender
{
    NSInteger test = 1;
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
