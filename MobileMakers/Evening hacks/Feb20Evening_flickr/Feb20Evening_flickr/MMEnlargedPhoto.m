//
//  MMEnlargedPhoto.m
//  Feb20Evening_flickr
//
//  Created by Ross Matsuda on 2/21/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMEnlargedPhoto.h"

@interface MMEnlargedPhoto ()

@end

@implementation MMEnlargedPhoto
@synthesize photoFromTable, urlFromTableString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //PROCESSING BRAH
    
    NSString *pictureFarmID = [photoFromTable objectForKey:@"farm"];
    NSString *pictureServerID = [photoFromTable objectForKey:@"server"];
    NSString *pictureID = [photoFromTable objectForKey:@"id"];
    NSString *pictureSecret = [photoFromTable objectForKey:@"secret"];
    
    NSString *pictureURLString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_n.jpg", pictureFarmID, pictureServerID, pictureID, pictureSecret];
    NSLog(@"%@", pictureURLString);
    //The above string works when pasted in Safari
    //Now let's get that picture as a PICTURE
    
    //NSURL *pictureURL = [NSURL URLWithString:pictureURLString];
    NSData *pictureJPGData = [NSData dataWithContentsOfURL:[NSURL URLWithString:pictureURLString]];
    UIImage *pictureJPG = [UIImage imageWithData:pictureJPGData];
    //The above line finally gets the picture, so let's put it in a cell.
    
    //UIView *pictureViewToImage = [customCell viewWithTag:50];
    
    UIImageView *picture2display = (UIImageView *) enlargedPhoto;
    picture2display.image = pictureJPG;

    
    
}












- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
