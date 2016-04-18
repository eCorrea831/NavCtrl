//
//  Company.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) UIImage * companyImage;
@property (nonatomic, retain) NSString * companyStockPrice;
@property (nonatomic, retain) NSMutableArray * productArray;

- (Company *)initWithCompanyName:(NSString *)name companyImage:(UIImage *)image;

@end
