//
//  DetailRestaurantViewViewController.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/12/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "DetailRestaurantViewViewController.h"

@interface DetailRestaurantViewViewController ()

@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuisineLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessHours1Label;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantBusinessHours2Label;
@property (weak, nonatomic) IBOutlet UILabel *restaurantZipcodeLabel;



@end

@implementation DetailRestaurantViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateLabels];

}


- (void)updateLabels
{
    self.restaurantNameLabel.text = self.fullRestaurant.name;
    self.cuisineLabel.text = self.fullRestaurant.primaryCuisine;
    self.restaurantAddressLabel.text = self.fullRestaurant.address;
    self.restaurantBusinessHours2Label.text = self.fullRestaurant.businessHours2;
    self.businessHours1Label.text = self.fullRestaurant.businessHours1;
    self.restaurantCityLabel.text = self.fullRestaurant.city;
    self.restaurantStateLabel.text = self.fullRestaurant.state;
    self.restaurantZipcodeLabel.text = [NSString stringWithFormat:@"%@", self.fullRestaurant.zipcode];
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
