//
//  Restaurant.h
//  YMMYAPPMM
//
//  Created by Kevin on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//
// 2-11-15 Restaurant Class updated

#import <Parse/Parse.h>

@interface Restaurant : PFObject <PFSubclassing>

@property (retain, nonatomic) NSString *objectId;
@property (retain, nonatomic) NSDate *createdAt;
@property (retain, nonatomic) NSDate *updatedAt;
@property BOOL isActive;
@property (retain) NSString *name;
@property (retain) NSString *address;
@property (retain) NSString *city;
@property (retain) NSString *state;
@property (retain) NSNumber *zipcode;
@property (retain) NSString *primaryCuisine;
@property (retain) NSString *neighborhood;
@property (retain) NSNumber *rating;
@property (retain) NSString *phoneNumber;
@property (retain) NSString *businessHours1;
@property (retain) NSString *businessHours2;
@property (retain) NSData *featuredImage;
@property (retain) NSString *dollarSigns;


+ (NSString *)parseClassName;

+ (void)retreiveRestaurantCount:(void (^)(NSArray *array))complete;

+ (void)retreiveRestaurantImage:(void (^)(NSArray *array))complete;

@end
