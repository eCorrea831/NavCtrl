//
//  WebViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 4/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:self.url];
        [self.webView loadRequest:requestObj];
}

- (void)dealloc {
    [_webView release];
    [super dealloc];
}

@end
