//
//  CompanyCollectionViewCell.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewCell.h"

@implementation CompanyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)dealloc {
    [_companyNameLabel release];
    [_companyImage release];
    [_companyStockPriceLabel release];
    [super dealloc];
}
@end
