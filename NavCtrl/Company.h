//
//  Company.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (nonatomic) int companyID;
@property (nonatomic) int companyOrderNum;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * companyImageName;
@property (nonatomic, retain) UIImage * companyImage;
@property (nonatomic, retain) NSString * stockSymbol;
@property (nonatomic, retain) NSMutableString * companyStockPrice;
@property (nonatomic, retain) NSMutableArray * productArray;

- (Company *)initWithCompanyName:(NSString *)name imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol;

@end
