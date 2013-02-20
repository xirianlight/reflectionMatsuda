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
                                @"0":ginosEast,
                                @"1":giordanos,
                                @"2":carmens,
                                @"3":gigios,
                                @"4":@"pizza5Details",
                                @"5":@"pizza6Details",
                                @"6":@"pizza7Details",
                                @"7":@"pizza8Details",
                                @"8":@"pizza9Details",
                                @"9":@"pizza10Details",
                                @"10":@"pizza11Details",
                                @"11":@"pizza12Details",
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
    
    // Return the number of rows in the section (automatically pulled by object). Here, 12.
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

                 //Can't fix it, will have to redo the entire f@&*ing thing
    
    // NSString *stringVersionOfIPR = [NSString stringWithFormat:@"%d", indexPath.row];
    
    tableViewCell.textLabel.text = [pizzaKeys objectAtIndex:indexPath.row];
    
//    tableViewCell.textLabel.text =[self.chicagoPizzaPlaces valueForKey:stringVersionOfIPR];


    return tableViewCell;

}

//
//End previous code
//


@end
