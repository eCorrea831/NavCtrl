//
//  Product.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithProductName:(NSString *)name imageName:(NSString *)imageName url:(NSString *)url {
    
    self = [super init];
    if (self) {
        _productName = name;
        _productImageName = imageName;
        
        UIImage * productImage = [[UIImage alloc]init];
        productImage = [UIImage imageNamed:imageName];
        
        _productUrl = url;
        
        return self;
    }
    return nil;
}

- (void)dealloc {
    
    // dealloc of all these things
    
    [super dealloc];
}

@end
