//
//  UserCompanyViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 5/25/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "UserCompanyViewController.h"
#import "DataAccessObject.h"

@interface UserCompanyViewController ()

@end

@implementation UserCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.company != nil) {
        
        self.instructionLabel.text = @"Edit the fields below that you want to update";
        self.companyImage.image = [UIImage imageNamed:self.company.companyImageName];
        self.companyNameTextField.text = self.company.companyName;
        self.companyImageNameTextField.text = self.company.companyImageName;
        self.companyStockSymbolTextField.text = self.company.companyStockPrice;
        self.companyNameLabel.hidden = NO;
        self.companyImageNameLabel.hidden = NO;
        self.companyStockSymbolLabel.hidden = NO;
        
    } else {
        
        self.instructionLabel.text = @"Complete the fields below for the new company";
        self.companyNameLabel.hidden = YES;
        self.companyImageNameLabel.hidden = YES;
        self.companyStockSymbolLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveAction:(id)sender {
    
    DataAccessObject * dao = [DataAccessObject sharedInstance];
    
    if (self.company == nil) {
        if ([self.companyNameTextField.text isEqualToString: @""] || [self.companyStockSymbolTextField.text isEqualToString: @""]) {
            [self showIncompleteErrorMessage];
        } else {
            if (![self.companyImageNameTextField.text isEqualToString:@""]) {
                [dao createNewCompanyWithName:self.companyNameTextField.text stockSymbol:self.companyStockSymbolTextField.text imageName:self.companyImageNameTextField.text];
            } else {
                [dao createNewCompanyWithName:self.companyNameTextField.text stockSymbol:self.companyStockSymbolTextField.text imageName:@"DefaultCompanyImage"];
            }
        }
    } else {
        [dao editcompany:self.company withName:self.companyNameTextField.text imageName:self.companyImageNameTextField.text stockSymbol:self.companyStockSymbolTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showIncompleteErrorMessage {
    
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a new company name and stock symbol before saving." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[errorAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    [errorAlert addAction:alertAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.companyNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.companyStockSymbolTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.companyImageNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

- (void)dealloc {
    [_instructionLabel release];
    [_companyImage release];
    [_companyNameTextField release];
    [_companyImageNameTextField release];
    [_companyStockSymbolTextField release];
    [_companyNameLabel release];
    [_companyImageNameLabel release];
    [_companyStockSymbolLabel release];
    [super dealloc];
}

@end