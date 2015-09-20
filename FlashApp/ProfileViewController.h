//
//  ProfileViewController.h
//  FlashApp
//
//  Created by Monte's Pro 13" on 9/20/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileViewControllerProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end


@interface ProfileViewController : UIViewController <NSURLConnectionDataDelegate>
@property (nonatomic, weak) id<ProfileViewControllerProtocol> delegate;

- (void) downloadItems;

@end



