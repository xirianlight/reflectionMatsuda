//
//  MMViewControllerSecondLevel.m
//  singleton_exercise
//
//  Created by Ross Matsuda on 3/6/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewControllerSecondLevel.h"

@interface MMViewControllerSecondLevel ()
{
    MMMagicDataManager *myMagicDataManager;
}

@end

@implementation MMViewControllerSecondLevel

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myMagicDataManager = [MMMagicDataManager sharedInstance];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
