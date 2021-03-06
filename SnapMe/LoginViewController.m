
//
//  LoginViewController.m
//  SnapMe
//
//  Created by LiaoWenwen on 1/7/16.
//  Copyright © 2016 LiaoWenwen. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "InboxViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = true;
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:TRUE];
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

- (IBAction)login:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(username.length == 0 || password.length == 0 ) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Oops" message: @"Please fill the username and password field" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        [PFUser logInWithUsernameInBackground:username password:password
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                

                                               [self.navigationController popToRootViewControllerAnimated:YES];
                                            
                                                
                                            } else {
                                                NSLog(@"fail");
                                                UIAlertController *alertView = [UIAlertController alertControllerWithTitle: @"Oops" message: @"username and password is dismatched" preferredStyle: UIAlertControllerStyleAlert];
                                                UIAlertAction* ok = [UIAlertAction
                                                                     actionWithTitle:@"OK"
                                                                     style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction * action)
                                                                     {
                                                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                                                         
                                                                     }];
                                                UIAlertAction* cancel = [UIAlertAction
                                                                         actionWithTitle:@"Cancel"
                                                                         style:UIAlertActionStyleDefault
                                                                         handler:^(UIAlertAction * action)
                                                                         {
                                                                             [alertView dismissViewControllerAnimated:YES completion:nil];
                                                                             
                                                                         }];
                                                
                                                [alertView addAction:ok];
                                                [alertView addAction:cancel];
                                                [self presentViewController:alertView animated:YES completion:nil];
                                                
                                            }
                                        }];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
