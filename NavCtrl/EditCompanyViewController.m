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

- (IBAction)saveEditedCompanyButton:(id)sender;
- (void)showIncompleteErrorMessage;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@implementation EditCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentCompanyNameLabel.text = self.company.companyName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveEditedCompanyButton:(id)sender {
    DataAccessObject * dao = [DataAccessObject sharedInstance];
    if ([self.editedCompanyNameTextField.text isEqualToString: @""]) {
        [self showIncompleteErrorMessage];
    } else {
        [dao editCompany:self.company withName:self.editedCompanyNameTextField.text];
        
        NSLog(@"Company updated");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showIncompleteErrorMessage {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter a new company name before saving." preferredStyle:UIAlertControllerStyleAlert];
    
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
    [super dealloc];
}

@end
