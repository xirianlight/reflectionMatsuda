//
//  MMViewController.h
//  EveningHack2_11
//
//  Created by Ross Matsuda on 2/11/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMViewController : UIViewController <UITextFieldDelegate>
    @property (strong, nonatomic) IBOutlet UITextField *songTitleTextField;
    @property (strong, nonatomic) IBOutlet UITextField *artistTextField;
    @property (strong, nonatomic) IBOutlet UITextField *albumTextField;
    @property (strong, nonatomic) IBOutlet UITextField *genreTextField;
- (IBAction)submitButton:(id)sender;
- (IBAction)tapScreen:(id)sender;

@end
