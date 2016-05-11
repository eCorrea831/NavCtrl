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
#import "sqlite3.h"

@class CompanyViewController;

@interface DataAccessObject : NSObject

@property (nonatomic, retain) NSMutableArray <Company*> * companyList;

+ (DataAccessObject *)sharedInstance;
- (void)getStockPrices:(CompanyViewController*)CompanyVC;
- (void)updateSqlWithString:(NSString *)string;

//methods to create new company or product
- (Company *)createNewCompanyWithName:(NSString *)addNewCompanyName stockSymbol:(NSString *)addNewStockSymbol withCompanyImageName:(NSString *)addNewcompanyImageName;
- (Product *)createNewProductWithName:(NSString*)addNewProductName image:(NSString *)addNewProductImageName url:(NSString*)addNewProductUrl forCompany:(Company *)company;
//methods to edit company
- (Company *)editCompany:(Company *)company withName:(NSString *)updatedCompanyName;
- (Company *)editCompany:(Company *)company withStockSymbol:(NSString *)updatedStockSymbol;
- (Company *)editCompany:(Company *)company withImageName:(NSString *)updatedCompanyImageName;
//methods to edit product
- (Product *)editProduct:(Product *)product withName:(NSString *)updatedProductName;
- (Product *)editProduct:(Product *)product withUrl:(NSString *)updatedUrl;
- (Product *)editProduct:(Product *)product withImageName:(NSString *)updatedProductImageName;

//methods for other editing
- (void)deleteCompanyAndItsProducts:(Company *)company;
- (void)deleteProduct:(Product *)product;
- (void)moveCompanies;
- (void)moveProductsForCompany:(Company *)company;

@end
