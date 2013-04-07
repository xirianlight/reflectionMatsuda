//
//  MMViewController.m
//  Feb20_vokalAPI
//
//  Created by Ross Matsuda on 2/20/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"
#import <CoreData/CoreData.h>
#import "person.h"
#import "MMAppDelegate.h"

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
            //Create a reference to yoru AppDelegate
            MMAppDelegate * mmAppDelegate = (MMAppDelegate*) [[UIApplication sharedApplication] delegate];
            
            
            NSError *error;
            id jsonRawData = [NSJSONSerialization JSONObjectWithData:vokalData options:NSJSONReadingAllowFragments error:&error];
            NSArray * jsonArray = (NSArray *)jsonRawData;
            NSLog(@"%@", jsonArray);
                //The above line tells the jsonRawData that we're ASSIGNING it the type NSArray
            //Let's turn this array INTO PEOPLE! IT'S PEOPLE!
            //This iterates thruogh the array and feeds the data into a temporary dictionary called 'dictionary'
            for (NSDictionary * dictionary in jsonArray)
            {
                Person * person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:mmAppDelegate.managedObjectContext];
                //This makes the new entity to fill
                person.name = [dictionary valueForKey: @"name"];
                person.email = [dictionary valueForKey: @"email"];
                person.photoURL = [dictionary valueForKey: @"avatar_url"];
            }
            //So, all those are now enumerated. Let's save and verify the save completed.
            if (![mmAppDelegate.managedObjectContext save:&error])
            {
                NSLog(@"Failed to save: %@", [error userInfo]);
            }
            
            //Now flip a bool that states that we successfully pulled some data!
            
            
            vokalSpies = [mmAppDelegate allEntitiesNamed:@"Person"];
            
            //Next, reload data and stop animating
            [vokalTableView reloadData];
        
        }
        
    }];
    
    
}

-(void) hasDataBeenLoadedIntoCoreDataBefore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
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
    NSString *spyPictureString = [spyRecord valueForKey:@"photoURL"];
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
