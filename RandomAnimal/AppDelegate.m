//
//  AppDelegate.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "RandomAnimalViewController.h"
#import "AnimalStorage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    Animal *a = [[AnimalStorage sharedStorage] createItem];
    [a setAnimalNameStr:@"Pinko"];
    [a setAnimalStatusInt:1];
    
    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"Blacko"];
    [a setAnimalStatusInt:1];

    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"Orango"];
    [a setAnimalStatusInt:1];
    
    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"Ozzie"];
    [a setAnimalStatusInt:1];
    
    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"Shaun"];
    [a setAnimalStatusInt:1];
    
    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"Gromit"];
    [a setAnimalStatusInt:1];

    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"José"];
    [a setAnimalStatusInt:1];
    
    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"The Alley Cats"];
    [a setAnimalStatusInt:1];
    
    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"The Aardman Crew"];
    [a setAnimalStatusInt:1];
    
    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"The Dream Team"];
    [a setAnimalStatusInt:1];
    
    a = [[AnimalStorage sharedStorage] createItem];
    [a  setAnimalNameStr:@"Los Mexicanos"];
    [a setAnimalStatusInt:1];
    */
     
    RandomAnimalViewController *randomAnimalVC = [[RandomAnimalViewController alloc] init];
    UINavigationController *randomAnimalNavController = [[UINavigationController alloc] initWithRootViewController:randomAnimalVC];
    
    [[self window] setRootViewController:randomAnimalNavController];
    
    [self.window makeKeyAndVisible];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    BOOL success = [[AnimalStorage sharedStorage] saveChanges];
    
    if (success)
    {
        NSLog(@"All animals in Roster saved");
    }
    else
    {
        NSLog(@"Could not save animal Roster");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
