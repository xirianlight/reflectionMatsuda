//
//  MMFlickrController.m
//  Photo Kooky
//
//  Created by Ross Matsuda on 2/26/13.
//  Copyright (c) 2013 David Johnston. All rights reserved.
//
// Last big thing to do here is to add in the instance variables, but I'm not sure how those are or aren't gonna play nice with the ones in the primary view controller. Ask about this in the morning.

#import "MMFlickrController.h"

@implementation MMFlickrController

- (void) submitFlickrSearch
{
    [activityWheel startAnimating];
    //Set search text field as search query text.
    searchText = searchTextField.text;
    //Request pictures matching search query
    //Please note that lat/lon/radius are hard-coded for now
    NSString *flickrURLString =[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=b4a287d18b3f7398ffb4ab9f1b961e22&lat=41.894032&lon=-87.634742&radius=3&extras=geo&accuracy=14&tags=%@&format=json&nojsoncallback=1", searchText];
    
    //Code to go from URL string to JSON request
    NSURL *flickrURL = [NSURL URLWithString:flickrURLString];
    NSMutableURLRequest *flickrURLRequest = [NSMutableURLRequest requestWithURL:flickrURL];
    flickrURLRequest.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:flickrURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^void(NSURLResponse *myResponse, NSData *myData, NSError *myError)
     {
         [self processFlickrSearchWithURLResponse:myResponse data:myData error:myError];
     }];
}

-(void) processFlickrSearchWithURLResponse: (NSURLResponse *) myResponse data: (NSData *) myData error: (NSError *) myError
{
    if (myError)
    {
        NSLog(@"%@", myError.localizedDescription);
    }
    else
    {
        NSError *jsonError;
        id  genericObjectWeKnowIsDictionary =
        [NSJSONSerialization JSONObjectWithData:myData
                                        options:NSJSONReadingAllowFragments
                                          error:&jsonError];
        //Extract usable search results from raw JSON data
        photosDictionary = (NSMutableDictionary *) genericObjectWeKnowIsDictionary;
        NSMutableDictionary *secondDictionary = [photosDictionary valueForKey:@"photos"];
        arrayForPhotosArray = [secondDictionary valueForKey:@"photo"];
        
        NSLog(@"%@", [photosDictionary valueForKey:@"pages"]);
        
        [activityWheel stopAnimating];
        [photoTableView reloadData];
        
    }
}





@end
