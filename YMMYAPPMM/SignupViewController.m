//
//  LoginViewController.m
//  YMMYAPPMM
//
//  Created by Edvin Lellhame on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "SignupViewController.h"
#import "User.h"
#import "Restaurant.h"

@interface SignupViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property User *user;


@end

@implementation SignupViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - UITextField(s) -

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


#pragma mark - IBAction(s) -

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

        self.user = [User user];

        self.user.email = email;
        self.user.password = password;
        self.user.username = email;
        self.user.firstName = firstname;
        self.user.lastName = lastname;
        self.user.phoneNumber = phonenumber;


        [self.user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

            if (error)
            {
                NSLog(@"%@", error);

            }
            else
            {


            }
        }];

        [self.navigationController popToRootViewControllerAnimated:YES];  // go back and move into block when have time


    }
}




@end
