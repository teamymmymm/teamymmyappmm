//
//  FloorPlan.h
//  YMMYAPPMM
//
//  Created by Kevin on 2/18/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import <Parse/Parse.h>

@interface FloorPlan : PFObject <PFSubclassing>

@property (retain, nonatomic) NSString *objectId;
@property (retain, nonatomic) NSDate *createdAt;
@property (retain, nonatomic) NSDate *updatedAt;
@property (retain, nonatomic) NSNumber *maxSeats;
@property (retain, nonatomic) NSNumber *tableQuantity;
@property (retain, nonatomic) NSNumber *time6am_8am;
@property (retain, nonatomic) NSNumber *time8am_10am;
@property (retain, nonatomic) NSNumber *time10am_12pm;
@property (retain, nonatomic) NSNumber *time12pm_2pm;
@property (retain, nonatomic) NSNumber *time2pm_4pm;
@property (retain, nonatomic) NSNumber *time4pm_6pm;
@property (retain, nonatomic) NSNumber *time6pm_8pm;
@property (retain, nonatomic) NSNumber *time8pm_10pm;
@property (retain, nonatomic) NSNumber *time10pm_12am;
@property (retain, nonatomic) NSNumber *time12am_2am;
@property (retain) NSString *restaurantName;

+ (NSString *)parseClassName;

+ (void)retreiveFloorPlan:(void (^)(NSArray *array))complete;

@end



