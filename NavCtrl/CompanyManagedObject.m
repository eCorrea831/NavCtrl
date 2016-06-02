//
//  CompanyManagedObject.m
//  NavCtrl
//
//  Created by Erica Correa on 5/27/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyManagedObject.h"

@implementation CompanyManagedObject

@dynamic companyOrderNum;
@dynamic companyName;
@dynamic companyImageName;
@dynamic companyStockSymbol;

+ (void)create:(CompanyManagedObject *)managedCompany withManagedCompanyName:(NSString *)name orderNum:(NSNumber *)orderNum imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol {
    
        [managedCompany setValue:name forKey:@"companyName"];
        [managedCompany setValue:orderNum forKey:@"companyOrderNum"];
        [managedCompany setValue:imageName forKey:@"companyImageName"];
        [managedCompany setValue:stockSymbol forKey:@"companyStockSymbol"];
}

@end
