//
//  ImageViewController.m
//  SnapMe
//
//  Created by LiaoWenwen on 1/17/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFFile *imageFile = [self.message objectForKey: @"file"];
    NSURL *imageFileUrl = [[NSURL alloc] initWithString: imageFile.url];
    NSData *imageData = [ NSData dataWithContentsOfURL:imageFileUrl];
    self.imageView.image = [UIImage imageWithData:imageData];
    NSString *senderName = [self.message objectForKey:@"senderName"];
    NSString *title = [NSString stringWithFormat:@"Sent from %@", senderName];
    self.navigationItem.title = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
