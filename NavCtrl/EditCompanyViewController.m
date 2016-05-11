//
//  EditCompanyViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 4/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditCompanyViewController.h"

@interface EditCompanyViewController ()

@property (nonatomic, retain) IBOutlet UILabel * currentCompanyNameLabel;
@property (nonatomic, retain) IBOutlet UITextField * editedCompanyNameTextField;
@property (retain, nonatomic) IBOutlet UILabel *currentStockSymbolLabel;
@property (retain, nonatomic) IBOutlet UITextField *editedStockSymbolTextField;
@property (retain, nonatomic) IBOutlet UIImageView *currentCompanyImage;
@property (retain, nonatomic) IBOutlet UITextField *editedCompanyImageTextField;
@property (retain, nonatomic) NSString * currentImageName;

- (IBAction)saveEditedCompanyButton:(id)sender;
- (void)showIncompleteErrorMessage;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@implementation EditCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    self.currentCompanyNameLabel.text = self.company.companyName;
    self.currentStockSymbolLabel.text = self.company.stockSymbol;
    self.currentImageName = self.company.companyImageName;
    self.editedCompanyNameTextField.text = nil;
    self.editedStockSymbolTextField.text = nil;
    self.editedCompanyImageTextField.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveEditedCompanyButton:(id)sender {
    DataAccessObject * dao = [DataAccessObject sharedInstance];
    if (([self.editedCompanyNameTextField.text isEqualToString:@""] && [self.editedStockSymbolTextField.text isEqualToString:@""] && [self.editedCompanyImageTextField.text isEqualToString:@""])) {
        [self showIncompleteErrorMessage];
    }
    if (![self.editedCompanyNameTextField.text isEqualToString:@""]) {
        [dao editCompany:self.company withName:self.editedCompanyNameTextField.text];
    }
    if (![self.editedStockSymbolTextField.text isEqualToString:@""]) {
        [dao editCompany:self.company withStockSymbol:self.editedStockSymbolTextField.text];
    }
    if (![self.editedCompanyImageTextField.text isEqualToString:@""]) {
        [dao editCompany:self.company withImageName:self.editedCompanyImageTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showIncompleteErrorMessage {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a new company name, stock symbol and/or image before saving." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[errorAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    [errorAlert addAction:alertAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.editedCompanyNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

- (void)dealloc {
    [self.currentCompanyNameLabel release];
    [self.editedCompanyNameTextField release];
    [self.currentStockSymbolLabel release];
    [self.editedStockSymbolTextField release];
    [self.currentCompanyImage release];
    [self.editedCompanyImageTextField release];
    [self.currentCompanyImage release];
    [super dealloc];
}

@end
