//
//  UserProductViewController.h
//  NavCtrl
//
//  Created by Erica Correa on 5/25/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"

@interface UserProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *instructionLabel;
@property (retain, nonatomic) IBOutlet UIImageView *productImage;
@property (retain, nonatomic) IBOutlet UITextField *productNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *productImageNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *productWebsiteTextField;
@property (retain, nonatomic) IBOutlet UILabel *productNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *productImageNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *productWebsiteLabel;

@property (retain, nonatomic) Company * company;
@property (retain, nonatomic) Product * product;

- (IBAction)saveAction:(id)sender;

@end
