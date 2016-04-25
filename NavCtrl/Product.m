//
//  Product.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (Product *)initWithProductName:(NSString *)name productImage:(UIImage *)image andProductUrl:(NSString *)url {
    self = [super init];
    Product * product = [[Product alloc] init];
    if (self) {
        product.productName = name;
        product.productImage = image;
        product.productUrl = url;
        return product;
    }
    return product;
}

@end
