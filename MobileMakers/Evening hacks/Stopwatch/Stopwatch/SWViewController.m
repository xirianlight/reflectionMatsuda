//
//  SWViewController.m
//  Stopwatch
//
//  Created by Ross Matsuda on 2/10/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "SWViewController.h"

@interface SWViewController ()
{
    double totalTime;               //THIS IS NEW
}

//Stores the timer that fires after a certain time / interval
@property (strong,nonatomic) NSTimer *stopWatchTimer;

//Stores the DATE of the tap on start button
@property (strong,nonatomic) NSString *playing;


@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set value to timer playing right now to NO
    totalTime = 0;
    self.playing = @"NO";
  
    self.stopwatchLabel.Font = [UIFont fontWithName:@"Frucade Small Extended" size:36.0];
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
// Here starts the actual stopwatch
//

//To count the actual time onscreen
- (void) updateTimer {
    if (self.playing == @"YES")
    {
        //TotalTime is a double, tracking seconds elapsed.
        totalTime = totalTime + self.stopWatchTimer.timeInterval;
    };
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:totalTime];
    
        //create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat: @"HH:mm:ss.SS"];
    [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    //Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
   self.stopwatchLabel.text = timeString;
 
}

- (IBAction)onStartPressed:(id)sender
{
    
    if ([self.playing isEqual: @"NO"])
    {    // if timer is NOT running when button pushed, do this
            self.playing = @"YES";
    }
    else
    {    // if timer is running, do this
        self.playing = @"NO";
    }
    
}

- (IBAction)onResetPressed:(id)sender
{
    self.stopwatchLabel.text = @"00:00:00.00";
    self.playing = @"NO";
    totalTime = 0;
}

@end
