//
//  User.m
//  YMMYAPPMM
//
//  Created by Edvin Lellhame on 2/10/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic createdAt;
@dynamic updatedAt;
@dynamic objectId;
@dynamic firstName;
@dynamic lastName;
@dynamic email;
@dynamic password;
@dynamic phoneNumber;


+ (void)load
{
    [self registerSubclass];
}



+ (NSString *)parseClassName
{
    return @"User";
}
@end
