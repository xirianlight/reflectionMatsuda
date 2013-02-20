//
//  MMViewController.h
//  eveningHack2_18_blocks
//
//  Created by Ross Matsuda on 2/18/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMViewController : UIViewController 
- (IBAction)colorButton:(id)sender;
- (IBAction)sizeButton:(id)sender;
- (IBAction)shiftButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewToEdit;

@end
