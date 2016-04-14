//
//  CompanyClass.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyClass : NSObject

@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) UIImage *companyImage;
@property (nonatomic, retain) NSMutableArray *productArray;

- (CompanyClass*)initWithCompanyName:(NSString*)name companyImage:(UIImage*)image;

@end
