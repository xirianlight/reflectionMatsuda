//
//  MMViewController.m
//  MapExercise_02_25
//
//  Created by Ross Matsuda on 2/25/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"
#import "MMAnnotation.h"
#import "MMCLController.h"
@interface MMViewController ()
{
    
    __weak IBOutlet MKMapView *myMapView;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        //First, setting the map TYPE
    myMapView.mapType = MKMapTypeHybrid;
    
    MMCLController *newLocationController = [[MMCLController alloc]init];
    NSLog(@"%@", newLocationController);
    
        //Set a GPS location
    CLLocationCoordinate2D mobileMakersLocation =
    {
        .latitude = 41.894032,
        .longitude = -87.634642
    };
    
    //Decide what the default zoom level should be
    MKCoordinateSpan mySpan =
    {
        .latitudeDelta = 0.01,
        .longitudeDelta = 0.01
    };
    
    //Make these choices into a region
    MKCoordinateRegion myRegion = {mobileMakersLocation, mySpan};
    
    //HOLY CRAP A PIN! A PIN!

    MMAnnotation *mobileMakersAnnotation = [[MMAnnotation alloc]init];
    mobileMakersAnnotation.title = @"MobileMakers";
    mobileMakersAnnotation.subtitle = @"Where Makers Git Mobile";
    mobileMakersAnnotation.coordinate = mobileMakersLocation;
    
    [myMapView addAnnotation:mobileMakersAnnotation];
    
    
    
    //Set the default view ot the region we defined
    myMapView.region = myRegion;
    
    
}

-(MKAnnotationView *) mapView:(MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation
{
    //Create a disclosure button
    UIButton *detailButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
    //Build your annotationView
    MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation"];
    
    if (annotationView == nil){
        annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"mmlogo_mini.png"];
    //Add right accessory
    [detailButton addTarget:self
                     action:@selector(showDetail)
           forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = detailButton;
    
    //Add left accessory
    UIImageView *sfIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mmlogo_mini.png"]];
    annotationView.leftCalloutAccessoryView = sfIconView;
    
	return annotationView;
}

-(IBAction) returned: (UIStoryboardSegue *)segue
{
	NSLog(@"this is the log");
}


-(void) showDetail
{
    NSLog (@"No biggie");
    
    [self performSegueWithIdentifier:@"segueToDetailView" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog (@"To this segue");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
