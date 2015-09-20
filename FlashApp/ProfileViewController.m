//
//  ProfileViewController.m
//  FlashApp
//
//  Created by Monte's Pro 13" on 9/20/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"

@interface ProfileViewController ()
{
NSMutableData *_downloadedData;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"HEllo");
    [self performSegueWithIdentifier:@"loginView" sender:self];
    NSLog(@"HEllo 123");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadItems
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://104.245.36.70/FlashApp/api/keywords/keywords/1"];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the profiles
    NSMutableArray *_profiles = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:_downloadedData options:kNilOptions error:&error];
    // Loop through Json objects, create question objects and add them to our questions array
    NSLog(@"The count is here: %d",jsonData.count);
 //   NSLog(@"array: %@", jsonData);
    NSArray *jsonArray = [jsonData objectForKey: @"jobs"];
    
    NSLog(@"jobs...... %@", jsonArray);

    for (int i = 0; i < jsonArray.count; i++)
            {
                NSDictionary *jsonElement = jsonArray[i];
        
                // Create a new location object and set its props to JsonElement properties
                User *newUser = [[User alloc] init];
                newUser.name = jsonElement[@"name"];
                newUser.jobid = jsonElement[@"jobid"];
                newUser.phone = jsonElement[@"phone"];
                
                // Add this question to the locations array
                [_profiles addObject:newUser];
            }
    
if (self.delegate)
{
    [self.delegate itemsDownloaded:_profiles];
}
}



//    // Create an array to store the locations
//    NSMutableArray *_locations = [[NSMutableArray alloc] init];
//    
//    // Parse the JSON that came in
//    NSError *error;
//    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
//    NSLog(@"array: %@", jsonArray);
//    
//    // Loop through Json objects, create question objects and add them to our questions array
//    for (int i = 0; i < jsonArray.count; i++)
//    {
//        NSDictionary *jsonElement = jsonArray[i];
//        
//        // Create a new location object and set its props to JsonElement properties
//        Location *newLocation = [[Location alloc] init];
//        newLocation.name = jsonElement[@"name"];
//        newLocation.address = jsonElement[@"address"];
//        newLocation.latitude = jsonElement[@"latitude"];
//        newLocation.longitude = jsonElement[@"longitude"];
//        
//        // Add this question to the locations array
//        [_locations addObject:newLocation];
//    }
//

    
    
    
    
    
    
    
    
    //  NSArray *jsonArray = jsonData[0];
//    NSLog(@"Feeds of 0th element...%@",jsonData[0]);
  
  //  NSDictionary *jsonElement = jsonData[0];
   // for (int i=0; i< jsonData[0].count; i++) {
           //     NSLog(@"Feeds...%@",jsonElement[@"name"]);
   // }

//        
//        // Create a new User object and set its props to JsonElement properties
//        for (int i = 0; i < jsonElement.count; i++)
//        {
//        NSLog(@"The name is", jsonElement[i][i][@"name"]);
//        }
    
//        User *newUser = [[User alloc] init];
//        newUser.name = jsonElement[@"name"];
//        newUser.jobid = jsonElement[@"jobid"];
//        newUser.phone = jsonElement[@"phone"];
//        
        
            
        // Add this question to the locations array
//        [_profiles addObject:newUser];
   // }
    
    // Ready to notify delegate that data is ready and pass back items

@end
