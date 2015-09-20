//
//  ViewController.m
//  FlashApp
//
//  Created by Monte's Pro 13" on 9/19/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import "ViewController.h"
#import "Location.h"
<<<<<<< HEAD
#import "User.h"
#import "ProfileViewController.h"
=======
>>>>>>> 12fed1c745b84004b4856b5c3a5994c7ce018598
#import "DetailViewController.h"

@interface ViewController ()
{
<<<<<<< HEAD
ProfileViewController *_profile;
NSArray *_feedItems;
User *_selectedUser;
=======
HomeModel *_homeModel;
NSArray *_feedItems;
Location *_selectedLocation;
>>>>>>> 12fed1c745b84004b4856b5c3a5994c7ce018598
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
<<<<<<< HEAD
 //   NSLog(@"Hello");
  //  [self performSegueWithIdentifier:@"loginView" sender:nil];
  //  NSLog(@"Hello 123");
=======
>>>>>>> 12fed1c745b84004b4856b5c3a5994c7ce018598
    // Set this view controller object as the delegate and data source for the table view
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
<<<<<<< HEAD
    _profile = [[ProfileViewController alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _profile.delegate = self;
    
    // Call the download items method of the home model object
    [_profile downloadItems];
=======
    _homeModel = [[HomeModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _homeModel.delegate = self;
    
    // Call the download items method of the home model object
    [_homeModel downloadItems];
>>>>>>> 12fed1c745b84004b4856b5c3a5994c7ce018598
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    // Reload the table view
    [self.listTableView reloadData];
}

#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of feed items (initially 0)
    NSLog(@"count %d",_feedItems.count);
    return _feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve cell
    NSString *cellIdentifier = @"PrototypeCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
<<<<<<< HEAD
    NSLog(@"This is feeditems %s", _feedItems);
    
    // Get the location to be shown
    User *item = _feedItems[indexPath.row];
    
    // Get references to labels of cell
    myCell.textLabel.text = item.name;
    
    NSLog(@"This is the address %s", item.name);
   //     myCell.textLabel.text = @"User1";
=======
    // Get the location to be shown
    Location *item = _feedItems[indexPath.row];
    
    // Get references to labels of cell
    myCell.textLabel.text = item.address;
  //  NSLog(@"This is the address %s", item.address);
   //     myCell.textLabel.text = @"1192 Market St San Francisco, CA 94102";
>>>>>>> 12fed1c745b84004b4856b5c3a5994c7ce018598
  
    return myCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set selected location to var
<<<<<<< HEAD
    _selectedUser = _feedItems[indexPath.row];
=======
    _selectedLocation = _feedItems[indexPath.row];
>>>>>>> 12fed1c745b84004b4856b5c3a5994c7ce018598
    
    // Manually call segue to detail view controller
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
<<<<<<< HEAD
//    // Get reference to the destination view controller
//    DetailViewController *detailVC = segue.destinationViewController;
//    
//    // Set the property to the selected location so when the view for
//    // detail view controller loads, it can access that property to get the feeditem obj
//    detailVC.selectedUser = _selectedUser;
=======
    // Get reference to the destination view controller
    DetailViewController *detailVC = segue.destinationViewController;
    
    // Set the property to the selected location so when the view for
    // detail view controller loads, it can access that property to get the feeditem obj
    detailVC.selectedLocation = _selectedLocation;
>>>>>>> 12fed1c745b84004b4856b5c3a5994c7ce018598
}

@end
