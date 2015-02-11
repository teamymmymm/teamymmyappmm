//
//  Restaurant.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

@dynamic objectId;
@dynamic createdAt;
@dynamic updatedAt;
@dynamic isActive;
@dynamic name;
@dynamic address;
@dynamic city;
@dynamic state;
@dynamic zipcode;
@dynamic primaryCuisine;
@dynamic neighborhood;
@dynamic rating;
@dynamic phoneNumber;
@dynamic businessHours1;
@dynamic businessHours2;


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
