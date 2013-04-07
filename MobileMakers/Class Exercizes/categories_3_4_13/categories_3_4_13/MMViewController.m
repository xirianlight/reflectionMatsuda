//
//  MMViewController.m
//  categories_3_4_13
//
//  Created by Ross Matsuda on 3/4/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"
#import "NSString+Reverse.h"

@interface MMViewController ()
{
    int angle;
}
@end

@implementation MMViewController

- (void)viewDidLoad
{
    
    angle = 0;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString * stringToReverse = textFieldToTypeIn.text;
    //NSString * stringToReverse = @"I don't know how to code";
    
    NSLog(@"%@", stringToReverse);
    NSString * reversedString = [stringToReverse reverse:stringToReverse];
    
    NSLog(@"%@", reversedString);
    [super viewDidLoad];
    //textField.text = stringToReverse;
    originalString.text = stringToReverse;
    reverseString.text = reversedString;
    [textField resignFirstResponder];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    if (angle == 0)
    {
        yinYangSymbol.transform = CGAffineTransformMakeRotation( 180 * M_PI  / 180);    [UIView commitAnimations];
        angle++;
        NSLog (@"first transform");
    }

    else
    {
        
yinYangSymbol.transform = CGAffineTransformMakeRotation( 0 * M_PI  / 180);    [UIView commitAnimations];
        angle--;
        NSLog (@"Second transform");
    }

    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldToMirror:(id)sender {
}
@end
