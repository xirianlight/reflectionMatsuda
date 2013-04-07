//
//  MMViewController.m
//  Feb20_vokalAPI
//
//  Created by Ross Matsuda on 2/20/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"
#import "MMAppDelegate.h"
#import "Person.h"
#import "Freak.h"
#import "Geek.h"

@interface MMViewController () <UISearchBarDelegate>
{
    
    __weak IBOutlet UISearchBar *searchbar;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
    __weak IBOutlet UITableView *vokalTableView;
    NSArray *vokalSpies;
    NSArray * displaySpies;
    __weak IBOutlet UILabel *cellContactLabel;
    __weak IBOutlet UILabel *cellNameLabel;
    __weak IBOutlet UIImageView *cellPicture;
    NSString * spyName;
    NSString * mySearchText;
    Geek * geek;
    Freak * freak;
    
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    vokalSpies = [[NSArray alloc] init];
    displaySpies = [[NSArray alloc]init];
    mySearchText = @"";
    MMAppDelegate *mmAppDelegate = (MMAppDelegate*)[[UIApplication sharedApplication] delegate];
    self.myManagedObjectContext = mmAppDelegate.managedObjectContext;
    //Instantiate your freak and geek lists
    geek = [NSEntityDescription insertNewObjectForEntityForName: @"Geek" inManagedObjectContext: self.myManagedObjectContext];
    freak = [NSEntityDescription insertNewObjectForEntityForName: @"Freak" inManagedObjectContext: self.myManagedObjectContext];
    
    
    //Check the status of our Core Data store - is anything in thar?
    NSLog(@"Has Core Data been populated previously? %d", [self didIReceiveTheData]);
    //Crazy if statement goes here!
    //Empty the database and rebuild it if so
        
    NSError * sqlResetError;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *sqliteURL = [documentsDirectory URLByAppendingPathComponent:@"Model.sqlite"];
    [fileManager removeItemAtURL:sqliteURL error:&sqlResetError];


    


    
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
             
             NSError *error;
             id jsonRawData = [NSJSONSerialization JSONObjectWithData:vokalData options:NSJSONReadingAllowFragments error:&error];
             NSArray *jsonArray = (NSArray *)jsonRawData;
             NSLog(@"%@", jsonArray);
             
             for (NSDictionary *dictionary in jsonArray)
             {
                 Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.myManagedObjectContext];
                 
                 person.name = [dictionary valueForKey:@"name"];
                 person.email = [dictionary valueForKey:@"email"];
                 person.photoURL = [dictionary valueForKey:@"avatar_url"];
             }
             
             if (![self.myManagedObjectContext save:&error]) {
                 NSLog(@"failed to save: %@", [error userInfo]);
             }
             //The above line tells the jsonRawData that we're ASSIGNING it the type NSArray
             
             //Flip flag that states that data has been loaded into CoreData
             [self iHaveReceivedTheData];
             
             vokalSpies = [self allEntitiesNamed:@"Person"];
             displaySpies = vokalSpies;
             //Next, reload data and stop animating
             [vokalTableView reloadData];
             
         }
         
     }];
    
    
}

#pragma mark -- CRUD
//Creation
-(void) createPersonWithName: (NSString*)name email:(NSString*)email andPhotoURL:(NSString*)photoURL
{
    Person * person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.myManagedObjectContext];
    person.name = name;
    person.email = email;
    person.photoURL = photoURL;
    [self freakOrGeek:person];
    
    //Save it
    NSError *error;
    if (![self.myManagedObjectContext save:&error])
    {
        NSLog(@"poop my pants, it didnt work.");
    }
}


-(void) freakOrGeek: (Person*) person
{
    if ((arc4random()%2))
    {
        [geek addPersonObject:person];
    }
    else
    {
        [freak addPersonObject:person];
    }
}



