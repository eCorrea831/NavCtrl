//
//  NewWebViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 4/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "NewWebViewController.h"

@interface NewWebViewController ()

@end

@implementation NewWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    webView.navigationDelegate = self;
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:nsrequest];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
