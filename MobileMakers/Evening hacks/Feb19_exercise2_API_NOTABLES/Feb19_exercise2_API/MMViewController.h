//
//  MMViewController.h
//  Feb19_exercise2_API
//
//  Created by Ross Matsuda on 2/19/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    
    IBOutlet UIActivityIndicatorView *activityWheel;
}
@property (strong, nonatomic) IBOutlet UILabel *firstTweet;
@property (strong, nonatomic) IBOutlet UILabel *secondTweet;
@property (strong, nonatomic) IBOutlet UILabel *thirdTweet;
@property (strong, nonatomic) IBOutlet UITextField *tweetTextBox;
- (IBAction)reloadButton:(id)sender;
- (IBAction)resignButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tweetTable;
@property (strong, nonatomic) NSMutableArray *tweetArrayForTable;


@end
