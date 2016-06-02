//
//  ProductManagedObject.h
//  NavCtrl
//
//  Created by Erica Correa on 5/27/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ProductManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * productOrderNum;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * productImageName;
@property (nonatomic, retain) NSString * productUrl;

+ (void)create:(ProductManagedObject *)managedProduct withManagedProductName:(NSString *)name orderNum:(NSNumber *)orderNum imageName:(NSString *)imageName url:(NSString *)url;

@end
