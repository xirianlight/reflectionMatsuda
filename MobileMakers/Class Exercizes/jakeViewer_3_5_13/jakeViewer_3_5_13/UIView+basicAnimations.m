//
//  UIView+basicAnimations.m
//  jakeViewer_3_5_13
//
//  Created by Ross Matsuda on 3/6/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "UIView+basicAnimations.h"

@implementation UIView (basicAnimations)

-(void) rotateIt
{
    
    //[UIView animateWithDuration:1.5 animations:^{ [self setTransform:CGAffineTransformMakeRotation(90)];}
        //             completion:^(BOOL finished){ [self setTransform:CGAffineTransformMakeRotation(-90)];}];
    [UIView animateWithDuration:1.5 animations:^{ [self setTransform:CGAffineTransformMakeRotation(-180)];}];

    
}
-(void) shakeIt
{
    //Set your bounds for the animation movement
    //CGPoint center = self.center;
    CGPoint leftOf = CGPointMake(self.center.x-40, self.center.y);
    CGPoint rightOf = CGPointMake(self.center.x+40, self.center.y);
    
    //[UIView animateWithDuration:1.0 animations:^{} completion:^(BOOL finished){}];
    
    [UIView animateWithDuration:0.3 animations:^
     {self.center = leftOf;}
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.3 animations:^{ self.center = rightOf;}
                          completion:^(BOOL finished){self.center = self.center;}];
         
     }
     ];
}

@end
