//
//  LoginViewController.m
//  YMMYAPPMM
//
//  Created by Edvin Lellhame on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "SignupViewController.h"
#import "User.h"

@interface SignupViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation SignupViewController


- (void)viewDidLoad
{
    [super viewDidLoad];


    self.firstNameTextField.delegate = self;


}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.firstNameTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO];
}



- (IBAction)onSignupButtonPressed:(UIButton *)sender
{
    NSString *firstname = [self.firstNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *lastname = [self.lastNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *phonenumber = [self.phoneNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if (firstname.length == 0 || lastname.length == 0 || email.length == 0 || phonenumber.length == 0 || password.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please enter a First name, Last name, Email, and Phone number." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        User *user = [[User alloc] init];
        user.firstName = firstname;
        user.lastName = lastname;
        user.email = email;
        user.phoneNumber = phonenumber;
        user.password = password;
        user.username = email;

        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}




























@end
