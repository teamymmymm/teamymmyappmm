//
//  ConfirmationViewController.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/16/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "Restaurant.h"

@interface ConfirmationViewController ()

@property (weak, nonatomic) IBOutlet UITextView *customerMessageTextView;
@property (weak, nonatomic) IBOutlet UILabel *confirmationMessageLabel;



@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleCustomerMessageTextView];
    self.restaurantNameLabel.text = self.passedRestaurantNameValue;
    self.numberOfPeopleLabel.text = [NSString stringWithFormat:@"%ld", (long)self.passedPeopleValue];
    self.dateLabel.text = self.passedDateValue;
    self.dayLabel.text = self.passedDayValue;
    self.timeLabel.text = self.passedTimeValue;

    self.confirmationMessageLabel.text = [NSString stringWithFormat:@"Your reservation party of %@ at %@ on %@ %@ is all set. Enjoy!", [NSString stringWithFormat:@"%ld", (long)self.passedPeopleValue], [NSString stringWithFormat:@"%@", self.passedRestaurantNameValue], [NSString stringWithFormat:@"%@", self.passedDayValue], [NSString stringWithFormat:@"%@" ,self.passedDateValue] ];
    [self customCloudCodeToSendMandrillEmail];
}

- (void)styleCustomerMessageTextView
{
    self.customerMessageTextView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [[self.customerMessageTextView layer] setBorderWidth:1.3];
    [[self.customerMessageTextView layer] setBorderColor:[[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1] CGColor]];
}

- (void)customCloudCodeToSendMandrillEmail
{
//    Restaurant *restaurant = [Restaurant new];
    NSString *message = [NSString stringWithFormat:@"Awesome! %@, you have a reservation for party of %ld coming in on %@, %@ at %@.",self.restaurantNameLabel.text, self.passedPeopleValue, self.passedDayValue, self.passedDateValue, self.passedTimeValue];
    [PFCloud callFunctionInBackground:@"email"
                       withParameters:@{
                                        @"text": message,
                                        @"email":@"teamymmymm@gmail.com"}
                                block:^(NSString *result, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@",result);
                                    }
                                }];
}

- (IBAction)closeButtonPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (IBAction)reserveButtonTapped:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reserved!" message:[NSString stringWithFormat:@"You're all set, enjoy the deliciousness at %@!", self.passedRestaurantNameValue] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];

    [self.navigationController popToRootViewControllerAnimated:YES];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
