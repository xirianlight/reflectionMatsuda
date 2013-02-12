//
//  MMViewController.m
//  EveningHack2_11
//
//  Created by Ross Matsuda on 2/11/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"
#import "Song.h"

@interface MMViewController ()

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//When submit button is pressed
- (IBAction)submitButton:(id)sender {
    Song *mySong = [[Song alloc]init];
   mySong.title = self.songTitleTextField.text;
//    [mySong setTitle : self.songTitleTextField.text];
    NSLog (@"The text field says %@",self.songTitleTextField.text);
    NSLog(@" Song title is %@", mySong.title);
    
    mySong.Artist = self.artistTextField.text;
    NSLog(@"Artist is %@",mySong.artist);
    
    mySong.Album = self.albumTextField.text;
    NSLog(@"Album is %@", mySong.album);
    
    mySong.Genre = self.genreTextField.text;
    NSLog(@"Genre is %@", mySong.genre);
    
    //Get rid of keyboard no matter which text box it is in
    [[self genreTextField] resignFirstResponder];
    [[self albumTextField] resignFirstResponder];
    [[self artistTextField] resignFirstResponder];
    [[self songTitleTextField] resignFirstResponder];
    
}

- (IBAction)tapScreen:(id)sender {
    //Get rid of keyboard no matter which text box it is in
    [[self genreTextField] resignFirstResponder];
    [[self albumTextField] resignFirstResponder];
    [[self artistTextField] resignFirstResponder];
    [[self songTitleTextField] resignFirstResponder];
}
@end
