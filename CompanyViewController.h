//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "EditCompanyViewController.h"
#import "AddCompanyViewController.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) IBOutlet ProductViewController * productViewController;
@property (nonatomic, retain) EditCompanyViewController * editCompanyViewController;
@property (nonatomic, retain) AddCompanyViewController * addCompanyViewController;
@property (nonatomic, retain) DataAccessObject *dao;
@property (nonatomic, retain) Company * selectedCompany;
@property (nonatomic, retain) UIBarButtonItem * addButton;
@property (nonatomic, retain) UITapGestureRecognizer *tap;

- (UIImage *)companyLogo:(NSArray *)companyName atIndex:(id)index;
- (void)showCompanyInfo;
- (void)addItem:sender;

@end
