//
//  ProductClass.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductClass.h"

@implementation ProductClass

- (ProductClass *)initWithProductName:(NSString *)name productImage:(UIImage *)image andProductUrl:(NSString *)url {
    
    self = [super init];
    
    ProductClass * product = [[ProductClass alloc] init];
    
    if (self) {
        product.productName = name;
        product.productImage = image;
        product.productUrl = url;
        return product;
    }
    return product;
}

@end
