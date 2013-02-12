//
//  SWViewController.h
//  Stopwatch
//
//  Created by Ross Matsuda on 2/10/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWViewController : UIViewController
{
 //   NSTimeInterval * totalTimeInterval;
}
//This is displays the time onscreen
@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;



//onTouchUp for start button
- (IBAction)onStartPressed:(id)sender;

//onTouchUp for stop button
//- (IBAction)onStopPressed:(id)sender;

//onTouchUp for reset button
- (IBAction)onResetPressed:(id)sender;

@end
