//
//  ProductManagedObject.m
//  NavCtrl
//
//  Created by Erica Correa on 5/27/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductManagedObject.h"

@implementation ProductManagedObject

@dynamic productOrderNum;
@dynamic productName;
@dynamic productImageName;
@dynamic productUrl;

+ (void)create:(ProductManagedObject *)managedProduct withManagedProductName:(NSString *)name orderNum:(NSNumber *)orderNum imageName:(NSString *)imageName url:(NSString *)url {
    
        [managedProduct setValue:name forKey:@"productName"];
        [managedProduct setValue:orderNum forKey:@"productOrderNum"];
        [managedProduct setValue:imageName forKey:@"productImageName"];
        [managedProduct setValue:url forKey:@"productUrl"];
}

@end
