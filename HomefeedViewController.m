//
//  HomefeedViewController.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/11/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "HomefeedViewController.h"
#import "DetailHomefeedTableViewCell.h"
#import "Restaurant.h"
#import <Parse/Parse.h>
#import "DetailRestaurantViewViewController.h"
#import "User.h"

@interface HomefeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *restaurantsArray;
@property NSMutableArray *restaurantImagesArray;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;


@end

@implementation HomefeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    User *currentUser = [User currentUser];
    if (currentUser)
    {
        //NSLog(@"%@", user.username);
        // NSLog(@"HomefeedViewController - User %@", currentUser.username);
    }
    else
    {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }

    [Restaurant retreiveRestaurantCount:^(NSArray *array) {
        self.restaurantsArray = [array mutableCopy];
        [self.restaurantTableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.restaurantsArray.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailHomefeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    PFObject *object = [self.restaurantsArray objectAtIndex:indexPath.row];


    NSString *name = object[@"name"];
    NSString *cuisineType = object[@"primaryCuisine"];
    NSString *neighborhood = object[@"neighborhood"];

    cell.restaurantName.text = name;
    cell.cuisineType.text = cuisineType;
    cell.neighborhoodLabel.text = neighborhood;



    [self downloadPhotoForPost:object andInsertInCell:cell];



    return cell;
}

- (void)downloadPhotoForPost:(PFObject *)object andInsertInCell:(DetailHomefeedTableViewCell *)cell
{
    PFFile *userImageFile = object[@"featuredImage"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.featuredImageView.image = image;
            [cell layoutSubviews];
        }
    }];
}

- (IBAction)logoutButtonTapped:(UIBarButtonItem *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [User logOut];
    });
    //[User logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"cellIdentifier"])
    {
        DetailRestaurantViewViewController *vc = segue.destinationViewController;

        NSIndexPath *cellIndexPath = [self.restaurantTableView indexPathForCell:sender];
        Restaurant *restaurant = [self.restaurantsArray objectAtIndex:cellIndexPath.row];
        vc.fullRestaurant = restaurant;
    }
}



/*------------------------------EnterText---------------------------*/


/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
