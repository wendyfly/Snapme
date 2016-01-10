//
//  EditFriendsTableViewController.h
//  SnapMe
//
//  Created by LiaoWenwen on 1/9/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditFriendsTableViewController : UITableViewController

@property(nonatomic, strong) NSArray *allUsers;

@property(nonatomic, strong) PFUser *currentUser;
@end
