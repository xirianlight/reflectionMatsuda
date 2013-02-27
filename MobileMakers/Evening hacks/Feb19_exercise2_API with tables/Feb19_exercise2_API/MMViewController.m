//
//  MMViewController.m
//  Feb19_exercise2_API
//
//  Created by Ross Matsuda on 2/19/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()
{
    NSArray *testArray;
}

@end
            //IGNORE ME!!!!!
@implementation MMViewController
@synthesize firstTweet, secondTweet, thirdTweet, tweetTable, tweetArrayForTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

    //Tap on backdrop to remove keyboard
- (IBAction)resignButton:(id)sender
{
    [self.tweetTextBox resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    //COPY PASTED CODE STARTS
    //
    //
    
    [activityWheel startAnimating];
        //Get the query from the textBox
    NSString *currentQuery = self.tweetTextBox.text;
    NSString *baseAPI = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@",currentQuery ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: baseAPI]];
    request.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^void (NSURLResponse *urlResponse, NSData * myData, NSError *errorLog)
     {
         if (errorLog)
         {
             NSLog (@"%@", errorLog.localizedDescription);
         } else
         {
             NSError *jsonError;
             NSDictionary *json =
             [NSJSONSerialization JSONObjectWithData:myData
                                             options:NSJSONReadingAllowFragments
                                               error:&jsonError];
             NSArray *resultsArray = [json valueForKey:@"results"];
                    //Get the objects for value "text" (the tweet body copy)
             self.tweetArrayForTable = [NSMutableArray arrayWithArray:[resultsArray valueForKey:@"text"]];
                    //Get the objects for the value "from_user" (the tweet author)
             self.tweetNamesArrayForTable = [NSMutableArray arrayWithArray:[resultsArray valueForKey:@"from_user"]];       //created_at also works
             
             [tweetTable reloadData];
             [activityWheel stopAnimating];
         }
         
     }];
            //Stupid keyboard
    [textField resignFirstResponder];
          
    return YES;
}
//
//
//


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section, here, generated from tweetArrayForTable.
    return [self.tweetArrayForTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
            //All the schlock to reuse cells
    NSString *CellIdentifier = @"CellID";
    UITableViewCell *tableViewCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableViewCell == nil)
    {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
            //Customize the textLabel color and font
    tableViewCell.textLabel.textColor = [UIColor whiteColor];
    tableViewCell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
            //Populate the textLabel and detailTextLabel
    tableViewCell.textLabel.text = [self.tweetArrayForTable objectAtIndex:indexPath.row];
    tableViewCell.detailTextLabel.text = [self.tweetNamesArrayForTable objectAtIndex:indexPath.row];

    return tableViewCell;
    
}
            //Don't keep things permanently highlighted
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
