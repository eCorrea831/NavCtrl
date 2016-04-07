//
//  WebViewController.h
//  NavCtrl
//
//  Created by Erica Correa on 4/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) NSURL *url;

@end
