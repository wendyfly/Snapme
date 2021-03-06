//
//  FriendsTableViewController.m
//  SnapMe
//
//  Created by LiaoWenwen on 1/10/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "EditFriendsTableViewController.h"
#import "GravatarUrlBuilder.h"

@interface FriendsTableViewController ()

@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateTable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTable];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"editFriends"]) {
        EditFriendsTableViewController *viewController = (EditFriendsTableViewController *)segue.destinationViewController;
        viewController.friends = [NSMutableArray arrayWithArray:self.allFriends];
        
    } 
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allFriends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFUser *user = [self.allFriends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Helper method

-(void) updateTable {
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            self.allFriends = objects;
            [self.tableView reloadData];
        }
    }];

}

@end
