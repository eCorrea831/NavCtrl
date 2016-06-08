//
//  CompanyCollectionViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewController.h"
#import "CompanyCollectionViewCell.h"
#import "ProductCollectionViewController.h"
#import "DataAccessObject.h"
#import "UserCompanyViewController.h"
#import "Stocks.h"

@class DataAccessObject;
@class ProductCollectionViewController;

@interface CompanyCollectionViewController ()

//TODO:do this with storyboard segue instead? or other method - pop view controller?
//@property (nonatomic, retain) IBOutlet ProductCollectionViewController * productCollectionViewController;
@property (nonatomic, retain) DataAccessObject * dao;

@end

@implementation CompanyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dao = [DataAccessObject sharedInstance];

    UINib * cellNib = [UINib nibWithNibName:@"CompanyCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    Stocks * stockPrice = [[Stocks alloc] init];
    [stockPrice makeRequest:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.dao.companyList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"Cell";
    CompanyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:(NSIndexPath *)indexPath];


    Company * company = [self.dao.companyList objectAtIndex:[indexPath row]];

    cell.companyNameLabel.text = [company companyName];
    cell.companyImage.image = [UIImage imageNamed:company.companyImageName];
    cell.companyStockPriceLabel.text = [NSString stringWithFormat:@"%.2f", [company.companyStockPrice floatValue]];

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
