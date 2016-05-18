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

+ (DataAccessObject *)sharedInstance;

@property (nonatomic, retain) NSMutableArray <Company*> * companyList;

- (void)getStockPrices:(CompanyViewController*)companyVC;
- (void)updateSqlWithString:(NSString *)string;

//methods to create new company or product
- (Company *)createNewCompanyWithName:(NSString *)name stockSymbol:(NSString *)stockSymbol imageName:(NSString *)imageName;
- (Product *)createNewProductWithName:(NSString*)name image:(NSString *)imageName url:(NSString*)url forCompany:(Company *)company;
//methods to edit company
- (Company *)editCompany:(Company *)company withName:(NSString *)name;
- (Company *)editCompany:(Company *)company withStockSymbol:(NSString *)stockSymbol;
- (Company *)editCompany:(Company *)company withImageName:(NSString *)imageName;
//methods to edit product
- (Product *)editProduct:(Product *)product withName:(NSString *)name;
- (Product *)editProduct:(Product *)product withUrl:(NSString *)url;
- (Product *)editProduct:(Product *)product withImageName:(NSString *)imageName;

//methods for other editing
- (void)deleteCompanyAndItsProducts:(Company *)company;
- (void)deleteProduct:(Product *)product;
- (void)moveCompanies;
- (void)moveProductsForCompany:(Company *)company;

@end
