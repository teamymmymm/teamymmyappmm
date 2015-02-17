//
//  ConfirmationViewController.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/16/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "ConfirmationViewController.h"

@interface ConfirmationViewController ()

@property (weak, nonatomic) IBOutlet UITextView *customerMessageTextView;



@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleCustomerMessageTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)styleCustomerMessageTextView
{
    self.customerMessageTextView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [[self.customerMessageTextView layer] setBorderWidth:1.3];
    [[self.customerMessageTextView layer] setBorderColor:[[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1] CGColor]];
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
