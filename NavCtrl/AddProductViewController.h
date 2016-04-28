//
//  AddProductViewController.h
//  NavCtrl
//
//  Created by Erica Correa on 4/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@interface AddProductViewController : UIViewController

@property (nonatomic, retain) Company * company;
@property (nonatomic, retain) DataAccessObject * dao;

@end
