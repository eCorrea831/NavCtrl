//
//  Product.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain) NSNumber * productOrderNum;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * productImageName;
@property (nonatomic, retain) NSString * productUrl;

- (instancetype)initWithProductName:(NSString *)name orderNum:(NSNumber *)orderNum imageName:(NSString *)imageName url:(NSString *)url;

@end
