//
//  Reservation.h
//  YMMYAPPMM
//
//  Created by Edvin Lellhame on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import <Parse/Parse.h>
#import "User.h"

@interface Reservation : PFObject <PFSubclassing>

@property (retain, nonatomic) NSString *objectId;
@property (retain) NSString *restaurantName;
@property (retain) NSString *reservationDate;
@property (retain, nonatomic) NSDate *createdAt;
@property (retain, nonatomic) NSDate *updatedAt;
@property (retain) NSString *reservationTime;
@property (retain) NSString *tableNumber;
@property (retain) NSNumber *maxSeats;
@property (retain) NSNumber *discount;
@property (retain) NSString *time_from;
@property (retain) NSString *time_to;
@property (retain) User *reservationPerson;
@property (retain) NSString *actualPersonsCheckedIn;
@property BOOL reservationNoShow;

+ (NSString *)parseClassName;

@end
