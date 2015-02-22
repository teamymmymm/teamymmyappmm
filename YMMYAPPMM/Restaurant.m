//
//  Restaurant.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "Restaurant.h"
#import <Parse/Parse.h>

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
@dynamic featuredImage;
@dynamic dollarSigns;


+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Restaurant";
}


+ (void)retreiveRestaurantCount:(void (^)(NSArray *array))complete
{
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        complete(objects);

    }];
}

+ (void)retreiveRestaurantImage:(void (^)(NSArray *array))complete
{

    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objectImages, NSError *error) {
        complete(objectImages);
    }];


}



@end
