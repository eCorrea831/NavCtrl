//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *companyList;

@property (nonatomic, retain) NSMutableArray *appleProductsArray;
@property (nonatomic, retain) NSArray *appleUrlArray;

@property (nonatomic, retain) NSMutableArray *samsungProductsArray;
@property (nonatomic, retain) NSArray *samsungUrlArray;

@property (nonatomic, retain) NSMutableArray *googleProductsArray;
@property (nonatomic, retain) NSArray *googleUrlArray;

@property (nonatomic, retain) NSMutableArray *huaweiProductsArray;
@property (nonatomic, retain) NSArray *huaweiUrlArray;

@property (nonatomic, retain) NSMutableArray *productsArray;
@property (nonatomic, retain) NSMutableArray *urlArray;

@property (nonatomic, retain) IBOutlet  ProductViewController *productViewController;

- (UIImage*)companyLogo:(NSArray*)companyName atIndex:(id)index;

@end
