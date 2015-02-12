//
//  HomefeedViewController.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/11/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "HomefeedViewController.h"
#import "DetailHomefeedTableViewCell.h"
#import "Restaurant.h"
#import <Parse/Parse.h>

@interface HomefeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *restaurantsArray;
@property NSMutableArray *restaurantImagesArray;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;


@end

@implementation HomefeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Restaurant retreiveRestaurantCount:^(NSArray *array) {
        self.restaurantsArray = [array mutableCopy];
        [self.restaurantTableView reloadData];
    }];

    [Restaurant retreiveRestaurantImage:^(NSArray *array) {
        self.restaurantImagesArray = [array mutableCopy];
        [self.restaurantTableView reloadData];
    }];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.restaurantsArray.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailHomefeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    PFObject *object = [self.restaurantsArray objectAtIndex:indexPath.row];
    // PFFile *objectImages = objectImages[@"medianame"];

    NSString *name = object[@"name"];
    NSString *cuisineType = object[@"primaryCuisine"];

    cell.restaurantName.text = name;
    cell.cuisineType.text = cuisineType;

    [self downloadPhotoForPost:object andInsertInCell:cell];



    return cell;
}

- (void)downloadPhotoForPost:(PFObject *)object andInsertInCell:(DetailHomefeedTableViewCell *)cell
{

    PFQuery *query = [PFQuery queryWithClassName:@"AmbianceImage"];
    // Add constraints here to get the image you want (like the objectId or something else)
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             for (PFObject *object in objects)
             {
                 PFFile *imageFile = object[@"medianame"];
                 [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error)
                  {
                      if (!error)
                      {
                          UIImage *image = [UIImage imageWithData:imageData];  // Here is your image. Put it in a UIImageView or whatever
                          cell.featuredImageView.image = image;
                      }
                  }];
                 [cell layoutSubviews];


                 //    UIImageView *view = cell.imageView;
                 //
                 //    PFFile *userImageFile = object[@"medianame"];
                 //    [userImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                 //        if (!error) {
                 //            DetailHomefeedTableViewCell *imageDetail = [DetailHomefeedTableViewCell new];
                 //            UIImage *image = [UIImage imageWithData:data];
                 //            UIImageView *feedPhoto = imageDetail.featuredImageView;
                 //
                 //            cell.featuredImageView.image = image;

                 //            [cell layoutSubviews];
             }
         }
     }];
}

/*------------------------------EnterText---------------------------*/


/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end