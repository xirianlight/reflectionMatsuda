//
//  MMViewController.m
//  Feb20Evening_flickr
//
//  Created by Ross Matsuda on 2/20/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"
#import "MMEnlargedPhoto.h"

@interface MMViewController ()
{
    __weak IBOutlet UILabel *textLabel;
    NSArray * flickrDict;
    NSArray * flickrSearchResults;
    NSDictionary * flickrPicture;
    NSURL * pictureURL;
    NSDictionary * actualPhotoDictionary;
    __weak IBOutlet UITableView *tableViewOutlet;
    NSIndexPath * selectedIndexPath;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	//JSON query code
    //The sample search string is currently "portal"
    NSString * flickrURLString = @"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=4dcd4b336fc303a2d36023d3c4c1b214&tags=portal&format=json&nojsoncallback=1";
    NSURL *flickrURL = [NSURL URLWithString:flickrURLString];
	NSMutableURLRequest * flickrURLRequest = [NSMutableURLRequest requestWithURL:flickrURL];
    flickrURLRequest.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:flickrURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^void (NSURLResponse * flirckResponse, NSData* flickrData, NSError * flickrError)
     {
         //Making sure we get an error or not
         if (flickrError)
         {
             NSLog(@"%@", flickrError.localizedDescription);
         } else
             
         {
             //Convert json from NSData to an array
             NSError *jsonError;
             id jsonRawData = [NSJSONSerialization JSONObjectWithData:flickrData options:NSJSONReadingAllowFragments error:&jsonError];
             
             flickrDict = (NSArray *)jsonRawData;
                //Let's get search results from flickr
             NSDictionary * flickrDictLayer1 = [flickrDict valueForKey:@"photos"];
             flickrSearchResults = [flickrDictLayer1 valueForKeyPath:@"photo"];
             
            // NSLog(@"%@", flickrSearchResults);
                //flickrSearchResults is all the search results
//             flickrPicture = [flickrSearchResults objectAtIndex:(arc4random() % (10))];
             //NSLog(@"%@", flickrPicture);
                //flickrPicture actually kicks out a single picture!!!
             
                //Now we have a picture, let's get the URL for it
//             NSString *pictureFarmID = [flickrPicture objectForKey:@"farm"];
//             NSString *pictureServerID = [flickrPicture objectForKey:@"server"];
//             NSString *pictureID = [flickrPicture objectForKey:@"id"];
//             NSString *pictureSecret = [flickrPicture objectForKey:@"secret"];
//             
//             NSString *pictureURLString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_m.jpg", pictureFarmID, pictureServerID, pictureID, pictureSecret];
//             NSLog(@"%@", pictureURLString);
//                //The above string works when pasted in Safari
//                //Now let's get that picture as a PICTURE
//             
//             NSURL *pictureURL = [NSURL URLWithString:pictureURLString];
//             NSData *pictureJPGData = [NSData dataWithContentsOfURL:pictureURL];
//             UIImage *pictureJPG = [UIImage imageWithData:pictureJPGData];
//                //The above line finally gets the picture, so let's put it in a cell.
//             
//             UIView *pictureViewToImage = [customCell viewWithTag:50];
//             UIImageView *picture2display = (UIImageView *) pictureViewToImage;
//             picture2display.image = pictureJPG;
             
        //http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_m.jpg
            [tableViewOutlet reloadData];
             
         }
         
     }];
    
    
}


//TABLE VIEW DATA

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Code Goes Here
//    if (flickrSearchResults == nil)
//    {
//        return 0;
//    } else
//        
//    {
        return flickrSearchResults.count;
   // }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"IdentifierCell"];
    
    //here's the business
    //actualPhotoDictionary = [flickrSearchResults objectAtIndex:[indexPath row]];
    //flickrPicture = [flickrSearchResults objectAtIndex:(arc4random() % (10))];
    flickrPicture = [flickrSearchResults objectAtIndex:indexPath.row];
    NSString *pictureFarmID = [flickrPicture objectForKey:@"farm"];
    NSString *pictureServerID = [flickrPicture objectForKey:@"server"];
    NSString *pictureID = [flickrPicture objectForKey:@"id"];
    NSString *pictureSecret = [flickrPicture objectForKey:@"secret"];
    
    NSString *pictureURLString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_m.jpg", pictureFarmID, pictureServerID, pictureID, pictureSecret];
    NSLog(@"%@", pictureURLString);
    //The above string works when pasted in Safari
    //Now let's get that picture as a PICTURE
    
    pictureURL = [NSURL URLWithString:pictureURLString];
    NSData *pictureJPGData = [NSData dataWithContentsOfURL:pictureURL];
    UIImage *pictureJPG = [UIImage imageWithData:pictureJPGData];
    //The above line finally gets the picture, so let's put it in a cell.
    
    UIView *pictureViewToImage = [customCell viewWithTag:50];
    
    UIImageView *picture2display = (UIImageView *) pictureViewToImage;
    picture2display.image = pictureJPG;
    //customCell.imageView.image = pictureJPG;
    //http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_m.jpg

    UIView *textLabel1 = [customCell viewWithTag:51];
    UILabel *textLabel = (UILabel *) textLabel1;
    textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    textLabel.text = [flickrPicture valueForKey:@"title"];



    return customCell;
    //BOSS AS HELL
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //MAKE MAGIC HERE.
    selectedIndexPath = indexPath;
    flickrPicture = [flickrSearchResults objectAtIndex:[selectedIndexPath row]];
    [self performSegueWithIdentifier:@"detailView" sender:self];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    MMEnlargedPhoto * svc = [segue destinationViewController];
    [svc setPhotoFromTable:flickrPicture];
    //svc.urlFromTableString = pictureURL;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



