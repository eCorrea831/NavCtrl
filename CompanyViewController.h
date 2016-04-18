//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "AddCompanyViewController.h"
#import "EditCompanyViewController.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) UIBarButtonItem * addButton;
@property (nonatomic, retain) DataAccessObject * dao;
@property (nonatomic, retain) IBOutlet ProductViewController * productViewController;
@property (nonatomic, retain) AddCompanyViewController * addCompanyViewController;
@property (nonatomic, retain) EditCompanyViewController * editCompanyViewController;
@property (nonatomic, retain) UITapGestureRecognizer *tap;
@property (nonatomic, retain) Company * company;

- (void)showCompanyInfo;

@end
