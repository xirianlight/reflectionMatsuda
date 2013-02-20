//
//  MMViewController.m
//  eveningHack2_18_blocks
//
//  Created by Ross Matsuda on 2/18/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController

@synthesize viewToEdit;
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

- (IBAction)colorButton:(id)sender
{
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^ void (void)
                    {
                         self.viewToEdit.backgroundColor = [UIColor blueColor];
                     }
                     completion:nil];
} 

- (IBAction)sizeButton:(id)sender
{
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^ void (void)
                    {
                         [viewToEdit setFrame:CGRectMake(15.0f, 100.0f, 300.0f, 200.0f)];
                      //   [viewToEdit setFrame:CGRectOffset(self.viewToEdit, 30.0f, 30.0f)];
                     }
                     completion:nil];
}

- (IBAction)shiftButton:(id)sender
{
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ void (void)
                    {
                        [viewToEdit setFrame:CGRectMake(15.0f, 15.0f, 44.0f, 44.0f)];
        
                    }
                     completion:nil];

    
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    NSLog(@"x: %f", location.x);
    NSLog(@"y: %f", location.y);
    viewToEdit.center = location;
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    //NSLog(@"the-x:%f, y:%f",location.x,location.y);
    
    viewToEdit.center = location;
    
}



@end
