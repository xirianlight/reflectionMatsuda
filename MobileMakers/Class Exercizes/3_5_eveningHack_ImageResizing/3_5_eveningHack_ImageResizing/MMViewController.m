//
//  MMViewController.m
//  3_5_eveningHack_ImageResizing
//
//  Created by Ross Matsuda on 3/5/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()
{
    __weak IBOutlet UIImageView *firstImageResult;
    __weak IBOutlet UIImageView *secondImageResult;

    __weak IBOutlet UIImageView *fourthImageResult;
    __weak IBOutlet UIImageView *thirdImageResult;
    __weak IBOutlet UIActivityIndicatorView *activityWheel;
    __weak IBOutlet UITextField *searchTextField;
    NSMutableArray *searchResults;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma Flickr Specific

- (void) submitFlickrSearch
{
    [activityWheel startAnimating];
    //Set search text field as search query text.
    NSString * searchText = searchTextField.text;
    
    //JSON Query URL based on search text field
        NSString *flickrURLString =[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=b4a287d18b3f7398ffb4ab9f1b961e22&lat=41.894032&lon=-87.634742&radius=6&extras=geo&accuracy=14&tags=%@&format=json&nojsoncallback=1", searchText];
    
    //Code to go from URL string to JSON request
    NSURL *flickrURL = [NSURL URLWithString:flickrURLString];
    NSMutableURLRequest *flickrURLRequest = [NSMutableURLRequest requestWithURL:flickrURL];
    flickrURLRequest.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:flickrURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^void(NSURLResponse *myResponse, NSData *myData, NSError *myError)
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
             NSMutableDictionary * photosDictionary = (NSMutableDictionary *) genericObjectWeKnowIsDictionary;
             NSMutableDictionary *secondDictionary = [photosDictionary valueForKey:@"photos"];
             searchResults = [secondDictionary valueForKey:@"photo"];
             
             NSLog(@"%@", [photosDictionary valueForKey:@"pages"]);
             
             //If no search results, display error
             if ([searchResults count]==0)
             {
                 searchTextField.text = @"";
                 UIAlertView *noResultsAlert;
                 noResultsAlert = [[UIAlertView alloc]
                                   initWithTitle:@"No results"
                                   message:@"0 results for that search in this area"
                                   delegate:self
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles: nil];
                 [noResultsAlert show];
             }
             //Otherwise, let's download a picture
             //First picture
             NSDictionary *dictionaryForSinglePhoto = [searchResults objectAtIndex:0];
             NSString *farmString = [dictionaryForSinglePhoto valueForKey:@"farm"];
             NSString *serverString = [dictionaryForSinglePhoto valueForKey:@"server"];
             NSString *idString = [dictionaryForSinglePhoto valueForKey:@"id"];
             NSString *secretString = [dictionaryForSinglePhoto valueForKey:@"secret"];
             NSString *titleString  = [dictionaryForSinglePhoto valueForKey:@"title"];
             
             //Logs out the titles of photos as they load.
             NSLog(@"%@", titleString);
             //making that info into a request for a photo
             NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_n.jpg", farmString, serverString, idString, secretString];
             NSURL *photoURL = [NSURL URLWithString:photoURLString];
             //making the request online for the photo
             NSData *photoData = [NSData dataWithContentsOfURL:photoURL];
             UIImage *photoImage = [UIImage imageWithData:photoData];
             firstImageResult.image = photoImage;
             
             //this is the kind of line you want to have instead of ^
             //firstImageResult.image = [self getPhotoFrom:searchResults at:0];
             
             
                //size should be 320x216 tall
             
             //Second picture
             //NSDictionary *dictionaryForSinglePhoto2 = [searchResults objectAtIndex:1];
             //NSString *farmString2 = [dictionaryForSinglePhoto2 valueForKey:@"farm"];
             //NSString *serverString2 = [dictionaryForSinglePhoto2 valueForKey:@"server"];
             //NSString *idString2 = [dictionaryForSinglePhoto2 valueForKey:@"id"];
             
             //NSString *secretString2 = [dictionaryForSinglePhoto2 valueForKey:@"secret"];
             //NSString *titleString2  = [dictionaryForSinglePhoto2 valueForKey:@"title"];
             
             //Logs out the titles of photos as they load. Nice
             //NSLog(@"%@", titleString2);
             //making that info into a request for a photo
             //NSString *photoURLString2 = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_n.jpg", farmString2, serverString2, idString2, secretString2];
             //NSURL *photoURL2 = [NSURL URLWithString:photoURLString2];
             //making the request online for the photo
             //NSData *photoData2 = [NSData dataWithContentsOfURL:photoURL2];
             //UIImage *photoImage2 = [UIImage imageWithData:photoData2];
             
             secondImageResult.image = photoImage;
             [activityWheel stopAnimating];
             
             [UIView beginAnimations:nil context:nil];
             [UIView setAnimationDuration:0.75];
             searchTextField.alpha = 0.4;
             [UIView commitAnimations];
             
             //Apply mask
             UIImage * mask = [UIImage imageNamed:@"mask.png"];
             UIImage *maskedFirstImage = [self createMaskWith:mask onImage:photoImage];
             
             //Resize and confirm location
             float sizeScaled = 0.5 * 320;
             CGSize sizeOfNewImage = CGSizeMake(sizeScaled, 108);
             
             //Start a new context with size defined above
             UIGraphicsBeginImageContext(sizeOfNewImage);
             
             //Picture of he context we're using
             CGContextRef context = UIGraphicsGetCurrentContext();
             //Draw jake in a rectangle
             [maskedFirstImage drawInRect:CGRectMake(0, 0, sizeOfNewImage.width, sizeOfNewImage.height)];
             
             UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
             CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
             
             UIGraphicsEndImageContext();
             [UIView beginAnimations:nil context:nil];
             [UIView setAnimationDuration:1];
             secondImageResult.alpha = 1;
             [UIView commitAnimations];
             
             
             firstImageResult.image = scaledImage;
             firstImageResult.frame = CGRectMake(0, 0, sizeOfNewImage.width, sizeOfNewImage.height);
             firstImageResult.center = CGPointMake(220, 320);
             
             [UIView beginAnimations:nil context:nil];
             [UIView setAnimationDuration:2];
             firstImageResult.alpha = 0.66;
             [UIView commitAnimations];
             
             
         }
     }];
}



#pragma User Interface buttons and keyboard

//When return is tapped, submit search, make images disappear, move search field
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self submitFlickrSearch];
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.2];
    firstImageResult.alpha = 0;
    secondImageResult.alpha = 0;
    searchTextField.center = CGPointMake(160, 513);
    
    [UIView commitAnimations];


    return YES;
}

//When text field is tapped, raise to accomodate keybaord, set opaque
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    textField.alpha = 1;
    searchTextField.center = CGPointMake(160, 310);
    [UIView commitAnimations];
}

//Method to apply mask to image
- (UIImage*) createMaskWith: (UIImage *)maskImage onImage:(UIImage*) subjectImage
{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef),
                                        NULL,
                                        false);
    
    CGImageRef masked = CGImageCreateWithMask(subjectImage.CGImage, mask);
    
    UIImage *finalImage = [UIImage imageWithCGImage:masked];
    return finalImage;
}


//End of project
//
//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
