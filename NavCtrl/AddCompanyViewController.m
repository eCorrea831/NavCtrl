//
//  AddCompanyViewController.m
//  NavCtrl
//
//  Created by Erica Correa on 4/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddCompanyViewController.h"
#import "DataAccessObject.h"

@interface AddCompanyViewController ()

@property (nonatomic, retain) IBOutlet UITextField * userNewCompanyNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *userNewStockSymbolTextField;
@property (retain, nonatomic) IBOutlet UITextField *userNewCompanyImageName;

- (IBAction)saveUserNewCompanyButton:(id)sender;
- (void)showIncompleteErrorMessage;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@implementation AddCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveUserNewCompanyButton:(id)sender {
    
    if (([self.userNewCompanyNameTextField.text isEqualToString: @""]) || ([self.userNewStockSymbolTextField.text isEqualToString:@""])) {
         [self showIncompleteErrorMessage];
    } else {
        DataAccessObject * dao = [DataAccessObject sharedInstance];
        if ([self.userNewCompanyImageName.text isEqualToString:@""]) {
            [dao createNewCompanyWithName:self.userNewCompanyNameTextField.text stockSymbol:self.userNewStockSymbolTextField.text imageName:@"Default Company Image"];
            NSLog(@"New company saved with default image");
        } else {
            [dao createNewCompanyWithName:self.userNewCompanyNameTextField.text stockSymbol:self.userNewStockSymbolTextField.text imageName:self.userNewCompanyImageName.text];
            NSLog(@"New company saved with new image");
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showIncompleteErrorMessage {
    
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a company name and stock symbol before saving." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[errorAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [errorAlert addAction:alertAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.userNewCompanyNameTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.userNewStockSymbolTextField resignFirstResponder];
    [[self view] endEditing:YES];
    [self.userNewCompanyImageName resignFirstResponder];
    [[self view] endEditing:YES];
}

- (void)dealloc {
    [super dealloc];
}

@end
