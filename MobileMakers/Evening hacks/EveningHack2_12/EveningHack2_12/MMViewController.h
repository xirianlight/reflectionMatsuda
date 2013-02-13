//
//  MMViewController.h
//  EveningHack2_12
//
//  Created by Ross Matsuda on 2/12/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray* items;
}
//Define an NSDictinoary to hold pizza restaurants
@property (nonatomic, retain) NSDictionary *chicagoPizzaPlaces;
//Define an NSDictionary to hold individual restaurants
@property (nonatomic, retain) NSDictionary *pizzaJoint;


@end
