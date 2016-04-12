//
//  CompanyClass.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAccessObject.h"

@interface CompanyClass : NSObject

@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) NSArray *productArray;
@property (nonatomic, retain) UIImage *companyPicture;

- (CompanyClass*)initWithCompanyName:(NSString*)name companyPicture:(UIImage*)image andProductArray:(NSArray*)array;

@end
