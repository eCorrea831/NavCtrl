//
//  Company.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (Company *)initWithCompanyName:(NSString *)name companyImage:(UIImage *)image {
    
    self = [super init];
    
    Company * company = [[Company alloc] init];
    
    if (self) {
        company.companyName = name;
        company.companyImage = image;
        company.productArray = [[NSMutableArray alloc] init];
        return company;
    }
    return company;
}

@end
