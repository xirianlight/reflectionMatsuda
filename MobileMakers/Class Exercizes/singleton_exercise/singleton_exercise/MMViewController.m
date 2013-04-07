//
//  MMViewController.m
//  singleton_exercise
//
//  Created by Ross Matsuda on 3/6/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"
#import "MMMagicDataManager.h"

@interface MMViewController ()
{
    MMMagicDataManager * myMagicDataManager;
}

@end

@implementation MMViewController

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
