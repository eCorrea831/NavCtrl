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
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) UIImage * companyImage;
@property (nonatomic, retain) NSMutableArray * productArray;
@property (nonatomic, retain) NSString * companyStockPrice;

- (Company *)initWithCompanyName:(NSString *)name companyImage:(UIImage *)image;

@end
