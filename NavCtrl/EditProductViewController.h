//
//  EditProductViewController.h
//  NavCtrl
//
//  Created by Erica Correa on 4/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@interface EditProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel * currentProductNameLabel;
@property (retain, nonatomic) IBOutlet UITextField * editedProductNameTextField;
@property (retain, nonatomic) IBOutlet UILabel * currentProductUrlLabel;
@property (retain, nonatomic) IBOutlet UITextField * editedProductUrlTextField;
@property (retain, nonatomic) Company * company;
@property (retain, nonatomic) Product *product;

- (IBAction)saveEditedProductButton:(id)sender;
- (NSString *)checkStringForPrefix:(NSString *)string;

@end
