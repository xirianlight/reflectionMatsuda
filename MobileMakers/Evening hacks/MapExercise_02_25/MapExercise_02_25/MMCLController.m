//
//  MMCLController.m
//  MapExercise_02_25
//
//  Created by Ross Matsuda on 2/26/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMCLController.h"

@implementation MMCLController
@synthesize misterLocationmanager, delegate;


//Custom initializer for this class
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        self.misterLocationmanager = [[CLLocationManager alloc]init];
        //Send location data to myself
        self.misterLocationmanager.delegate = self;
    }
    return self;
}

//Two required delegate methods
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    //Code goes here
    NSLog(@"%@", newLocation);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;
{
    //Code goes here
    NSLog(@"%@", error);
}


@end

