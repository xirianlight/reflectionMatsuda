//
//  WebViewControllerFromBookmarksOrHistory.m
//  TabViewTest
//
//  Created by Ross Matsuda on 3/19/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "WebViewControllerFromBookmarksOrHistory.h"

@interface WebViewControllerFromBookmarksOrHistory ()
{
    
    __weak IBOutlet UIWebView *webView;
}

@end

@implementation WebViewControllerFromBookmarksOrHistory

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //URL Request for home page
    NSString * homePage = @"http://www.imgur.com";
    NSURL * url = [NSURL URLWithString:homePage];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
