//
//  CompanyCollectionViewCell.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewCell.h"
#import "DataAccessObject.h"
#import "CompanyCollectionViewController.h"

@implementation CompanyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)deleteCompany:(UIButton *)sender {

    //TODO:have remove from view right away
    NSInteger index = sender.tag;
    Company * company = [DataAccessObject sharedInstance].companyList[index];
    [[DataAccessObject sharedInstance] deleteCompanyAndItsProducts:company];
    self.backgroundColor = [UIColor grayColor];
}

- (void)dealloc {
    [_companyNameLabel release];
    [_companyImage release];
    [_companyStockPriceLabel release];
    [_deleteCompanyButton release];
    [super dealloc];
}

@end
