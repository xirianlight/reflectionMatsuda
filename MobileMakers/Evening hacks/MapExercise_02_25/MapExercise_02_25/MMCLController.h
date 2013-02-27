//
//  MMCLController.h
//  MapExercise_02_25
//
//  Created by Ross Matsuda on 2/26/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol MMCLControllerDelegate <NSObject>

@required
-(void) locationUpdate: (CLLocation *) location;
-(void) locationError: (NSError *) error;

@end

@interface MMCLController : NSObject <CLLocationManagerDelegate>
{
    id delegate;
}
    //Your location manager
@property (retain, nonatomic) CLLocationManager * misterLocationmanager;

@property id <MMCLControllerDelegate> delegate;

@end
