//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) NSArray *companyList;

@property (nonatomic, retain) NSArray *appleProductsArray;
@property (nonatomic, retain) NSArray *appleStringArray;
@property (nonatomic, retain) NSArray *appleUrlArray;

@property (nonatomic, retain) NSArray *samsungProductsArray;
@property (nonatomic, retain) NSArray *samsungStringArray;
@property (nonatomic, retain) NSArray *samsungUrlArray;

@property (nonatomic, retain) NSArray *googleProductsArray;
@property (nonatomic, retain) NSArray *googleStringArray;
@property (nonatomic, retain) NSArray *googleUrlArray;

@property (nonatomic, retain) NSArray *huaweiProductsArray;
@property (nonatomic, retain) NSArray *huaweiStringArray;
@property (nonatomic, retain) NSArray *huaweiUrlArray;

@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;

- (UIImage*)companyLogo:(NSArray*)companyName atIndex:(id)index;

@end
