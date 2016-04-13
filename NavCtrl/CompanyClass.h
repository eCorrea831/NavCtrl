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
@property (nonatomic, retain) NSMutableArray *productArray;
@property (nonatomic, retain) NSMutableArray *urlArray;
@property (nonatomic, retain) UIImage *companyImage;

- (CompanyClass*)initWithCompanyName:(NSString*)name companyImage:(UIImage*)image productArray:(NSMutableArray*)productArray andUrlArray:(NSMutableArray*)urlArray;

@end
