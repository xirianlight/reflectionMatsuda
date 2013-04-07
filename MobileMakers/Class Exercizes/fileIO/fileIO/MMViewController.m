//
//  MMViewController.m
//  fileIO
//
//  Created by Ross Matsuda on 3/13/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Put the image we're gonna download in a view.
    UIImageView *mrLogoView = [[UIImageView alloc]initWithImage:[self getImageOfMRLogo]];
    [self.view addSubview:mrLogoView];
    mrLogoView.center = super.view.center;
    
    //JPG version!
//    NSString *jpgPath = [NSString stringWithFormat:@"%@/mrlogo.jpg", documentPath];
//    NSData * dataJPG = [NSData dataWithData:UIImageJPEGRepresentation(mrLogo, 1.0f)];
//    [dataJPG writeToFile:jpgPath atomically:YES];
    
}

-(UIImage*) getImageOfMRLogo
{
    //http://cdn.macrumors.com/images-new/logo.png
    //File storage code
    NSArray *possibleDocPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [possibleDocPaths objectAtIndex:0];
    NSLog(@"Document path: %@", documentPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pngPath = [NSString stringWithFormat:@"%@/mrlogo.png", documentPath];
    UIImage * mrlogoImage;
    
    //Did we download that image?
    BOOL doesLogoImageExist = [fileManager fileExistsAtPath:pngPath];
    
    //if we do...
    if (doesLogoImageExist)
    {
        mrlogoImage = [[UIImage alloc]initWithContentsOfFile:pngPath];
    }
    else
    {
            //Download it!
        NSString *imageURLString = @"http://cdn.macrumors.com/images-new/logo.png";
        mrlogoImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]]];
        NSData *dataPNG = [NSData dataWithData:UIImagePNGRepresentation(mrlogoImage)];
        [dataPNG writeToFile:pngPath atomically:YES];
        
    }

    return mrlogoImage;
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
