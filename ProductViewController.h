//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyViewController.h"
#import "NewWebViewController.h"

@interface ProductViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSArray *urls;
@property (nonatomic, retain) NewWebViewController *webViewController;

- (UIImage*)productPicture:(NSArray*)productName atIndex:(id)index;

@end
