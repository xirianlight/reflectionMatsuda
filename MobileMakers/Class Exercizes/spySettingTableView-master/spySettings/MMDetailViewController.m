//
//  MMDetailViewController.m
//  spySettings
//
//  Created by Ross Matsuda on 2/14/13.
//  Copyright (c) 2013 spawrks. All rights reserved.
//

#import "MMDetailViewController.h"

@interface MMDetailViewController ()
{
    
    IBOutlet UILabel *detailLabel;
}
@end

@implementation MMDetailViewController
@synthesize detailString, groupString;

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
    detailLabel.text = self.detailString;       //set label text
    self.title = self.groupString;              //set title text
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
