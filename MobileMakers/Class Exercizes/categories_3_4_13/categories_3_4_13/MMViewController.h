//
//  MMViewController.h
//  categories_3_4_13
//
//  Created by Ross Matsuda on 3/4/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMViewController : UIViewController <UITextFieldDelegate>
{
    
    __weak IBOutlet UIImageView *yinYangSymbol;
    __weak IBOutlet UITextField *textFieldToTypeIn;
    __weak IBOutlet UITextField *textField;
    __weak IBOutlet UILabel *originalString;
    __weak IBOutlet UILabel *reverseString;
}

@end
