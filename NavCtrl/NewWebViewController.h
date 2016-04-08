//
//  NewWebViewController.h
//  NavCtrl
//
//  Created by Erica Correa on 4/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface NewWebViewController : UIViewController <WKNavigationDelegate>

@property (retain, nonatomic) NSURL *url;

@end
