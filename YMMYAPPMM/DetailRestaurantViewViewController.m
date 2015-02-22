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
#import "ReservationCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailRestaurantViewViewController () <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>


#pragma mark - View Controller IBOutlets
/*------------------------------Label Properties---------------------------*/

@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuisineLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessHours1Label;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantBusinessHours2Label;
@property (weak, nonatomic) IBOutlet UILabel *restaurantZipcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *personsNumericLabel;
@property (weak, nonatomic) IBOutlet UILabel *personsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfTheWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dollarSignsLabel;



/*------------------------------Scroll View Properties---------------------------*/
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/*------------------------------Collection View Properties---------------------------*/
@property (weak, nonatomic) IBOutlet UICollectionView *timesAvailableCollectionView;

/*------------------------------Button Properties---------------------------*/
@property (weak, nonatomic) IBOutlet UIButton *personLeftArrow;
@property (weak, nonatomic) IBOutlet UIButton *personRightArrow;
@property (weak, nonatomic) IBOutlet UIButton *dayLeftArrow;
@property (weak, nonatomic) IBOutlet UIButton *dayRightArrow;

#pragma mark - View Controller Properties
/*------------------------------Logic Function Properties---------------------------*/

@property int personNumber; // need this to
@property NSString *currentDate;
@property NSDate *selectedDate;
@property NSMutableArray *floorPlansArray;
@property NSMutableArray *floorPlanTimesArray;
@property NSMutableArray *discountTimesArray;

@end

@implementation DetailRestaurantViewViewController

#pragma mark - View Did Load

- (void)viewDidLoad {
    [super viewDidLoad];

    self.selectedDate = [[NSDate date] copy]; // the first run-time to capture today's date to perform logic

    self.currentDate = [self stringFromDate:[NSDate date]]; // captures today's date in a string format and saves it. Will be used to compare against today's date.

    [self.scrollView setScrollEnabled:TRUE]; // allows vertical scroll of content area holding the restaurant details and reservation request details
    [self.scrollView setContentSize:CGSizeMake(320, 700)]; // sets the content size of the scrollview
    self.scrollView.delegate = self; // sets the scroll view delegate to the restaurant detail view controller

    [self updateRestaurantDetailLabels]; // helper method to set each restaurant attribute label to proper information

    [self setDayLabelToToday]; // sets the dayOfTheWeek label to today's day (ex: Thursday)

    [self setDateLabelToToday]; // sets the dateValue label to today's date (ex: Feb 14, 2015)

    [self setPersonNumericLabel:2]; // custom init method that sets the default personsNumericLabel to "number" (int)
    [self.dayLeftArrow setEnabled:NO]; // sets the dayLeftArrow to disabled so that users cannot go back days prior to today

    [self populateTimesArray]; // populates the times array NEEDS UPDATING

    [self populateDiscountTimesArray]; // populates the discounts array NEEDS UPDATING

}


#pragma mark - Helper Methods

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
    self.dollarSignsLabel.text = self.fullRestaurant.dollarSigns;
    self.dollarSignsLabel.numberOfLines = 0;
    [self.dollarSignsLabel sizeToFit];
}

- (void)setDayLabelToToday
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    [self.selectedDate descriptionWithLocale:currentLocale];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"EEEE"];
    self.dayOfTheWeekLabel.text = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
}


-(void)populateTimesArray
{
//    self.floorPlanTimesArray = [NSMutableArray new];
    // need to check business hours of restaurant
    // need to get current time
    // need to populate array with possible available times > than current time
    // time with 30 min intervals


    // check which time bucket the time belongs to, and get the discount rate


    // dummy data delete these!!
    self.floorPlanTimesArray = [[NSMutableArray alloc]initWithObjects:@"6:00pm",@"7:00pm",@"7:30pm",@"9:00pm",@"9:30pm",@"10:00pm", nil];

}

- (void)populateDiscountTimesArray
{
    self.discountTimesArray = [[NSMutableArray alloc]initWithObjects:@"20%",@"25%",@"25%",@"25%",@"30%",@"35%", nil];
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

#pragma mark - Collection View Functions


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReservationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionviewcell" forIndexPath:indexPath];

    [cell.timeButton setTitle:self.floorPlanTimesArray[indexPath.row] forState:UIControlStateNormal];
    cell.timeButton.backgroundColor = [UIColor colorWithRed:42/255.0 green:187/255.0 blue:155/255.0 alpha:1];
    [cell.timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cell.timeButton.layer.cornerRadius = 10;
    cell.timeButton.clipsToBounds = YES;

    cell.discountLabel.text = self.discountTimesArray[indexPath.row];
    return cell;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.floorPlanTimesArray.count;
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

- (NSString *)stringFromDate:(NSDate *)date
{
    // this will allow for comparing the string values of the current date and selected date
    NSDateFormatter *DateFormatter = [[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"MMM dd, yyyy"];
    NSString *tempSelectedDate = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
    return tempSelectedDate;
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

    if ([tempSelectedDate isEqualToString:self.currentDate])
    {
        [self.dayLeftArrow setEnabled:NO];
    }
    else
    {
        [self.dayLeftArrow setEnabled:YES];
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
