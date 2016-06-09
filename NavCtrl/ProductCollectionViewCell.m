//
//  ProductCollectionViewCell.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCollectionViewCell.h"

@implementation ProductCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)deleteProduct:(UIButton *)sender {
    
    NSInteger index = sender.tag;
    
    Product * product = [self.company.productArray objectAtIndex:index];
    [[DataAccessObject sharedInstance] deleteProduct:product forCompany:self.company];
    self.backgroundColor = [UIColor grayColor];
}

- (void)dealloc {
    [_productNameLabel release];
    [_productImage release];
    [_deleteProductButton release];
    [super dealloc];
}

@end
