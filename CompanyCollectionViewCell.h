//
//  CompanyCollectionViewCell.h
//  NavCtrl
//
//  Created by Aditya Narayan on 6/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UILabel * companyNameLabel;
@property (retain, nonatomic) IBOutlet UIImageView * companyImage;
@property (retain, nonatomic) IBOutlet UILabel * companyStockPriceLabel;
@property (retain, nonatomic) IBOutlet UIButton * deleteCompanyButton;

- (IBAction)deleteCompany:(id)sender;

@end
