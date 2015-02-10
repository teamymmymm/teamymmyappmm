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
@property (retain, nonatomic) NSDate *createdAt;
@property (retain, nonatomic) NSDate *updatedAt;
@property (retain) NSString *lastName;
@property (retain, nonatomic) NSString *email;
@property (retain, nonatomic) NSString *password;
@property (retain) NSString *phoneNumber;


+ (NSString *)parseClassName;



@end
