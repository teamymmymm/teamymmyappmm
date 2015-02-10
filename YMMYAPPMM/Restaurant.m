//
//  Restaurant.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

@dynamic restaurantAddress;
@dynamic restaurantBusinessHours;
@dynamic restaurantName;
@dynamic restaurantPhoneNumber;
@dynamic restaurantPrimaryCategory;
@dynamic createdAt;
@dynamic updatedAt;
@dynamic objectId;
@dynamic isActive;


+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Restaurant";
}


+ (void)retreiveRestaurant:(void (^)(NSArray *array))complete
{
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];

   // [query whereKey:@"name" co containedIn:<#(NSArray *)#>]
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        complete(objects);
    }];
}
@end
