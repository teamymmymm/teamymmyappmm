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
#import "ConfirmationViewController.h"
#import "Reservation.h"

@interface DetailRestaurantViewViewController () <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>


#pragma mark - View Controller IBOutlets
/*------------------------------Label Properties---------------------------*/

@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuisineLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessHours1Label;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCityStateZipLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantBusinessHours2Label;
@property (weak, nonatomic) IBOutlet UILabel *personsNumericLabel;
@property (weak, nonatomic) IBOutlet UILabel *personsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfTheWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dollarSignsLabel;

/*------------------------------Image Properties---------------------------*/
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImageView;


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
@property NSMutableArray *restaurantZuniArray;
@property NSMutableArray *restaurant1760array;
@property NSMutableArray *restaurantMarloweArray;
@property NSMutableArray *restaurantMavenArray;
@property NSMutableArray *restaurantNopaArray;
@property NSMutableArray *discountNopaArray;
@property NSMutableArray *discountZuniArray;
@property NSMutableArray *discount1760Array;
@property NSMutableArray *discountMarloweArray;
@property NSMutableArray *discountMavenArray;

@property NSString *dayValue;
@property NSString *dateValue;
@property NSInteger personsValue;
@property NSString *timeValue;


@end

@implementation DetailRestaurantViewViewController

#pragma mark - ViewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setBrandingColors]; // sets all UI view elements to have correct colors
}
#pragma mark - View Did Load

- (void)viewDidLoad {
    [super viewDidLoad];

    self.personsValue = 2;

    self.selectedDate = [[NSDate date] copy]; // the first run-time to capture today's date to perform logic

    self.currentDate = [self stringFromDate:[NSDate date]]; // captures today's date in a string format and saves it. Will be used to compare against today's date.

    [self.scrollView setScrollEnabled:TRUE]; // allows vertical scroll of content area holding the restaurant details and reservation request details
    [self.scrollView setContentSize:CGSizeMake(320, 560)]; // sets the content size of the scrollview
    self.scrollView.delegate = self; // sets the scroll view delegate to the restaurant detail view controller


    [self updateRestaurantDetailLabels]; // helper method to set each restaurant attribute label to proper information

    [self downloadPhotoForRestaurant:self.fullRestaurant]; // gets restaurant object so that you can set the featured restaurant image

    [self setDayLabelToToday]; // sets the dayOfTheWeek label to today's day (ex: Thursday)

    [self setDateLabelToToday]; // sets the dateValue label to today's date (ex: Feb 14, 2015)

    [self setPersonNumericLabel:2]; // custom init method that sets the default personsNumericLabel to "number" (int)
    [self.dayLeftArrow setEnabled:NO]; // sets the dayLeftArrow to disabled so that users cannot go back days prior to today

    [self populateTimesArray]; // populates the times array NEEDS UPDATING

    [self populateDiscountTimesArray]; // populates the discounts array NEEDS UPDATING

    [self logicPopulationForReservations];

    [self.timesAvailableCollectionView reloadData];
}




#pragma mark - Helper Methods

- (void)setBrandingColors
{
    self.view.backgroundColor = [UIColor colorWithRed:42/255.0 green:187/255.0 blue:155/255.0 alpha:1];
}

- (void)updateRestaurantDetailLabels
{
    self.restaurantNameLabel.text = self.fullRestaurant.name;
    self.cuisineLabel.text = self.fullRestaurant.primaryCuisine;
    self.restaurantAddressLabel.text = self.fullRestaurant.address;
    self.restaurantBusinessHours2Label.text = self.fullRestaurant.businessHours2;
    self.businessHours1Label.text = self.fullRestaurant.businessHours1;
    self.restaurantCityStateZipLabel.text = [NSString stringWithFormat:@"%@, %@ %@", self.fullRestaurant.city, self.fullRestaurant.state, self.fullRestaurant.zipcode];
    self.dollarSignsLabel.text = self.fullRestaurant.dollarSigns;
    self.dollarSignsLabel.numberOfLines = 0;
    [self.dollarSignsLabel sizeToFit];

}

- (void)downloadPhotoForRestaurant:(PFObject *)object
{
    PFFile *userImageFile = object[@"featuredImage"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            self.restaurantImageView.image = image;
            [self.view layoutSubviews];
        }
    }];

}

- (void)setDayLabelToToday
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    [self.selectedDate descriptionWithLocale:currentLocale];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"EEEE"];
    self.dayOfTheWeekLabel.text = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
    self.dayValue = self.dayOfTheWeekLabel.text;
}


-(void)populateTimesArray
{
    // dummy data delete these!!


    //    self.floorPlanTimesArray = [[NSMutableArray alloc]initWithObjects:@"6:00pm",@"7:00pm",@"7:30pm",@"9:00pm",@"9:30pm",@"10:00pm", nil];
    self.restaurantZuniArray = [[NSMutableArray alloc]initWithObjects:@"5:00pm",@"5:30pm",@"6:30pm",@"7:00pm",@"7:30pm",@"9:00pm",@"9:30pm",@"10:00pm", nil];
    self.restaurantMavenArray = [[NSMutableArray alloc]initWithObjects:@"7:00pm",@"7:30pm",@"9:00pm",@"9:30pm",@"10:00pm",@"10:30pm", nil];
    self.restaurantNopaArray = [[NSMutableArray alloc]initWithObjects:@"5:00pm",@"5:30pm",@"6:30pm",@"8:30pm",@"9:30pm",@"10:00pm",@"10:30pm", nil];
    self.restaurantMarloweArray = [[NSMutableArray alloc]initWithObjects:@"5:00pm",@"5:30pm",@"6:30pm",@"8:30pm",@"9:30pm",@"10:00pm",@"10:30pm", nil];
    self.
    self.restaurant1760array = [[NSMutableArray alloc]initWithObjects:@"5:00pm",@"5:30pm",@"9:30pm",@"10:00pm",@"10:30pm", nil];
    self.fullRestaurant.reservationAvailability = self.floorPlanTimesArray;

}


