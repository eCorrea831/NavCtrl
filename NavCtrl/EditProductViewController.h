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

- (void)viewWillAppear:(BOOL)animated;
- (IBAction)saveEditedProductButton:(id)sender;
- (void)showIncompleteErrorMessage;
- (NSString *)checkStringForPrefix:(NSString *)string;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
