//
//  DetailHomefeedTableViewCell.h
//  YMMYAPPMM
//
//  Created by Kevin on 2/11/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHomefeedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *featuredImageView;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *cuisineType;
@property (weak, nonatomic) IBOutlet UILabel *neighborhoodLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;


@end
