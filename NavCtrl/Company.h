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
@property (nonatomic, retain) UIImage * companyImage;
@property (nonatomic, retain) NSString * companyImageName;
@property (nonatomic, retain) NSMutableArray * productArray;
@property (nonatomic, retain) NSString * stockSymbol;
@property (nonatomic, retain) NSString * companyStockPrice;

- (Company *)initWithCompanyName:(NSString *)name companyImage:(NSString *)imageName stockSymbol:(NSString *)stockSymbol;

@end
