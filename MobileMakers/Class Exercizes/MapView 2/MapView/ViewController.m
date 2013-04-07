//
//  ViewController.m
//  MapView
//
//  Created by Don Bora on 2/25/13.
//  Copyright (c) 2013 Don Bora. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface ViewController ()
{
    IBOutlet MKMapView *myMapView;
    Annotation *myAnnnotation;
}
@end

@implementation ViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self beginLocationServices];
    CLLocationCoordinate2D mmCoordinate =
    {
        .latitude = 41.894032f,
       .longitude = -87.634742f
    };
    
    //mmCoordinate.latitude = 41.894032f;
    //mmCoordinate.longitude = -87.634742f;
    
    
    MKCoordinateSpan span =
    {
         .latitudeDelta = 0.002f,
        .longitudeDelta = 0.002f
    };
    
    MKCoordinateRegion myRegion = {mmCoordinate, span};
    [myMapView setRegion:myRegion];

    myAnnnotation = [[Annotation alloc] init];
    myAnnnotation.title = @"MobileMakers";
    myAnnnotation.coordinate = mmCoordinate;
    myAnnnotation.subtitle = @"subtitles";
    
    [myMapView addAnnotation:myAnnnotation];
}


#pragma Location Management

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    //Insert code here.
    [self updateMyCurrentLocation:newLocation.coordinate];

    NSLog(@"%@", newLocation.description);
}

        //Method to re-center map on current location
-(void) updateMyCurrentLocation: (CLLocationCoordinate2D) newCoordinate
{
    myAnnnotation.coordinate = newCoordinate;
    [self updateMapViewWithNewCenter:newCoordinate];
}

    //Begin location services! Settings for locationManager go here.
-(void) beginLocationServices
{           //If there's no locationManager instance, make one.
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc]init];
    }
        //Set viewcontroller as locationManager's delegate.
        //We're now locationManager's intern.
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //[locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
}

-(void) updateMapViewWithNewCenter: (CLLocationCoordinate2D) newCenter
{
    MKCoordinateRegion newRegion= {newCenter, myMapView.region.span};
    [myMapView setRegion:newRegion];
}

    //Map view annotation code
-(MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation"];
    
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    }
    
    [detailButton addTarget:self
                     action:@selector(showDetail)
           forControlEvents:UIControlEventTouchUpInside];
    //pinView.pinColor = MKAnnotationColorPurple;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"wifiLoc.png"];
    annotationView.rightCalloutAccessoryView = detailButton;
    
    return annotationView;
}


//Detail Disclosure button behavior
-(void)showDetail
{
    NSLog(@"Detail disclosure button pressed");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







