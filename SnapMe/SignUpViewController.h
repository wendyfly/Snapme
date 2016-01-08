//
//  SignUpViewController.h
//  SnapMe
//
//  Created by LiaoWenwen on 1/7/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)signUp:(id)sender;

@end
