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
    //Create blank song
    Song *mySong = [[Song alloc]init];
    
    //Assign and log song title
    mySong.title = self.songTitleTextField.text;
        //The following line can be used to log the value in the text field.
        //NSLog (@"The text field says %@",self.songTitleTextField.text);
    NSLog(@" Song title is %@", mySong.title);
    
    //Assign and log song artist
    mySong.Artist = self.artistTextField.text;
    NSLog(@"Artist is %@",mySong.artist);
    
    //Assign and log song album
    mySong.Album = self.albumTextField.text;
    NSLog(@"Album is %@", mySong.album);
    
    //Assign and log song genre
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //get rid of keyboard whenever return is hit
    [textField resignFirstResponder];
    //Is there a way to have, on Return key pressed, to run the method for submitButton?
    return YES;
}
@end
