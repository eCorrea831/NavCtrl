//
//  Stocks.h
//  NavCtrl
//
//  Created by Erica Correa on 5/24/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyViewController.h"

@interface Stocks : NSObject

- (void)getStockPrices:(CompanyViewController *)companyVC;

@end
