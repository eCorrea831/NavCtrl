//
//  EditProductViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 4/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditProductViewController.h"

@interface EditProductViewController ()


@property (retain, nonatomic) IBOutlet UILabel * currentProductNameLabel;
@property (retain, nonatomic) IBOutlet UITextField * editedProductNameTextField;
@property (retain, nonatomic) IBOutlet UILabel * currentProductUrlLabel;
@property (retain, nonatomic) IBOutlet UITextField * editedProductUrlTextField;
@property (retain, nonatomic) IBOutlet UITextField *editedProductImageNameTextField;
@property (retain, nonatomic) IBOutlet UIImageView *currentProductImage;
@property (retain, nonatomic) NSString * currentProductImageName;

- (IBAction)saveEditedProductButton:(id)sender;
- (void)showIncompleteErrorMessage;
- (NSString *)checkStringForPrefix:(NSString *)string;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@implementation EditProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.currentProductNameLabel.text = self.product.productName;
    self.currentProductUrlLabel.text = self.product.productUrl;
    self.currentProductImageName = self.product.productImageName;
    self.currentProductImage.image = [UIImage imageNamed:self.currentProductImageName];
    self.editedProductNameTextField.text = nil;
    self.editedProductUrlTextField.text = nil;
    self.editedProductImageNameTextField.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveEditedProductButton:(id)sender {
    
    DataAccessObject * dao = [DataAccessObject sharedInstance];
    if (([self.editedProductNameTextField.text isEqualToString: @""]) || ([self.editedProductUrlTextField.text isEqualToString:@""]) || ([self.editedProductImageNameTextField.text isEqualToString: @""])) {
        [self showIncompleteErrorMessage];
    }
    if (![self.editedProductNameTextField.text isEqualToString:@""]) {
        [dao editProduct:self.product withName:self.editedProductNameTextField.text];
    }
    if (![self.editedProductUrlTextField.text isEqualToString:@""]) {
        [dao editProduct:self.product withUrl:self.editedProductUrlTextField.text];
    }
    if (![self.editedProductImageNameTextField.text isEqualToString:@""]) {
        [dao editProduct:self.product withImageName:self.editedProductImageNameTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showIncompleteErrorMessage {
    
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a new product name, website, and/or image before saving." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[errorAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    [errorAlert addAction:alertAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
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
    [self.editedProductImageNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

- (void)dealloc {
    [super dealloc];
}

@end
