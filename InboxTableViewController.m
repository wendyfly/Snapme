//
//  InboxTableViewController.m
//  SnapMe
//
//  Created by LiaoWenwen on 1/6/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import "InboxTableViewController.h"
#import "ImageViewController.h"


@interface InboxTableViewController ()

@end

@implementation InboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
    } else {
        [self performSegueWithIdentifier:@"showLogin" sender: self];

    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([[PFUser currentUser] objectId] != nil ) {
        PFQuery *query = [ PFQuery queryWithClassName:@"Messages"];
        [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if(error) {
                NSLog(@"Error : %@ %@", error,[error userInfo]);
            } else {
                // we found the messages
                self.messages = objects;
                [self.tableView reloadData];
                NSLog(@"Retrieved %d messages", [self.messages count]);
            }
        }];

    }
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
    return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = [message objectForKey: @"senderName"];
    NSString *fileType = [message objectForKey:@"fileType"];
    if([fileType isEqualToString: @"image"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
   self.selectedMessage = [self.messages objectAtIndex:indexPath.row];
    NSString *fileType = [self.selectedMessage objectForKey:@"fileType"];
    if([fileType isEqualToString: @"image"]) {
        [self performSegueWithIdentifier:@"showImage" sender:self];
    } else {
    
    }
}


- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:true];
    }
    if([segue.identifier isEqualToString:@"showImage"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:true];
        ImageViewController *imageViewController = (ImageViewController *) segue.destinationViewController;
        imageViewController.message = self.selectedMessage;
    }
}
@end
