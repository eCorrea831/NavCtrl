//
//  Company.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (nonatomic) int companyOrderNum;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * companyImageName;
@property (nonatomic, retain) NSString * companyStockSymbol;
@property (nonatomic, retain) NSString * companyStockPrice;
@property (nonatomic, retain) NSMutableArray * productArray;

- (instancetype)initWithCompanyName:(NSString *)name orderNum:(int)orderNum imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol;

@end
