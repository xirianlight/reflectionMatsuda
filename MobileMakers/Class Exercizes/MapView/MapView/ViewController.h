//
//  ViewController.h
//  MapView
//
//  Created by Don Bora on 2/25/13.
//  Copyright (c) 2013 Don Bora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager * missLocationmanager;
}

-(void) startLocationUpdates;

-(void) updateMyCurrentLocationWithCoordinate:(CLLocationCoordinate2D) newLocation;

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation;
@end
