//
//  UserCompanyViewController.h
//  NavCtrl
//
//  Created by Erica Correa on 5/25/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@interface UserCompanyViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel * instructionLabel;
@property (retain, nonatomic) IBOutlet UIImageView * companyImage;
@property (retain, nonatomic) IBOutlet UITextField * companyNameTextField;
@property (retain, nonatomic) IBOutlet UITextField * companyImageNameTextField;
@property (retain, nonatomic) IBOutlet UITextField * companyStockSymbolTextField;
@property (retain, nonatomic) IBOutlet UILabel * companyNameLabel;
@property (retain, nonatomic) IBOutlet UILabel * companyImageNameLabel;
@property (retain, nonatomic) IBOutlet UILabel * companyStockSymbolLabel;

@property (retain, nonatomic) Company * company;

- (IBAction)saveAction:(id)sender;

@end
