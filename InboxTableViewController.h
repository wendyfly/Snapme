//
//  InboxTableViewController.h
//  SnapMe
//
//  Created by LiaoWenwen on 1/6/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface InboxTableViewController : UITableViewController

@property(nonatomic, strong) NSArray *messages;
@property(nonatomic, strong) PFObject *selectedMessage;

- (IBAction)logout:(id)sender;
@end
