//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyClass.h"
#import "ProductClass.h"

@interface DataAccessObject : NSObject

@property (nonatomic, retain) NSMutableArray * companyList;

+ (DataAccessObject *)sharedInstance;
- (id)initWithData;
- (UIImage *)createDefaultCompanyImage;
- (CompanyClass *)createNewCompanyWithName:(NSString *)addNewCompanyName;
- (CompanyClass *)editCompany:(CompanyClass *)company withName:(NSString *)updatedCompanyName;
- (UIImage*)createDefaultProductImage;
- (ProductClass *)createNewProductWithName:(NSString *)addNewProductName url:(NSString *)addNewProductUrl;
- (ProductClass *)editProduct:(ProductClass *)product withName:(NSString *)updatedProductName withUrl:(NSString *)updatedUrl;

@end
