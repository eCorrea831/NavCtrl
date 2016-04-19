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
    if ([self.userNewCompanyNameTextField.text isEqualToString: @""]) {
         [self showIncompleteErrorMessage];
    } else {
        DataAccessObject * dao = [DataAccessObject sharedInstance];
        [dao createNewCompanyWithName:self.userNewCompanyNameTextField.text];
        NSLog(@"New company saved");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showIncompleteErrorMessage {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a company name before saving." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[errorAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [errorAlert addAction:alertAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userNewCompanyNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

- (void)dealloc {
    [self.userNewCompanyNameTextField release];
    [super dealloc];
}

@end
