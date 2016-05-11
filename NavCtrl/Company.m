//
//  Company.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (Company *)initWithCompanyName:(NSString *)name companyImage:(NSString *)imageName stockSymbol:(NSString *)stockSymbol {
    self = [super init];
    Company * company = [[Company alloc] init];
    if (self) {
        company.companyName = name;
        company.companyImageName = imageName;
        company.companyImage = [UIImage imageNamed:imageName];
        company.stockSymbol = stockSymbol;
        company.productArray = [[NSMutableArray alloc] init];
        return company;
    }
    return company;
}

@end
