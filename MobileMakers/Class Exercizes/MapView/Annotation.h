//
//  Annotation.h
//  MapView
//
//  Created by Don Bora on 2/25/13.
//  Copyright (c) 2013 Don Bora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Annotation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
//struct is a container of primitives
//structs don't have methods
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;


@end
