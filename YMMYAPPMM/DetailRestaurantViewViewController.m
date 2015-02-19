//
//  DetailRestaurantViewViewController.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/12/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "DetailRestaurantViewViewController.h"
#import "FloorPlan.h"
#import <Parse/Parse.h>

@interface DetailRestaurantViewViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuisineLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessHours1Label;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantBusinessHours2Label;
@property (weak, nonatomic) IBOutlet UILabel *restaurantZipcodeLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *personsNumericLabel;
@property (weak, nonatomic) IBOutlet UILabel *personsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfTheWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountValueLabel;
@property (weak, nonatomic) IBOutlet UIButton *personLeftArrow;
@property (weak, nonatomic) IBOutlet UIButton *personRightArrow;
@property (weak, nonatomic) IBOutlet UIButton *dayLeftArrow;
@property (weak, nonatomic) IBOutlet UIButton *dayRightArrow;



@property NSMutableArray *floorPlansArray;

@end

@implementation DetailRestaurantViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FloorPlan *floorPlan = [FloorPlan new];
    [self.scrollView setScrollEnabled:TRUE];
    [self.scrollView setContentSize:CGSizeMake(320, 700)];
    [self updateRestaurantDetailLabels];
    self.scrollView.delegate = self;

    int ressieperson = 2;
    self.personsNumericLabel.text = [NSString stringWithFormat:@"%i", ressieperson];

    [FloorPlan retreiveFloorPlan:^(NSArray *array)
     {
         self.floorPlansArray = [array mutableCopy];
     }];

   // NSLog(@"%@",self.floorPlansArray.count);

    NSLog(@"%@",floorPlan.maxSeats);

}

- (void)updateRestaurantDetailLabels
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



/*------------------------------IB Actions---------------------------*/
#pragma mark - Arrow Buttons Tapped

- (IBAction)personsLeftArrowTapped:(UIButton *)sender
{
    // numeric persons label can only display 1 at the lowest
    

}

- (IBAction)personsRightArrowTapped:(UIButton *)sender
{
    // numeric persons label maxium is 10 persons

}

- (IBAction)dayLeftArrowTapped:(UIButton *)sender
{

}

- (IBAction)dayRightArrowTapped:(UIButton *)sender
{

}

- (IBAction)timeLeftArrowTapped:(UIButton *)sender
{

}

- (IBAction)timeRightArrowTapped:(UIButton *)sender
{
    
}





@end
