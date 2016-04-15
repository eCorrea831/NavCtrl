//
//  AddProductViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 4/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController ()

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveUserNewProductButton:(id)sender {
    NSString * userNewProductName = self.userNewProductNameTextField.text;
    NSString * userNewUrlName = self.userNewProductUrlTextField.text;
    
    if (([userNewProductName isEqualToString: @"Enter product name here..."]) || ([userNewProductName isEqualToString: @""]) || ([userNewUrlName isEqualToString:@"Enter website here..."]) || ([userNewUrlName isEqualToString:@""])){
        [self showIncompleteErrorMessage];
    } else {
        DataAccessObject * dao = [DataAccessObject sharedInstance];
        [self.company.productArray addObject:[dao createNewProductWithName:userNewProductName url:userNewUrlName]];
        NSLog(@"New product saved");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userNewProductNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.userNewProductUrlTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

- (void)showIncompleteErrorMessage {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a product name and website before saving." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[errorAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [errorAlert addAction:alertAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.userNewProductNameTextField.text = nil;
    self.userNewProductUrlTextField.text = nil;
}

- (void)dealloc {
    [self.userNewProductNameTextField release];
    [self.userNewProductUrlTextField release];
    [super dealloc];
}

@end
