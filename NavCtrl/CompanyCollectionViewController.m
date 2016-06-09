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

@property (nonatomic, retain) ProductCollectionViewController * productCollectionViewController;
@property (nonatomic, retain) DataAccessObject * dao;
@property (nonatomic) BOOL inEditMode;

@end

@implementation CompanyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNavBar];
    
    self.inEditMode = NO;
    self.title = @"Navigation Controller";
    
    self.dao = [DataAccessObject sharedInstance];
    self.productCollectionViewController = [[ProductCollectionViewController alloc]initWithNibName:@"ProductCollectionViewController" bundle:nil];

    UINib * cellNib = [UINib nibWithNibName:@"CompanyCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    Stocks * stockPrice = [[Stocks alloc] init];
//    [stockPrice makeRequest:self];
    
    [self.collectionView reloadData];
}

- (void)loadNavBar {
    
    UIBarButtonItem * saveToDiskButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveChanges:)];
    
    UIBarButtonItem * rollbackButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rollbackAllChanges:)];
    
    UIBarButtonItem * redoButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(redoLastUndo:)];
    
    UIBarButtonItem * undoButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undoLastAction:)];
    
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    
    UIBarButtonItem * editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(enterEditMode:)];
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(exitEditMode:)];
    
    NSMutableArray * buttons = [[NSMutableArray alloc]init];
    
    if (self.inEditMode) {
        buttons = [NSMutableArray arrayWithObjects:saveToDiskButton, rollbackButton, redoButton, undoButton, doneButton, addButton, nil];
    } else {
        buttons = [NSMutableArray arrayWithObjects:saveToDiskButton, rollbackButton, redoButton, undoButton, editButton, addButton, nil];
    }
    
    self.navigationItem.rightBarButtonItems = buttons;
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
    
    if (self.inEditMode) {
        cell.deleteCompanyButton.hidden = NO;
        
    } else {
        cell.deleteCompanyButton.hidden = YES;
    }
    
//    cell.companyStockPriceLabel.text = [NSString stringWithFormat:@"%.2f", [company.companyStockPrice floatValue]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    Company * company = [[self.dao.companyList objectAtIndex:indexPath.row] retain];
    
    if (self.inEditMode) {
        [self editInfoForCompany:company];
    } else {
        self.productCollectionViewController.title = company.companyName;
        self.productCollectionViewController.company = company;
        [self.navigationController pushViewController:self.productCollectionViewController animated:YES];
    }
}

- (void)enterEditMode:sender {
    self.inEditMode = YES;
    [self loadNavBar];
    [self.collectionView reloadData];
}

- (void)exitEditMode:sender {
    self.inEditMode = NO;
    [self loadNavBar];
    [self.collectionView reloadData];
}

- (void)editInfoForCompany:(Company*)company {
    UserCompanyViewController * userCompanyVC = [[UserCompanyViewController alloc] init];
    userCompanyVC.company = company;
    [self.navigationController pushViewController:userCompanyVC animated:YES];
    [userCompanyVC release];
}


- (void)addItem:sender {
    UserCompanyViewController * userCompanyVC = [[UserCompanyViewController alloc]init];
    [self.navigationController pushViewController:userCompanyVC animated:YES];
    [userCompanyVC release];
}

- (void)saveChanges:sender {
    [self.dao saveChanges];
}

- (void)undoLastAction:sender {
    
    [[self.dao context] undo];
    [self.dao reloadCompanyDataFromContext];
    [self.collectionView reloadData];
}

- (void)redoLastUndo:sender {
    
    [[self.dao context] redo];
    [self.dao reloadCompanyDataFromContext];
    [self.collectionView reloadData];
}

- (void)rollbackAllChanges:sender {
    
    [[self.dao context] rollback];
    [self.dao reloadCompanyDataFromContext];
    [self.collectionView reloadData];
}

@end
