//
//  MMViewController.m
//  Feb19_exercise2_API
//
//  Created by Ross Matsuda on 2/19/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController
@synthesize firstTweet, secondTweet, thirdTweet, tweetTable;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

          
      
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reloadButton:(id)sender {
    [activityWheel startAnimating];
    NSString *currentQuery = self.tweetTextBox.text;
    NSString *baseAPI = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@",currentQuery ];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: baseAPI]];
    request.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^void (NSURLResponse *urlResponse, NSData * myData, NSError *errorLog)
     {
         if (errorLog) {
          
             
             NSLog (@"%@", errorLog.localizedDescription);
         } else {
             NSError *jsonError;
             NSDictionary *json =
             [NSJSONSerialization JSONObjectWithData:myData
                                             options:NSJSONReadingAllowFragments
                                               error:&jsonError];
             NSArray *resultsArray = [json valueForKey:@"results"];
             
             NSDictionary *singleResult = [resultsArray objectAtIndex:(arc4random()%10)];
             NSString *tweet = [singleResult valueForKey:@"text"];
             firstTweet.text = tweet;
             
             NSDictionary *secondResult = [resultsArray objectAtIndex:(arc4random()%10)];
             NSString *tweet2 = [secondResult valueForKey:@"text"];
             secondTweet.text = tweet2;
             
             NSDictionary *thirdResult = [resultsArray objectAtIndex:(arc4random()%10)];
             NSString *tweet3 = [thirdResult valueForKey:@"text"];
             thirdTweet.text = tweet3;
             [activityWheel stopAnimating];
             
             //Table code
           //  self.tweetTable = [NSArray arrayWithArray:resultsArray];
           //  [self.tweetTable reloadData];
         }
         
     }];
        [self.tweetTextBox resignFirstResponder];
}

- (IBAction)resignButton:(id)sender {
    [self.tweetTextBox resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    //COPY PASTED CODE STARTS
    //
    //
    
[activityWheel startAnimating];
        NSString *currentQuery = self.tweetTextBox.text;
    NSString *baseAPI = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@",currentQuery ];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: baseAPI]];
    request.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^void (NSURLResponse *urlResponse, NSData * myData, NSError *errorLog)
     {
         if (errorLog) {
             
             
             NSLog (@"%@", errorLog.localizedDescription);
         } else {
             NSError *jsonError;
             NSDictionary *json =
             [NSJSONSerialization JSONObjectWithData:myData
                                             options:NSJSONReadingAllowFragments
                                               error:&jsonError];
             NSArray *resultsArray = [json valueForKey:@"results"];
             
             NSDictionary *singleResult = [resultsArray objectAtIndex:(arc4random()%10)];
             NSString *tweet = [singleResult valueForKey:@"text"];
             firstTweet.text = tweet;
             
             NSDictionary *secondResult = [resultsArray objectAtIndex:(arc4random()%10)];
             NSString *tweet2 = [secondResult valueForKey:@"text"];
             secondTweet.text = tweet2;
             
             NSDictionary *thirdResult = [resultsArray objectAtIndex:(arc4random()%10)];
             NSString *tweet3 = [thirdResult valueForKey:@"text"];
             thirdTweet.text = tweet3;
             
             
         }
         
     }];
    [textField resignFirstResponder];
    [activityWheel stopAnimating];      //Why doesn't this work!?
    return YES;
}
//
//
//


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section, here, 10.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellID";
    UITableViewCell *tableViewCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    tableViewCell.textLabel.text = @"ross";

    
    return tableViewCell;
    
}
    

@end
