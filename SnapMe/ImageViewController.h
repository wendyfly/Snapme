//
//  ImageViewController.h
//  SnapMe
//
//  Created by LiaoWenwen on 1/17/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController

@property(nonatomic,strong) PFObject *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
