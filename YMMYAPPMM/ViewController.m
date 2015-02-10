//
//  ViewController.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    PFUser *currentUser = [PFUser currentUser];
    if (currentUser)
    {
        NSLog(@"%@", currentUser);
    }
    else
    {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}



@end
