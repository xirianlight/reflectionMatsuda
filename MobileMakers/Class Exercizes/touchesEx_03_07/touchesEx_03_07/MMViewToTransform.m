//
//  MMViewToTransform.m
//  touchesEx_03_07
//
//  Created by Ross Matsuda on 3/7/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewToTransform.h"

@implementation MMViewToTransform
{
    CGPoint offset;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor blueColor];
    UITouch *aTouch = [touches anyObject];
    //Set a new touch instance based on where in your view (small view) the user touches
    offset = [aTouch locationInView: self];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
        //Location is where you touched in the superView
    //Move the frame to equal your superView location MINUS the offset
    self.frame = CGRectMake(location.x-offset.x, location.y-offset.y,
                            self.frame.size.width, self.frame.size.height);
    
    

    //Boundary for left
    if (self.frame.origin.x < 0 || self.frame.origin.y < 0 )
    {
        NSLog(@"Out of bounds");
        self.frame = CGRectMake(0, location.y - offset.y, self.frame.size.width, self.frame.size.height);

    }
    //Boundary for top
    if (self.frame.origin.y < 0 )
    {
        NSLog(@"Out of bounds");
        self.frame = CGRectMake(location.x - offset.x, 0, self.frame.size.width, self.frame.size.height);
        
    }
    //Boundary for top left corner
    if (self.frame.origin.x < 0 || self.frame.origin.y < 0 )
    {
        NSLog(@"Out of bounds");
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
    }

//Now we have the other boundaries!!!
    
    //Boundary for right
    if (self.frame.origin.x + self.frame.size.width > self.superview.frame.size.width)
    {
        NSLog(@"Out of bounds");
        self.frame = CGRectMake(self.superview.frame.size.width - self.frame.size.width, location.y - offset.y, self.frame.size.width, self.frame.size.height);
        
        
    }
    //Boundary for bottom
    if (self.frame.origin.y + self.frame.size.height > self.superview.frame.size.height)
    {
        NSLog(@"Out of bounds");
        self.frame = CGRectMake(location.x - offset.x, self.superview.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        
    }

//Boundary for the three corners
    
    //Boundary for bottom right
    if (self.frame.origin.x + self.frame.size.width > self.superview.frame.size.width || self.frame.origin.y + self.frame.size.height > self.superview.frame.size.height)
    {
        NSLog(@"Out of bounds");
        self.frame = CGRectMake(self.superview.frame.size.width - self.frame.size.width, self.superview.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);

    }
    
    //Boundary for top right
    if (self.frame.origin.x + self.frame.size.width > self.superview.frame.size.width || self.frame.origin.y < 0)
    {
        NSLog(@"Out of bounds");
        self.frame = CGRectMake(self.superview.frame.size.width - self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        
    }
    
    
    //Boundary for bottom left
    if (self.frame.origin.x < 0 || self.frame.origin.y + self.frame.size.height > self.superview.frame.size.height)
    {
        NSLog(@"Out of bounds");
        self.frame = CGRectMake(0, self.superview.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        
    }
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor whiteColor];
    
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
