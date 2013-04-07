Readme.txt
Notes about class structure for WhereTo

AppDelegate - 

Venue - Venue metadata and nearby flickr picture URL's
	CORE DATA

APIManager - Yelp and Flickr results
	
LocationManager - inits with current location
	Used for all workings with locationServices

ResultsManager - More on this later

YelpMapViewController - primary view controller

Annotation - Just for custom annotations on the map

DataSourceDelegate - More on this later


Loading screen - for branding and covering loading screen.

Annotation shtick
MKUserLocation is the type of annotation we should use for a MapView where we are accessing the user's current location using MapKit.

    //If statement just in case annotation is MKCurrentLocation
    if([annotation isKindOfClass: [MKUserLocation class]])
    {
        return nil;
    }

Include the above line in the method to customize your annotations:
-(MKPinAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation

As long as those conditions are met, when you make your object for userLocation, make it
MKUserLocation * myLocation;

__________________________________

FlipView implementation - import the entire framework
After working on a project
git add, commit, switch to master, merge, pull