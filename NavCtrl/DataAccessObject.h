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

@interface DataAccessObject : NSObject

@property (nonatomic, retain) NSMutableArray * companyList;

+ (DataAccessObject *)sharedInstance;
- (id)initWithData;
- (UIImage *)createDefaultCompanyImage;
- (Company *)createNewCompanyWithName:(NSString *)addNewCompanyName;
- (Company *)editCompany:(Company *)company withName:(NSString *)updatedCompanyName;
- (UIImage*)createDefaultProductImage;
- (Product *)createNewProductWithName:(NSString *)addNewProductName url:(NSString *)addNewProductUrl;
- (Product *)editProduct:(Product *)product withName:(NSString *)updatedProductName withUrl:(NSString *)updatedUrl;

@end
