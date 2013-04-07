//
//  MMViewController.m
//  3_18_evening_browser_exercise
//
//  Created by Ross Matsuda on 3/18/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()
{
    
    __weak IBOutlet UIWebView *webView;
    __weak IBOutlet UITextField *urlTextField;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
}
- (IBAction)xButtonPressed:(id)sender;
- (IBAction)swipeLeftAction:(id)sender;
- (IBAction)swipeRightAction:(id)sender;

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //URL Request for home page
    NSString * homePage = @"http://www.imgur.com";
    NSURL * url = [NSURL URLWithString:homePage];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    


}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
}

-(BOOL) textFieldShouldReturn: (UITextField*)textField
{
    [urlTextField resignFirstResponder];
    NSURL * url = [NSURL URLWithString:textField.text];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    
    return YES;
}

#pragma mark -- Swipes and button presses
- (IBAction)xButtonPressed:(id)sender {
    urlTextField.text = @"http://";
    [urlTextField becomeFirstResponder];
}

- (IBAction)swipeLeftAction:(id)sender {
    [webView goForward];
}

- (IBAction)swipeRightAction:(id)sender {
    [webView goBack];
}


//End of document
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
