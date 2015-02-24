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

@property (weak, nonatomic) IBOutlet UILabel *dineOutMessageLabel;

@property (weak, nonatomic) IBOutlet UILabel *privacyPolicyLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dineOutLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dineOutLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *createAccountLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *createAccountLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateLabels];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)updateLabels
{
    self.dineOutMessageLabel.text = @"dine out at your favorite places\n at delicious prices";
    self.dineOutMessageLabel.numberOfLines = 0;

//    CGSize sizeOfDineOutLabel =  [self.dineOutMessageLabel sizeThatFits:CGSizeMake(self.dineOutMessageLabel.frame.size.width, 100)];
//
//    self.dineOutLabelWidthConstraint.constant = sizeOfDineOutLabel.width;
//    self.dineOutLabelHeightConstraint.constant = sizeOfDineOutLabel.height;

    self.privacyPolicyLabel.text = @"by using YMMY.CLUB, you agree to the Terms of Service and Privacy Policy";
    self.privacyPolicyLabel.numberOfLines = 0;
    [self.privacyPolicyLabel sizeToFit];

    self.loginButton.backgroundColor = [UIColor colorWithRed:42/255.0 green:187/255.0 blue:155/255.0 alpha:1];

    [self.view layoutSubviews];

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
