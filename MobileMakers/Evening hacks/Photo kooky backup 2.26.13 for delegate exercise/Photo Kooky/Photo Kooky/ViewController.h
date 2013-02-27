//
//  ViewController.h
//  Photo Kooky
//
//  Created by David Johnston on 2/20/13.
//  Copyright (c) 2013 David Johnston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMFlickrController.h"
@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDelegate, UITextFieldDelegate, flickrAPIDelegate>

-(IBAction)unwindToSearchTableView:(UIStoryboardSegue *)segue;


@end
