//
//  Restaurant.h
//  YMMYAPPMM
//
//  Created by Kevin on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import <Parse/Parse.h>

@interface Restaurant : PFObject <PFSubclassing>

@property (retain) NSString *restaurantName;
@property (retain) NSString *restaurantAddress;
@property (retain) NSString *restaurantPhoneNumber;
@property (retain) NSString *restaurantBusinessHours;
@property (retain) NSString *restaurantPrimaryCategory;
@property (retain, nonatomic) NSDate *createdAt;
@property (retain, nonatomic) NSDate *updatedAt;
@property (retain, nonatomic) NSString *objectId;

+ (NSString *)parseClassName;

@end
