//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "CompanyManagedObject.h"
#import "Product.h"
#import "ProductManagedObject.h"
#import "sqlite3.h"

@interface DataAccessObject : NSObject

+ (DataAccessObject *)sharedInstance;

@property (nonatomic, retain) NSMutableArray <Company*> * companyList;
@property (nonatomic, retain) NSManagedObjectContext * context;
@property (nonatomic, retain) NSManagedObjectModel * model;

//create new company/product
- (Company *)createNewCompanyWithName:(NSString *)name stockSymbol:(NSString *)stockSymbol imageName:(NSString *)imageName;
- (Product *)createNewProductWithName:(NSString *)name image:(NSString *)imageName url:(NSString *)url forCompany:(Company *)company;

//edit company/product
- (Company *)editcompany:(Company *)company withName:(NSString *)name imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol;
- (Product *)editProduct:(Product *)product withName:(NSString *)name imageName:(NSString *)imageName website:(NSString *)website;

//other editing
- (void)deleteCompanyAndItsProducts:(Company *)company;
- (void)deleteProduct:(Product *)product;
- (void)moveCompanies;
- (void)moveProductsForCompany:(Company *)company;

//core data methods
- (void)saveChanges;
- (void)reloadDataFromContext;

@end
