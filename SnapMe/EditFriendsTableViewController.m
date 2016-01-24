//
//  EditFriendsTableViewController.m
//  SnapMe
//
//  Created by LiaoWenwen on 1/9/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import "EditFriendsTableViewController.h"
#import "GravatarUrlBuilder.h"

@interface EditFriendsTableViewController ()

@end

@implementation EditFriendsTableViewController

UIColor *disclosureColor;

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
    disclosureColor = [UIColor colorWithRed:0 green:0.545 blue:0.545 alpha:1];
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
        cell.accessoryView =  [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color: disclosureColor];
    } else {
        cell.accessoryView = nil;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        //1.get email address
        NSString *emal = [user objectForKey:@"email"];
        //2.create the md5 hash
        NSURL *gravataUrl = [GravatarUrlBuilder getGravatarUrl:emal];
        
        //3.request the image from gravatar
        
        NSData *imageData = [NSData dataWithContentsOfURL:gravataUrl];
        
        if(imageData !=nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //4.Set image in cell
                
                cell.imageView.image = [UIImage imageWithData: imageData];
                [cell setNeedsLayout];
            });
        }
        
    });
    cell.imageView.image = [UIImage imageNamed:@"userProfile.png"];

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
        cell.accessoryView = nil;
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
        cell.accessoryView =  [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color: disclosureColor];
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
