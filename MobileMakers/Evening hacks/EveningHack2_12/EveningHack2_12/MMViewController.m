//
//  MMViewController.m
//  EveningHack2_12
//
//  Created by Ross Matsuda on 2/12/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController
@synthesize chicagoPizzaPlaces;
@synthesize pizzaJoint;


//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    //Start custom code here
    //
    
    NSDictionary *ginosEast = @{
                                @"name":@"Gino's East",
                                @"zip": @"60610",
                                @"website": @"http://www.ginoseast.com/flash.html",
                                @"phone" : @"(312) 266-3337"
                                };
    NSDictionary *giordanos = @{
                          @"name":@"Giordano's",
                          @"zip": @"60618",
                          @"website": @"http://www.giordanos.com",
                          @"phone" : @"(773) 275-4600"
                          };
    
    NSDictionary *carmens  = @{
                               @"name": @"Carmen's",
                               @"zip": @"60202",
                               @"website" : @"http://www.carmenspizzaevanston.com",
                               @"phone":@"773.465.1700"
                               };
    NSDictionary *gigios = @{
                             @"name" : @"Gigio's",
                             @"zip":@"60201",
                             @"website":@"http://www.gigiospizzeriaevanston.com",
                             @"phone":@"847.328.0990"
                             };
    
    //Dictionary to hold all four pizza places
    self.chicagoPizzaPlaces = @{
                                @"Gino's":ginosEast,
                                @"Giordanos":giordanos,
                                @"Carmens":carmens,
                                @"Gigio's":gigios,
                                @"Pizza5":@"pizza5Details",
                                @"Pizza6":@"pizza6Details",
                                @"Pizza7":@"pizza7Details",
                                @"Pizza8":@"pizza8Details",
                                @"Pizza9":@"pizza9Details",
                                @"Pizza10":@"pizza10Details",
                                @"Pizza11":@"pizza11Details",
                                @"Pizza12":@"pizza12Details",
                                };


	}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
// Code from previous tableView exercise
//

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section (automatically pulled by object).
    return [self.chicagoPizzaPlaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *tableViewCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"MMTableViewReuseIdentifier"];
    
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMTableViewReuseIdentifier"];
    }

   //This code is from the interwebs and i don't get it
    
        NSArray *pizzaKeys = [self.chicagoPizzaPlaces allKeys];
   
    
    // NSString *stringVersionOfIPR = [NSString stringWithFormat:@"%d", indexPath.row];
    
    tableViewCell.textLabel.text = [pizzaKeys objectAtIndex:indexPath.row];
    
//    tableViewCell.textLabel.text =[self.chicagoPizzaPlaces valueForKey:stringVersionOfIPR];


    return tableViewCell;

}

//
//End previous code
//


@end
