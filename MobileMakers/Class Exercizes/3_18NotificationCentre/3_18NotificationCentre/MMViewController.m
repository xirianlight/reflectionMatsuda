//
//  MMViewController.m
//  3_18NotificationCentre
//
//  Created by Ross Matsuda on 3/18/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"
#import "viewsToGreenify.h"

@interface MMViewController ()
{
    
    __weak IBOutlet viewsToGreenify *topViewToChange;
    __weak IBOutlet UITextField *colorTextField;
}
- (IBAction)changeButtonPressed:(id)sender;
- (IBAction)retreatButtonPressed:(id)sender;
- (IBAction)swipeLeftGesture:(id)sender;
- (IBAction)swipeRightGesture:(id)sender;
- (IBAction)swipeUpGesture:(id)sender;

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeButtonPressed:(id)sender {
    NSDictionary * dictionary = @{@"color": colorTextField.text};
    NSLog(@"Stored this dictionary %@", dictionary);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Greenification" object:dictionary];
}

- (IBAction)retreatButtonPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backLeft" object:nil];
}

- (IBAction)swipeLeftGesture:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moveLeft" object:nil];

}

- (IBAction)swipeRightGesture:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moveRight" object:nil];

}

- (IBAction)swipeUpGesture:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moveUp" object:nil];

}
@end
