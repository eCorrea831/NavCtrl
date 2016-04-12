//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyClass.h"
#import "ProductClass.h"

@interface DataAccessObject : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;

+ (void)createData;

@end
