//
//  LoginViewController.m
//  YMMYAPPMM
//
//  Created by Edvin Lellhame on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "LoginViewController.h"

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
    NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    
}


@end
