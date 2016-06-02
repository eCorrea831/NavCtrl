//
//  CompanyManagedObject.h
//  NavCtrl
//
//  Created by Erica Correa on 5/27/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CompanyManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * companyOrderNum;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * companyImageName;
@property (nonatomic, retain) NSString * companyStockSymbol;

+ (void)create:(CompanyManagedObject *)managedCompay withManagedCompanyName:(NSString *)name orderNum:(NSNumber *)orderNum imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol;

@end
