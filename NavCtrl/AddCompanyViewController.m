//
//  AddCompanyViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 4/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddCompanyViewController.h"

@interface AddCompanyViewController ()

@end

@implementation AddCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveUserNewCompanyButton:(id)sender {
    NSString *userNewCompanyName = self.userNewCompanyNameTextField.text;
    DataAccessObject *dao = [DataAccessObject sharedInstance];
    [dao createNewCompanyWithName:userNewCompanyName];
    NSLog(@"New company saved");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [self.userNewCompanyNameTextField release];
    [super dealloc];
}

@end
