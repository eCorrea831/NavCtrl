//
//  Company.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (instancetype)initWithCompanyName:(NSString *)name orderNum:(int)orderNum imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol {
    
    self = [super init];
    if (self) {
        _companyName = name;
        _companyOrderNum = orderNum;
        _companyImageName = imageName;
        _companyStockSymbol = stockSymbol;
        _productArray = [[NSMutableArray alloc] init];
        
        return self;
    }
    return nil;
}

- (void)dealloc {

    [super dealloc];
}

@end
