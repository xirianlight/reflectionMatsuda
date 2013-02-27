//
//  MMEnlargedPhoto.h
//  Feb20Evening_flickr
//
//  Created by Ross Matsuda on 2/21/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMViewController.h"
@interface MMEnlargedPhoto : UIViewController
{
   
    __weak IBOutlet UIImageView *enlargedPhoto;
}
@property (strong, nonatomic) NSDictionary *photoFromTable;
@property (strong, nonatomic) NSURL *urlFromTableString;


@end
