//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "CompanyViewController.h"
@class CompanyViewController;

@interface DataAccessObject : NSObject
@property (nonatomic, retain) NSMutableArray <Company*> * companyList;

+ (DataAccessObject *)sharedInstance;
- (id)initWithData;
- (UIImage *)createDefaultCompanyImage;
- (Company *)createNewCompanyWithName:(NSString *)addNewCompanyName;
- (Company *)editCompany:(Company *)company withName:(NSString *)updatedCompanyName;
- (UIImage*)createDefaultProductImage;
- (Product *)createNewProductWithName:(NSString *)addNewProductName url:(NSString *)addNewProductUrl;
- (Product *)editProduct:(Product *)product withName:(NSString *)updatedProductName withUrl:(NSString *)updatedUrl;
- (void)getStockPrices:(CompanyViewController*)CompanyVC;
@end
