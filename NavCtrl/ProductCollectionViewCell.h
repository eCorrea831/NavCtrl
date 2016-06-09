//
//  ProductCollectionViewCell.h
//  NavCtrl
//
//  Created by Aditya Narayan on 6/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@interface ProductCollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UILabel * productNameLabel;
@property (retain, nonatomic) IBOutlet UIImageView * productImage;
@property (retain, nonatomic) IBOutlet UIButton * deleteProductButton;

@property (nonatomic, retain) Company * company;

- (IBAction)deleteProduct:(id)sender;

@end
