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
#import "FloorPlan.h"

@interface HomefeedViewController () <UITableViewDataSource, UITableViewDelegate>

#pragma mark - View Controller IBOutlets
/*------------------------------Table View Properties ---------------------------*/
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;

#pragma mark - View Controller Properties
/*------------------------------Logic Function Properties ---------------------------*/
@property NSMutableArray *restaurantsArray;
@property NSMutableArray *restaurantImagesArray;
@property NSMutableArray *floorplansArray;

@end

@implementation HomefeedViewController

#pragma mark - View Did Load
- (void)viewDidLoad {
    [super viewDidLoad];

    User *currentUser = [User currentUser];
    if (!currentUser)
    {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }

    [Restaurant retreiveRestaurantCount:^(NSArray *array) {
        self.restaurantsArray = [array mutableCopy];
        [self.restaurantTableView reloadData];
    }];



    [FloorPlan retreiveFloorPlan:^(NSArray *array) {
        self.floorplansArray = [array mutableCopy];
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
        FloorPlan *floorplan = [self.restaurantsArray objectAtIndex:cellIndexPath.row];
        vc.fullRestaurant = restaurant;
        vc.fullFloorPlan = floorplan;

        
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
