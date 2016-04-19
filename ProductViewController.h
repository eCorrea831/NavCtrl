//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWebViewController.h"
#import "EditProductViewController.h"
#import "AddProductViewController.h"

@interface ProductViewController : UITableViewController

@property (nonatomic, retain) NewWebViewController * webViewController;
@property (nonatomic, retain) EditProductViewController * editProductViewController;
@property (nonatomic, retain) AddProductViewController * addProductViewController;
@property (nonatomic, retain) Company * company;
@property (nonatomic, retain) Product * product;
@property (nonatomic, retain) NSMutableArray * products;
@property (nonatomic, retain) UIBarButtonItem * addButton;
@property (nonatomic, retain) UITapGestureRecognizer *tap;

- (void)viewWillAppear:(BOOL)animated;
- (void)showProductInfo;
- (void)addItem:sender;

@end
