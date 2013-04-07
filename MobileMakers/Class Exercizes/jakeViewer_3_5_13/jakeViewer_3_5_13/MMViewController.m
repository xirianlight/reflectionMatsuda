//
//  MMViewController.m
//  jakeViewer_3_5_13
//
//  Created by Ross Matsuda on 3/5/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+basicAnimations.h"
@interface MMViewController ()
{
    __weak IBOutlet UIButton *crazyButton;
    UIImage *jake;
    UIImageView *myViewOfJake;
    UIImage *maskedJake;
    __weak IBOutlet UISlider *sizeSlider;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    jake = [UIImage imageNamed:@"jake.png"];
    UIImage * mask = [UIImage imageNamed:@"mask.png"];
    UIImage * chest = [UIImage imageNamed:@"Treasure Chest.gif"];
    maskedJake = [self createMaskWith:mask onImage:jake];
    myViewOfJake = [[UIImageView alloc] initWithImage:maskedJake];
    sizeSlider.thumbTintColor = [UIColor blackColor];

    sizeSlider.minimumTrackTintColor = [UIColor blackColor];
    [self.view addSubview:myViewOfJake];
    myViewOfJake.center = self.view.center;

    

}
- (IBAction)valueOfSlider:(id)sender
{
    NSLog(@"Value if %f", sizeSlider.value);
    //This line actually matches the size of the image to the position of the slider
    float sizeScaled = sizeSlider.value * 512;
    //Create a size object that gets value from the slider
    CGSize sizeOfNewImage = CGSizeMake(sizeScaled, sizeScaled);
    
    //Start a new context with size defined above
    UIGraphicsBeginImageContext(sizeOfNewImage);
    
    //Picture of he context we're using
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Draw jake in a rectangle
    [maskedJake drawInRect:CGRectMake(0, 0, sizeOfNewImage.width, sizeOfNewImage.height)];
     
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);

    UIGraphicsEndImageContext();
    
    myViewOfJake.image = scaledImage;
    myViewOfJake.alpha = sizeSlider.value;
    myViewOfJake.frame = CGRectMake(0, 0, sizeOfNewImage.width, sizeOfNewImage.height);
    myViewOfJake.center = self.view.center;
    
    
    
}

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

- (IBAction)pressCrazyButton:(id)sender
{
    [myViewOfJake rotateIt];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
