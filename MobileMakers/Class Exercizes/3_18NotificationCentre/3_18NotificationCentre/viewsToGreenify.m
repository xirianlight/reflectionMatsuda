//
//  viewsToGreenify.m
//  3_18NotificationCentre
//
//  Created by Ross Matsuda on 3/18/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "viewsToGreenify.h"

@implementation viewsToGreenify
{
    bool ISGREEN;
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(greenify:) name:@"Greenification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backLeft) name:@"backLeft" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveLeft) name:@"moveLeft" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveRight) name:@"moveRight" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveUp) name:@"moveUp" object:nil];



        
    }
    ISGREEN = NO;
    return self;
}

-(void) backLeft
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    self.backgroundColor = [UIColor blackColor];
    self.transform = CGAffineTransformMakeScale(1, 1);
    self.center = CGPointMake(self.center.x, self.center.y+600);
    
    [UIView commitAnimations];
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(greenify) name:@"Greenification" object:nil];
//    
//    }
//    ISGREEN = NO;
//    return self;
//}


-(void) greenify: (NSNotification*) notification
{
    NSDictionary * dictionary = notification.object;
    NSString * colorMethodString = [NSString stringWithFormat:@"%@Color", [dictionary objectForKey:@"color"]];
    
    //Crazy shit
    SEL selector = NSSelectorFromString(colorMethodString);
    UIColor *color = [UIColor clearColor];
    
    if ([[UIColor class] respondsToSelector:selector])
    {
        color = [[UIColor class] performSelector:selector];
    }
    
    if (ISGREEN == YES)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.75];
        self.backgroundColor = [UIColor blackColor];
        self.transform = CGAffineTransformMakeScale(2, 2);
        self.center = CGPointMake(self.center.x+100, self.center.y);
        
        [UIView commitAnimations];
        ISGREEN = NO;
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.75];
        self.backgroundColor = color;
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.center = CGPointMake(self.center.x-50, self.center.y);

        [UIView commitAnimations];
        ISGREEN = YES;
        
    }
    
}
-(void)moveLeft
{
    [UIView animateWithDuration:0.5 animations:
     ^(void)
     {
         self.center = CGPointMake(self.center.x-100, self.center.y);
     }];
}

-(void)moveRight
{
    [UIView animateWithDuration:0.5 animations:
     ^(void)
     {
         self.center = CGPointMake(self.center.x+100, self.center.y);
     }];
}

-(void)moveUp
{
    [UIView animateWithDuration:0.5 animations:
     ^(void)
     {
         self.center = CGPointMake(self.center.x, self.center.y-600);
     }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
