//
//  AddCompanyViewController.h
//  NavCtrl
//
//  Created by Erica Correa on 4/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@interface AddCompanyViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField * userNewCompanyNameTextField;

- (IBAction)saveUserNewCompanyButton:(id)sender;

@end
