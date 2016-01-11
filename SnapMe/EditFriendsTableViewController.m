//
//  EditFriendsTableViewController.m
//  SnapMe
//
//  Created by LiaoWenwen on 1/9/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import "EditFriendsTableViewController.h"

@interface EditFriendsTableViewController ()

@end

@implementation EditFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"Eoor: %@ %@", error, [error userInfo]);
        } else {
            self.allUsers = objects;
            [self.tableView reloadData];
        }
    }];
    self.currentUser = [PFUser currentUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    if([self isFriend:user]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    //adding users in ui
    UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];

    
    if( [self isFriend:user]) {
        // 1.remove the checkmark
        cell.accessoryType = UITableViewCellAccessoryNone;
        // 2.remove from friends array
        for (PFUser *user1 in self.friends) {
            if([user1.objectId isEqualToString: user.objectId]) {
                [self.friends removeObject:user1];
                break;
            }
        }
        // 3. remove from relation table
        [friendsRelation removeObject:user];
    }  else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.friends addObject:user];
        [friendsRelation addObject:user];
    
    }
    
    [self.currentUser saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
        if(error) {
            NSLog(@"Eoor: %@ %@", error, [error userInfo]);
        } else {
            
        }
    }];

}

#pragma mark -Helper methods

-(BOOL) isFriend:(PFUser *)user {
    for (PFUser *user1 in self.friends) {
        if([user1.objectId isEqualToString: user.objectId]) {
            return true;
        }
    }
    return false;
};

@end
