//
//  FloorPlan.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/18/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "FloorPlan.h"

@implementation FloorPlan

@dynamic objectId;
@dynamic createdAt;
@dynamic updatedAt;
@dynamic maxSeats;
@dynamic tableQuantity;
@dynamic time6am_8am;
@dynamic time8am_10am;
@dynamic time10am_12pm;
@dynamic time12pm_2pm;
@dynamic time2pm_4pm;
@dynamic time4pm_6pm;
@dynamic time6pm_8pm;
@dynamic time8pm_10pm;
@dynamic time10pm_12am;
@dynamic time12am_2am;
@dynamic restaurantName;


+ (NSString *)parseClassName
{
    return @"FloorPlan";
}

+ (void)retreiveFloorPlan:(void (^)(NSArray *array))complete
{
    PFQuery *query = [PFQuery queryWithClassName:@"FloorPlan"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        complete(objects);

    }];
}


@end
