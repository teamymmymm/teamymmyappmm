//
//  HomefeedViewController.m
//  YMMYAPPMM
//
//  Created by Kevin on 2/11/15.
//  Copyright (c) 2015 Kevin Lee. All rights reserved.
//

#import "HomefeedViewController.h"
#import "DetailHomefeedTableViewCell.h"

@interface HomefeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *restaurantsArray;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;


@end

@implementation HomefeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return self.restaurantsArray.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    


    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
