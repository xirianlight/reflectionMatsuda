//
//  MMAnnotation.h
//  MapExercise_02_25
//
//  Created by Ross Matsuda on 2/25/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MMAnnotation : NSObject <MKAnnotation>
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) UIImage *pinPicture;


@end
