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
#import "AddProductViewController.h"
#import "EditProductViewController.h"

@interface ProductViewController : UITableViewController

@property (nonatomic, retain) UIBarButtonItem * addButton;
@property (nonatomic, retain) UIButton * infoButton;
@property (nonatomic, retain) NewWebViewController * webViewController;
@property (nonatomic, retain) NSMutableArray * products;
@property (nonatomic, retain) AddProductViewController * addProductViewController;
@property (nonatomic, retain) EditProductViewController * editProductViewController;
@property (retain, nonatomic) Company * company;
@property (retain, nonatomic) Product * product;
@property (nonatomic, retain) UITapGestureRecognizer *tap;

@end
