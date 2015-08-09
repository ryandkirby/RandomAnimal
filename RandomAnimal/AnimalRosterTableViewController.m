//
//  AnimalRosterTableViewController.m
//  RandomAnimal
//
//  Created by Ryan Kirby on 8/1/15.
//  Copyright (c) 2015 Engby LLC. All rights reserved.
//

#import "AnimalRosterTableViewController.h"

@interface AnimalRosterTableViewController ()

@end

@implementation AnimalRosterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = ANIMAL_ROSTER_PAGE_NAME;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAnimal:)];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [[AnimalStorage sharedStorage] allItems].count;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    
    AnimalRosterTableViewCell *cell = (AnimalRosterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"AnimalRosterTableViewCell"];
    
    
    // If there is no cell queued offscreen, make a new one
    if (!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AnimalRosterTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (cell)
    {
        NSArray* animalRoster = [[AnimalStorage sharedStorage] allItems];
        if (animalRoster.count > 0)
        {
            Animal *a = [animalRoster objectAtIndex:indexPath.row];
            [[cell animalName] setText:a.AnimalNameStr];
            cell.animalName.textColor = a.AnimalStatusInt ? [UIColor blackColor] : [UIColor lightGrayColor];
            
            // Load the image if it exists
            UIImage *img = [[AnimalStorageImage sharedStore] imageForKey:[a imageKey]];
            
            if (img !=nil)
            {
                [[cell animalImageImage] setImage:img];
            }
        }
    }
    
    return cell;
}

-(IBAction)addAnimal:(id)sender
{
    
}


// Override to support conditional editing of the table view.
/*- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    AnimalViewController *animalViewController = [[AnimalViewController alloc] init];
    
    // Pass the selected object to the new view controller.
    NSArray* animalRoster = [[AnimalStorage sharedStorage] allItems];
    if (animalRoster.count > 0)
    {
        Animal *a = [animalRoster objectAtIndex:indexPath.row];
        animalViewController.animal = a;
    }

    // Push the view controller.
    [self.navigationController pushViewController:animalViewController animated:YES];
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
