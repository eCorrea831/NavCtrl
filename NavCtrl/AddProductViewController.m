//
//  AddProductViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 4/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController ()

@property (retain, nonatomic) IBOutlet UITextField * userNewProductNameTextField;
@property (retain, nonatomic) IBOutlet UITextField * userNewProductUrlTextField;
@property (retain, nonatomic) IBOutlet UITextField *userNewProductImageNameTextField;

- (IBAction)saveUserNewProductButton:(id)sender;
- (void)showIncompleteErrorMessage;
- (NSString *)checkStringForPrefix:(NSString *)string;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.userNewProductNameTextField.text = nil;
    self.userNewProductUrlTextField.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveUserNewProductButton:(id)sender {
    
    if (([self.userNewProductNameTextField.text isEqualToString: @""]) || ([self.userNewProductUrlTextField.text isEqualToString:@""])){
        [self showIncompleteErrorMessage];
    } else {
        DataAccessObject * dao = [DataAccessObject sharedInstance];
        if ([self.userNewProductImageNameTextField.text isEqualToString:@""]) {
            [self.company.productArray addObject:[dao createNewProductWithName:self.userNewProductNameTextField.text image:@"Default Product Image" url:[self checkStringForPrefix:self.userNewProductUrlTextField.text] forCompany:self.company]];
            NSLog(@"New product saved with default image");
        } else {
            [self.company.productArray addObject:[dao createNewProductWithName:self.userNewProductNameTextField.text image:self.userNewProductImageNameTextField.text url:[self checkStringForPrefix:self.userNewProductUrlTextField.text] forCompany:self.company]];
            NSLog(@"New product saved with new image");
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showIncompleteErrorMessage {
    
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a product name and website before saving." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[errorAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [errorAlert addAction:alertAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (NSString *)checkStringForPrefix:(NSString *)string {
    
    if([string hasPrefix:@"http://"]) {
        return self.userNewProductUrlTextField.text;
    } else {
        NSString *prefix = @"http://";
        return [prefix stringByAppendingString:self.userNewProductUrlTextField.text];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.userNewProductNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.userNewProductUrlTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.userNewProductImageNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
}

- (void)dealloc {
    [super dealloc];
}

@end
