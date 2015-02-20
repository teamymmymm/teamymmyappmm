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


@property int personNumber;
@property NSDate *selectedDate;


@property NSMutableArray *floorPlansArray;

@end

@implementation DetailRestaurantViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.selectedDate = [NSDate date];

    FloorPlan *floorPlan = [FloorPlan new];
    [self.scrollView setScrollEnabled:TRUE];
    [self.scrollView setContentSize:CGSizeMake(320, 700)];
    [self updateRestaurantDetailLabels];
    self.scrollView.delegate = self;
    [self setDayLabelToToday];
    [self setDateLabelToToday];

    [self setPersonNumericLabel:2];

    [self.dayLeftArrow setEnabled:NO];


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

- (void)setDayLabelToToday
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    [self.selectedDate descriptionWithLocale:currentLocale];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"EEEE"];
    self.dayOfTheWeekLabel.text = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
}

- (void)setDateLabelToToday
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    [self.selectedDate descriptionWithLocale:currentLocale];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"MMM dd, yyyy"];
    NSString *tempDateText = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
    self.dateValueLabel.text = tempDateText;
    self.dateValueLabel.numberOfLines = 0;
    [self.dateValueLabel sizeToFit];
    [self.view layoutIfNeeded];
}



- (void)setPersonNumericLabel:(int)number
{
    self.personNumber = number;
    self.personsNumericLabel.text = [NSString stringWithFormat:@"%i",self.personNumber];
}

- (NSString *)stringFromDate:(NSDate *)date
{
    // this will allow for comparing the string values of the current date and selected date
    NSDateFormatter *DateFormatter = [[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"MMM dd, yyyy"];
    NSString *tempSelectedDate = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
    return tempSelectedDate;
}


/*------------------------------IB Actions---------------------------*/
#pragma mark - Arrow Buttons Tapped

- (IBAction)personsLeftArrowTapped:(UIButton *)sender
{
    // numeric persons label can only display 1 at the lowest

    [self.personRightArrow setEnabled:YES];
    if(self.personNumber > 1)
    {
        [self setPersonNumericLabel:self.personNumber - 1];

        if(self.personNumber == 1)
        {
            [self.personLeftArrow setEnabled:NO];
        }
    }

}

- (IBAction)personsRightArrowTapped:(UIButton *)sender
{
    // numeric persons label maxium is 10 persons

    [self.personLeftArrow setEnabled:YES];
    if(self.personNumber < 10)
    {
        [self setPersonNumericLabel:self.personNumber + 1];

        if(self.personNumber == 10)
        {
            [self.personRightArrow setEnabled:NO];
        }
    }
}

- (IBAction)dayLeftArrowTapped:(UIButton *)sender
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:-1];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:self.selectedDate options:0];
    self.selectedDate = nextDate;

    NSString *tempSelectedDate = [self stringFromDate:self.selectedDate];
    NSString *tempCurrentDate = [self stringFromDate:[NSDate date]];

    if ([tempSelectedDate isEqualToString:tempCurrentDate])
    {
        [self.dayLeftArrow setEnabled:NO];
    }

    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"MMM dd,yyyy"];
    NSString *tempDate = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
    [DateFormatter setDateFormat:@"EEEE"];
    NSString *tempDay = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];


    self.dateValueLabel.text = tempDate;
    self.dateValueLabel.numberOfLines = 0;
    [self.dateValueLabel sizeToFit];
    self.dayOfTheWeekLabel.text = tempDay;
    self.dayOfTheWeekLabel.numberOfLines = 0;
    [self.dayOfTheWeekLabel sizeToFit];
    [self.view layoutIfNeeded];
}

- (IBAction)dayRightArrowTapped:(UIButton *)sender
{
    [self.dayLeftArrow setEnabled:YES];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:self.selectedDate options:0];
    self.selectedDate = nextDate;

    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"MMM dd,yyyy"];
    NSString *tempDate = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
    [DateFormatter setDateFormat:@"EEEE"];
    NSString *tempDay = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
    self.dateValueLabel.text = tempDate;
    self.dateValueLabel.numberOfLines = 0;
    [self.dateValueLabel sizeToFit];
    self.dayOfTheWeekLabel.text = tempDay;
    self.dayOfTheWeekLabel.numberOfLines = 0;
    [self.dayOfTheWeekLabel sizeToFit];

    [self.view layoutIfNeeded];
}

- (IBAction)timeLeftArrowTapped:(UIButton *)sender
{

}

- (IBAction)timeRightArrowTapped:(UIButton *)sender
{

}





@end
