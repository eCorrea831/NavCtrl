//
//  Company.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (Company *)initWithCompanyName:(NSString *)name imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol {
    
    self = [super init];
    if (self) {
        _companyName = name;
        _companyImageName = imageName;
        _companyImage = [UIImage imageNamed:imageName];
        _stockSymbol = stockSymbol;
        _productArray = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
