//
//  LoginViewController.m
//  YMMYAPPMM
//
//  Created by Edvin Lellhame on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)onLoginButtonPressed:(UIButton *)sender
{
    NSString *username = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];



    if ([username length] == 0 || [password length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                        message:@"Make sure you enter a username and password."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [User logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error)
            {
                NSLog(@"%@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                NSLog(@"Success");

                User *user = [User currentUser];
                PFUser *currentUser = [PFUser currentUser];

                NSLog(@"LoginViewController - User: %@", user.username);
                NSLog(@"LoginViewController - PFUser: %@", currentUser.username);


            }

        }];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


@end
