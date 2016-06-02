//
//  UserProductViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 5/25/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "UserProductViewController.h"
#import "DataAccessObject.h"

@interface UserProductViewController ()

@end

@implementation UserProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (self.product != nil) {
        
        self.instructionLabel.text = @"Edit the fields below that you want to update";
        self.productImage.image = [UIImage imageNamed:self.product.productImageName];
        self.productNameTextField.text = self.product.productName;
        self.productImageNameTextField.text = self.product.productImageName;
        self.productWebsiteTextField.text = self.product.productUrl;
        self.productNameLabel.hidden = NO;
        self.productImageNameLabel.hidden = NO;
        self.productWebsiteLabel.hidden = NO;
        
    } else {
        
        self.instructionLabel.text = @"Complete the fields below for the new product";
        self.productImage.image = [UIImage imageNamed:@"DefaultProductImage"];
        self.productNameLabel.hidden = YES;
        self.productImageNameLabel.hidden = YES;
        self.productWebsiteLabel.hidden = YES;
    }
}


- (IBAction)saveAction:(id)sender {
    
    DataAccessObject * dao = [DataAccessObject sharedInstance];
    
    if (self.product == nil) {
        
        if ([self.productNameTextField.text isEqualToString: @""] || [self.productWebsiteTextField.text isEqualToString: @""]) {
            
            [self showIncompleteErrorMessage];
            
        } else {
            
            if (![self.productImageNameTextField.text isEqualToString:@""]) {
                
                [dao createNewProductWithName:self.productNameTextField.text image:self.productImageNameTextField.text url:self.productWebsiteTextField.text forCompany:self.company];
                
            } else {
                [dao createNewProductWithName:self.productNameTextField.text image:@"DefaultProductImage" url:self.productWebsiteTextField.text forCompany:self.company];
            }
        }
    } else {
        [dao editProduct:self.product withName:self.productNameTextField.text imageName:self.productImageNameTextField.text website:self.productWebsiteTextField.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showIncompleteErrorMessage {
    
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a new product name and website before saving." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[errorAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    [errorAlert addAction:alertAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.productNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.productWebsiteTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.productImageNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

- (void)dealloc {
    [_instructionLabel release];
    [_productImage release];
    [_productNameTextField release];
    [_productImageNameTextField release];
    [_productWebsiteTextField release];
    [_productNameLabel release];
    [_productImageNameLabel release];
    [_productWebsiteLabel release];
    [super dealloc];
}

@end
