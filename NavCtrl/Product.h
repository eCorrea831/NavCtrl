//
//  Product.h
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic) int productID;
@property (nonatomic) int productOrderNum;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * productImageName;
@property (nonatomic, retain) UIImage * productImage;
@property (nonatomic, retain) NSString * productUrl;

- (Product *)initWithProductName:(NSString *)name imageName:(NSString *)imageName url:(NSString *)url;

@end
