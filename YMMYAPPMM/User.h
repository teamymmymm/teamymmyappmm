//
//  User.h
//  YMMYAPPMM
//
//  Created by Edvin Lellhame on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser <PFSubclassing>

@property (retain) NSString *objectId;
@property (retain) NSString *firstName;
@property (retain) NSDate *createdAt;
@property (retain) NSDate *updatedAt;
@property (retain) NSString *lastName;
@property (retain) NSString *email;
@property (retain) NSString *password;
@property (retain) NSString *phoneNumber;


+ (NSString *)parseClassName;
//+ (User *)user;


@end
