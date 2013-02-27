//
//  MMViewController.m
//  Feb20_vokalAPI
//
//  Created by Ross Matsuda on 2/20/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()
{
    
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
    __weak IBOutlet UITableView *vokalTableView;
    NSArray *vokalSpies;
    __weak IBOutlet UILabel *cellContactLabel;
    __weak IBOutlet UILabel *cellNameLabel;
    __weak IBOutlet UIImageView *cellPicture;
    NSString * spyName;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * vokalURLString = @"http://vokal-dev-test.herokuapp.com/api/members";
    NSURL *vokalURL = [NSURL URLWithString:vokalURLString];
	NSMutableURLRequest * vokalURLRequest = [NSMutableURLRequest requestWithURL:vokalURL];
    vokalURLRequest.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:vokalURLRequest
queue:[NSOperationQueue mainQueue]
completionHandler:^void (NSURLResponse * vokalResponse, NSData* vokalData, NSError * vokalError)
    {
        //Making sure we get an error or not
        if (vokalError)
        {
            NSLog(@"%@", vokalError.localizedDescription);
        } else
            
        {
            //Code here, brah!!!! We gotta convert it from NSData to something usable
            NSError *jsonError;
            id jsonRawData = [NSJSONSerialization JSONObjectWithData:vokalData options:NSJSONReadingAllowFragments error:&jsonError];
            vokalSpies = (NSArray *)jsonRawData;
            NSLog(@"%@", vokalSpies);
                //The above line tells the jsonRawData that we're ASSIGNING it the type NSArray
            
            
            //Next, reload data and stop animating
            [vokalTableView reloadData];
        
        }
        
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Code Goes Here
    if (vokalSpies == nil)
    {
        return 0;
    } else
        
    {
        return vokalSpies.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Code Goes Here
    [activityIndicator startAnimating];
    UITableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifierRolodex"];

    NSDictionary *spyRecord = [vokalSpies objectAtIndex:[indexPath row]];
            //A string for the name
    spyName = [spyRecord valueForKey:@"name"];
            //A string for the URL of the picture to load
    NSString *spyPictureString = [spyRecord valueForKey:@"avatar_url"];
    NSURL *spyPictureURL = [NSURL URLWithString:spyPictureString];
    NSData *spyPictureData = [NSData dataWithContentsOfURL:spyPictureURL];
    UIImage *spyPicture = [UIImage imageWithData:spyPictureData];
    
    
    UIView *spyPictureViewToImage = [customCell viewWithTag:102];
    UIImageView *spyPicture2display = (UIImageView *) spyPictureViewToImage;
    spyPicture2display.image = spyPicture;
    
    
    
    //Populate all cells with data
    UIView * emailViewToLabel = [customCell viewWithTag:101];
    UILabel *spyEmailLabel = (UILabel *) emailViewToLabel;
    spyEmailLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:12];
    spyEmailLabel.text = [spyRecord valueForKey:@"email"];

    UIView *viewThatsALabel = [customCell viewWithTag:100];
    UILabel *spyNameLabel = (UILabel *)viewThatsALabel;
    spyNameLabel.text = spyName;
    
   // customCell.imageView.image = spyPicture;
    [activityIndicator stopAnimating];
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *currentSpy = [vokalSpies objectAtIndex:[indexPath row]];
    NSString *currentSpyName = [currentSpy objectForKey:@"name"];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:currentSpyName
                                          message:@"Nope"
                                         delegate:self
                          
                                cancelButtonTitle:@"OK, I'm sorry"
                                otherButtonTitles: nil];;

        [alert show];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