- (void)populateDiscountTimesArray
{
    //    self.discountTimesArray = [[NSMutableArray alloc]initWithObjects:@"20%",@"25%",@"25%",@"25%",@"30%",@"35%", nil];
    self.discount1760Array = [[NSMutableArray alloc]initWithObjects:@"20%",@"25%",@"25%",@"25%",@"30%", nil];
    self.discountMarloweArray = [[NSMutableArray alloc]initWithObjects:@"20%",@"25%",@"25%",@"25%",@"30%",@"35%",@"25%", nil];
    self.discountMavenArray = [[NSMutableArray alloc]initWithObjects:@"20%",@"25%",@"25%",@"25%",@"30%",@"35%", nil];
    self.discountNopaArray = [[NSMutableArray alloc]initWithObjects:@"20%",@"25%",@"25%",@"25%",@"30%",@"35%",@"25%", nil];
    self.discountZuniArray = [[NSMutableArray alloc]initWithObjects:@"20%",@"25%",@"25%",@"25%",@"30%",@"35%", @"20%",@"20%",nil];
}

- (void)logicPopulationForReservations
{
    // if restaurant name isEqualto : "Marlowe"
    // then set fullrestaurant.reservationavailability array to marlowearray
    // then set marlowe array equal to floorplansarray

    if ([self.fullRestaurant.name isEqual: @"Marlowe"])
    {
        self.floorPlanTimesArray = self.restaurantMarloweArray;
        self.discountTimesArray = self.discountMarloweArray;
    }
    else if ([self.fullRestaurant.name isEqual: @"Zuni Café"])
    {
        self.floorPlanTimesArray = self.restaurantZuniArray;
        self.discountTimesArray = self.discountZuniArray;
    }
    else if ([self.fullRestaurant.name isEqual: @"1760"])
    {
        self.floorPlanTimesArray = self.restaurant1760array;
        self.discountTimesArray = self.discount1760Array;
    }
    else if ([self.fullRestaurant.name isEqual: @"Maven"])
    {
        self.floorPlanTimesArray = self.restaurantMavenArray;
        self.discountTimesArray = self.discountMavenArray;
    }
    else if ([self.fullRestaurant.name isEqual: @"Nopa"])
    {
        self.floorPlanTimesArray = self.restaurantNopaArray;
        self.discountTimesArray = self.discountNopaArray;
    }
}



- (void)setDateLabelToToday
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    [self.selectedDate descriptionWithLocale:currentLocale];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"MMM dd, yyyy"];
    NSString *tempDateText = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:self.selectedDate]];
    self.dateValueLabel.text = tempDateText;
    self.dateValue = self.dateValueLabel.text;
    self.dateValueLabel.numberOfLines = 0;
    [self.dateValueLabel sizeToFit];
    [self.view layoutIfNeeded];
}



- (void)setPersonNumericLabel:(int)number
{
    self.personNumber = number;
    self.personsNumericLabel.text = [NSString stringWithFormat:@"%i",self.personNumber];
    self.personsValue = [self.personsNumericLabel.text integerValue];
}

#pragma mark - Collection View Functions


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReservationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionviewcell" forIndexPath:indexPath];
    collectionView.backgroundColor = [UIColor colorWithRed:42/255.0 green:187/255.0 blue:155/255.0 alpha:1];
    cell.backgroundColor = [UIColor colorWithRed:42/255.0 green:187/255.0 blue:155/255.0 alpha:1];

    [cell.timeButton setTitle:self.floorPlanTimesArray[indexPath.row] forState:UIControlStateNormal];

    cell.timeButton.backgroundColor = [UIColor whiteColor];
    cell.timeButton.titleLabel.textColor = [UIColor colorWithRed:42/255.0 green:187/255.0 blue:155/255.0 alpha:1];
    [cell.timeButton setTitleColor:[UIColor colorWithRed:42/255.0 green:187/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
    cell.timeButton.layer.cornerRadius = 10;
    cell.timeButton.clipsToBounds = YES;
    //    cell.timeButton.titleLabel.text = self.timeValue;
    self.timeValue = cell.timeButton.titleLabel.text;
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    if ([segue.identifier isEqualToString:@"confirmationSegue"])
    {
        ConfirmationViewController *vc = segue.destinationViewController;
        vc.passedRestaurantNameValue = self.restaurantNameLabel.text;
        vc.passedDayValue = self.dayValue;
        vc.passedDateValue = self.dateValue;
        vc.passedPeopleValue = self.personsValue;
        vc.passedTimeValue = sender.titleLabel.text;
        
    }
}



@end
