//
//  FriendsTableViewController.h
//  SnapMe
//
//  Created by LiaoWenwen on 1/10/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsTableViewController : UITableViewController

@property (strong, nonatomic) PFRelation *friendsRelation;
@property(nonatomic, strong) NSArray *allFriends;
@end
