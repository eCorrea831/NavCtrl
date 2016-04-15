//
//  CompanyClass.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyClass.h"

@implementation CompanyClass

- (CompanyClass *)initWithCompanyName:(NSString *)name companyImage:(UIImage *)image {
    
    self = [super init];
    
    CompanyClass * company = [[CompanyClass alloc] init];
    
    if (self) {
        company.companyName = name;
        company.companyImage = image;
        company.productArray = [[NSMutableArray alloc] init];
        return company;
    }
    return company;
}

@end
