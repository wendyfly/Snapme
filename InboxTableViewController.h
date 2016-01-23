//
//  InboxTableViewController.h
//  SnapMe
//
//  Created by LiaoWenwen on 1/6/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MSCellAccessory.h"
@import AVKit;

@interface InboxTableViewController : UITableViewController

@property(nonatomic, strong) NSArray *messages;
@property(nonatomic, strong) PFObject *selectedMessage;
//@property(nonatomic, strong) AVPlayerViewController *moviePlayer;
@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

- (IBAction)logout:(id)sender;
@end
