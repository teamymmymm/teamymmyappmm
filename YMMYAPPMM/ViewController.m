//
//  ViewController.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *homefeedTableView;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
<<<<<<< HEAD

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
=======
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



>>>>>>> e1faa4dc05a31f1f6e0581fbce67769b2d2c824e
@end
