//
//  ProductClass.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAccessObject.h"

@interface ProductClass : NSObject

@property (nonatomic, retain) NSString* productName;
@property (nonatomic, retain) UIImage *productImage;
@property (nonatomic, retain) NSString* productUrl;

- (ProductClass*)initWithProductName:(NSString*)name productImage:(UIImage*)image andProductUrl:(NSString*)url;

@end
