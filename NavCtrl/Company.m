//
//  Company.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (instancetype)initWithCompanyName:(NSString *)name orderNum:(NSNumber *)orderNum imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol {
    
    self = [super init];
    if (self) {
        _companyName = [name retain];
        _companyOrderNum = [orderNum retain];
        _companyImageName = [imageName retain];
        _companyStockSymbol = [stockSymbol retain];
        _productArray = [[[NSMutableArray alloc] init] retain];
        
        return self;
    }
    return nil;
}

- (void)dealloc {

    [super dealloc];
}

@end
