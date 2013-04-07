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
    Annotation *myAnnotation;
}
@end

@implementation ViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self startLocationUpdates];
    myMapView.mapType = MKMapTypeHybrid;
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
    myAnnotation = [[Annotation alloc] init];
    myAnnotation.title = @"MobileMakers";
   // myAnnotation.coordinate = mmCoordinate;
       [self updateMyCurrentLocationWithCoordinate:mmCoordinate];
    myAnnotation.subtitle = @"Is bigger than Jesus";
    
    [myMapView setRegion:myRegion];
    [myMapView addAnnotation:myAnnotation];
 

    
    
    
}

    //Process location data from  API
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Lat: %f — Long: %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [self updateMyCurrentLocationWithCoordinate:newLocation.coordinate];
}

    //Reset centre of mapView
-(void) updateMapViewWithNewCenter: (CLLocationCoordinate2D) newCoordinate
{
//    MKCoordinateSpan defaultSpan =
//    {
//        .latitudeDelta = 0.002f,
//        .longitudeDelta = 0.002f
//    };
    MKCoordinateRegion newRegion = {newCoordinate, myMapView.region.span};
    [myMapView setRegion:newRegion];
}
    //Begin processing location data
-(void) startLocationUpdates
{
    if(missLocationmanager == nil)
    {
        missLocationmanager = [[CLLocationManager alloc]init];
    }
    missLocationmanager.delegate = self;
    missLocationmanager.desiredAccuracy = kCLLocationAccuracyBest;
    [missLocationmanager startMonitoringSignificantLocationChanges];
    //[missLocationmanager startUpdatingLocation];
}
    //Update location, recentre map
-(void) updateMyCurrentLocationWithCoordinate:(CLLocationCoordinate2D) newLocation
{
    myAnnotation.coordinate = newLocation;
    [self updateMapViewWithNewCenter:newLocation];
    
}
    //Tap detailDisclosure button
-(void)showDetail
{
    NSLog(@"DetailDisclosure button pressed");
    [self performSegueWithIdentifier:@"segueToDetail" sender:self];
    
}
    //Define your annotation
-(MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    MKAnnotationView *pinView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation"];
    
    if (pinView == nil) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    }
    
    [detailButton addTarget:self
                     action:@selector(showDetail)
           forControlEvents:UIControlEventTouchUpInside];
//    pinView.pinColor = MKPinAnnotationColorPurple;
    pinView.canShowCallout = YES;
    //annotationView.image = [UIImage imageNamed:@"mobile-makers-logo.png"];
    pinView.rightCalloutAccessoryView = detailButton;
    
    UIImageView * tinyBurger = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"burger.png"]];
    pinView.leftCalloutAccessoryView = tinyBurger;
    
    return pinView;
}

    //Outlet to unwind back to this mapView
-(IBAction) unwindToMapView: (UIStoryboardSegue *)segue
{
	NSLog(@"Successfully unwound to mapView");
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //No code here yet
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