//Read
-(Person*)getPersonWithName: (NSString*)name
{
    //More on this later
    //FETCH DATA COPY PASTED
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.myManagedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]init];
    NSFetchedResultsController * fetchResultsController;
    
    //Now customize your search!
    NSArray * sortDescriptors = [[NSArray alloc] initWithObjects:nil];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"name contains[c] '%@'", name]];
    NSError *searchError;
    
    //Lock and load
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entityDescription];
    fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.myManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [fetchResultsController performFetch:&searchError];
    //END DATA COPY PASTED
    Person * person;
    return person;
}

//Update
-(void)updatePerson: (Person*)person withPhotoURL: (NSString*)photoURL
{
    person.photoURL = photoURL;
    NSError *error;
    if (![self.myManagedObjectContext save:&error])
    {
        NSLog(@"Update person method failed.");
    }
}


//Delete
-(void)deletePerson: (Person*)person
{
    [self.myManagedObjectContext deleteObject:person];
    NSError *error;
    if (![self.myManagedObjectContext save:&error])
    {
        NSLog(@"Delete Person method failed.");
    }
}

//To enter the basic fetch request (automated)
-(NSArray *)allEntitiesNamed:(NSString *)entityName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.myManagedObjectContext];
    NSError *error;
    
    fetchRequest.entity = entity;
    
    return [self.myManagedObjectContext executeFetchRequest:fetchRequest error:&error];
}

-(void) iHaveReceivedTheData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"didIGetData"];
    //Save this new key to disk
    [defaults synchronize];
}

-(BOOL) didIReceiveTheData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL didIGetData = (BOOL) [defaults objectForKey:@"didIGetData"];
    return didIGetData;
}


#pragma mark -- Table View Code
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Code Goes Here
    if (displaySpies == nil)
    {
        return 0;
    }
    else
    {
        return displaySpies.count;
    }
}

//Deletion method
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person * person = [displaySpies objectAtIndex:indexPath.row];
    [self deletePerson:person];
    
    displaySpies = [self getCurrentSpies];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [tableView reloadData];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Code Goes Here
    [activityIndicator startAnimating];
    UITableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifierRolodex"];
    
    Person *spyRecord = [displaySpies objectAtIndex:[indexPath row]];
    //A string for the name
    spyName = spyRecord.name;
    //A string for the URL of the picture to load
    NSString *spyPictureString = spyRecord.photoURL;
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
    spyEmailLabel.text = spyRecord.email;
    
    UIView *viewThatsALabel = [customCell viewWithTag:100];
    UILabel *spyNameLabel = (UILabel *)viewThatsALabel;
    spyNameLabel.text = spyName;
    
    // customCell.imageView.image = spyPicture;
    [activityIndicator stopAnimating];
    return customCell;
}

//Do shit when you click on a spy
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // NSDictionary *currentSpy = [vokalSpies objectAtIndex:[indexPath row]];
    
    Person *spyRecord = [displaySpies objectAtIndex:[indexPath row]];
    //A string for the name
    //spyName = spyRecord.name;
    
    NSString *currentSpyName = spyRecord.name;//[currentSpy valueforkey s:@"name"];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:currentSpyName
                                                    message:@"I AM SO TIRED"
                                                   delegate:self
                          
                                          cancelButtonTitle:@"OK, I'm sorry"
                                          otherButtonTitles: nil];;
    
    [alert show];
    
}


# pragma mark -- Search Bar Behavior

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"this was typed in::%@", searchText);
    mySearchText = searchText;
    displaySpies = [self getCurrentSpies];
    [vokalTableView reloadData];

    
}
//Fetch request
-(NSArray*) getCurrentSpies
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.myManagedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]init];
    NSFetchedResultsController * fetchResultsController;
    
    //Now customize your search!
    NSArray * sortDescriptors = [[NSArray alloc] initWithObjects:nil];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"name contains[c] '%@'", mySearchText]];
    NSError *searchError;
    
    if ([mySearchText isEqualToString:@""])
    {
        predicate = nil;
    }
    
    //Lock and load
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entityDescription];
    fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.myManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [fetchResultsController performFetch:&searchError];
    //Something about making the arrays equal size or some shit. Gawd.
    displaySpies = fetchResultsController.fetchedObjects;
//    [vokalTableView reloadData];
    

    return fetchResultsController.fetchedObjects;

}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
