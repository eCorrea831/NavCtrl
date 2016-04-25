//
//  Product.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * productUrl;
@property (nonatomic, retain) UIImage * productImage;

- (Product *)initWithProductName:(NSString *)name productImage:(UIImage *)image andProductUrl:(NSString *)url;

@end
