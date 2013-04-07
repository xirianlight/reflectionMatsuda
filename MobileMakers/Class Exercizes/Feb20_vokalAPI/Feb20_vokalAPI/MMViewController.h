//
//  MMViewController.h
//  Feb20_vokalAPI
//
//  Created by Ross Matsuda on 2/20/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property NSManagedObjectContext *myManagedObjectContext;

@end
