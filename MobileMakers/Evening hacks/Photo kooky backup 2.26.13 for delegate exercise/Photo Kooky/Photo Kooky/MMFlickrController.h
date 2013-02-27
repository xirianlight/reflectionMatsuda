//
//  MMFlickrController.h
//  Photo Kooky
//
//  Created by Ross Matsuda on 2/26/13.
//  Copyright (c) 2013 David Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol flickrAPIDelegate <NSObject>

-(void) processFlickrSearchWithURLResponse: (NSURLResponse *) myResponse data: (NSData *) myData error: (NSError *) myError;
- (void) submitFlickrSearch;

@end

@interface MMFlickrController : NSObject

@end
