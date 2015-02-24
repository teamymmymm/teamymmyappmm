//
//  ConfirmationViewController.h
//  YMMYAPPMM
//
//  Created by Kevin on 2/16/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Reservation.h"

@interface ConfirmationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property NSString *passedRestaurantNameValue;
@property (strong, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;
@property NSInteger passedPeopleValue;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property NSString *passedDayValue;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property NSString *passedDateValue;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property NSString *passedTimeValue;
@property Reservation *time_from;


@end
