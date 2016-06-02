//
//  Product.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (Product *)initWithProductName:(NSString *)name orderNum:(NSNumber *)orderNum imageName:(NSString *)imageName url:(NSString *)url {
    
    self = [super init];
    if (self) {
        _productName = name;
        _productOrderNum = orderNum;
        _productImageName = imageName;
        _productUrl = url;
        
        return self;
    }
    return nil;
}

- (void)dealloc {
    
    [super dealloc];
}

@end
