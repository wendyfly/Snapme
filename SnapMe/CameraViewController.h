//
//  CameraViewController.h
//  SnapMe
//
//  Created by LiaoWenwen on 1/10/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UITableViewController <UINavigationBarDelegate,UIImagePickerControllerDelegate>

@property(nonatomic, strong) UIImagePickerController *imagePicker;
@end
