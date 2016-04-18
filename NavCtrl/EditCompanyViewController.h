//
//  EditCompanyViewController.h
//  NavCtrl
//
//  Created by Erica Correa on 4/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@interface EditCompanyViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel * currentCompanyNameLabel;
@property (retain, nonatomic) IBOutlet UITextField * editedCompanyNameTextField;
@property (retain, nonatomic) Company * company;

- (IBAction)saveEditedCompanyButton:(id)sender;

@end
