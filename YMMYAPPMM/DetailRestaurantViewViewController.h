//
//  DetailRestaurantViewViewController.h
//  YMMYAPPMM
//
//  Created by Kevin on 2/12/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "FloorPlan.h"

@interface DetailRestaurantViewViewController : UIViewController
@property Restaurant *fullRestaurant;
@property FloorPlan *fullFloorPlan;


@end
