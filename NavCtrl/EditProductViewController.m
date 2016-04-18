//
//  EditProductViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 4/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditProductViewController.h"

@interface EditProductViewController ()

@end

//FIXME: url not updating for correct product and updating for all the rest
@implementation EditProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentProductNameLabel.text = self.product.productName;
    self.currentProductUrlLabel.text = self.product.productUrl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveEditedProductButton:(id)sender {
    DataAccessObject * dao = [DataAccessObject sharedInstance];
    if (([self.editedProductNameTextField.text isEqualToString: @""]) && ([self.editedProductUrlTextField.text isEqualToString:@""])) {
        [self showIncompleteErrorMessage];
    } else if ([self.editedProductNameTextField.text isEqualToString: @""]){
        [dao editProduct:self.product withName:self.product.productName withUrl:[self checkStringForPrefix:self.editedProductUrlTextField.text]];
        NSLog(@"Product website updated");
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([self.editedProductUrlTextField.text isEqualToString: @""]) {
        [dao editProduct:self.product withName:self.editedProductNameTextField.text withUrl:self.product.productUrl];
        NSLog(@"Product name updated");
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [dao editProduct:self.product withName:self.editedProductNameTextField.text withUrl:[self checkStringForPrefix:self.editedProductUrlTextField.text]];
        NSLog(@"Product name and website updated");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSString *)checkStringForPrefix:(NSString *)string {
    if([string hasPrefix:@"http://"]) {
        return self.editedProductUrlTextField.text;
    } else {
        NSString *prefix = @"http://";
        return [prefix stringByAppendingString:self.editedProductUrlTextField.text];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.editedProductNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.editedProductUrlTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

- (void)showIncompleteErrorMessage {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a new product name and/or website before saving." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[errorAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [errorAlert addAction:alertAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.currentProductNameLabel.text = self.product.productName;
    self.currentProductUrlLabel.text = self.product.productUrl;
    self.editedProductNameTextField.text = nil;
    self.editedProductUrlTextField.text = nil;
}

- (void)dealloc {
    [self.currentProductNameLabel release];
    [self.editedProductNameTextField release];
    [self.currentProductUrlLabel release];
    [self.editedProductUrlTextField release];
    [super dealloc];
}

@end
