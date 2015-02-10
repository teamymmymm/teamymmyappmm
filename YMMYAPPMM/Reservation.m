//
//  Reservation.m
//  YMMYAPPMM
//
//  Created by Edvin Lellhame on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "Reservation.h"

@implementation Reservation



@dynamic objectId;
@dynamic restaurantName;
@dynamic reservationDate;
@dynamic createdAt;
@dynamic updatedAt;
@dynamic reservationTime;
@dynamic tableNumber;
@dynamic maxSeats;
@dynamic discount;
@dynamic time_from;
@dynamic time_to;
@dynamic reservationPerson;
@dynamic actualPersonsCheckedIn;
@dynamic reservationNoShow;


+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Reservation";
}



@end
