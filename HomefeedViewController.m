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
#import <MessageUI/MessageUI.h>

@interface HomefeedViewController () <UITableViewDataSource, UITableViewDelegate>

#pragma mark - View Controller IBOutlets
/*------------------------------Table View Properties ---------------------------*/
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;

#pragma mark - View Controller Properties
/*------------------------------Logic Function Properties ---------------------------*/
@property NSMutableArray *restaurantsArray;
@property NSMutableArray *restaurantImagesArray;
@property NSMutableArray *floorplansArray;

@property NSDate *todaysDate;

@end

@implementation HomefeedViewController

#pragma mark - viewDidLoad
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
    }]; // calls the method to retreive the count of all restaurants in database and sets that count to the restaurantsArray

    [FloorPlan retreiveFloorPlan:^(NSArray *array) {
        self.floorplansArray = [array mutableCopy];
    }]; // calls the method to retreieve the FloorPlan objects and sets them to the floorplansArray
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO]; // emables the navigation controller on the homefeed

    self.todaysDate = [[NSDate date] copy];

    self.navigationItem.title = [self stringFromDate:[NSDate date]];
}

#pragma mark - Table View Logic
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.restaurantsArray.count ; // sets the number of rows in the tableview to the number of restaurants in the array
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailHomefeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"]; // dequeues cell with identifier so tableview can re-use cells

    PFObject *object = [self.restaurantsArray objectAtIndex:indexPath.row]; // calls the attributes of each restaurant in the restaurantsarray
    NSString *name = object[@"name"]; // sets a string varaible to the restaurant's name
    NSString *cuisineType = object[@"primaryCuisine"]; // sets a string variable to the restuarant's cuisine type
    NSString *neighborhood = object[@"neighborhood"]; // sets a string variable to the restaurants neighborhood

    cell.restaurantName.text = name; // sets the restaurantName label's text to restaurants name
    cell.cuisineType.text = cuisineType; // sets the cuisineType label's text to restaurants cuisine type
    cell.neighborhoodLabel.text = neighborhood; // sets the neighborhood label's text to restaurants neighborhood

    [self downloadPhotoForPost:object andInsertInCell:cell]; // calls the method to download the featured image of restaurant and insert as background image into cell

    return cell;
}

#pragma mark - Helper Methods
- (void)downloadPhotoForPost:(PFObject *)object andInsertInCell:(DetailHomefeedTableViewCell *)cell
{
    PFFile *userImageFile = object[@"featuredImage"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.featuredImageView.image = image;
            [cell layoutSubviews];
        }
    }]; // method to download the featured image of restaurant and insert as background image into cell
}

- (NSString *)stringFromDate:(NSDate *)date
{
    // this will allow for comparing the string values of the current date and selected date
    NSDateFormatter *DateFormatter = [[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"EEE, MMM dd"];
    NSString *tempSelectedDate = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.todaysDate]];
    return tempSelectedDate;
}

#pragma mark - Logout Button
- (IBAction)logoutButtonTapped:(UIBarButtonItem *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [User logOut];
    });
    // on button tapped, the user is logged out

    [self performSegueWithIdentifier:@"showLogin" sender:self]; // if the user logs out, user is sent to the main login screen
}

#pragma mark - Prepare for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"cellIdentifier"])
    {
        DetailRestaurantViewViewController *vc = segue.destinationViewController;

        NSIndexPath *cellIndexPath = [self.restaurantTableView indexPathForCell:sender];
        Restaurant *restaurant = [self.restaurantsArray objectAtIndex:cellIndexPath.row];
        FloorPlan *floorplan = [self.floorplansArray objectAtIndex:cellIndexPath.row];
        vc.fullRestaurant = restaurant;
        vc.fullFloorPlan = floorplan;
    }
}

@end
