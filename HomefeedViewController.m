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

@interface HomefeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *restaurantsArray;
@property NSMutableArray *restaurantImagesArray;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;


@end

@implementation HomefeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Restaurant retreiveRestaurantCount:^(NSArray *array) {
        self.restaurantsArray = [array mutableCopy];
        [self.restaurantTableView reloadData];
    }];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailRestaurantViewViewController *vc = segue.destinationViewController;

    NSIndexPath *cellIndexPath = [self.restaurantTableView indexPathForCell:sender];
    Restaurant *restaurant = [self.restaurantsArray objectAtIndex:cellIndexPath.row];
    vc.fullRestaurant = restaurant;

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
