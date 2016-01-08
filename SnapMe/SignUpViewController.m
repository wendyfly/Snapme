//
//  SignUpViewController.m
//  SnapMe
//
//  Created by LiaoWenwen on 1/7/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)signUp:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
     NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
     NSString *email = [self.emailField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(username.length == 0 || password.length == 0 || email.length == 0) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Oops" message: @"Please fill the username field" preferredStyle: UIAlertViewStyleDefault];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please enter username, password and email" delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        
        
        [alert show];
    }
                          
}
@end
