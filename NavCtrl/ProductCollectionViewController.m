//
//  ProductCollectionViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCollectionViewController.h"
#import "ProductCollectionViewCell.h"
#import "NewWebViewController.h"
#import "UserProductViewController.h"

@interface ProductCollectionViewController ()

@property (nonatomic) BOOL inEditMode;

@end

@implementation ProductCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavBar];
    
    self.installsStandardGestureForInteractiveMovement = true;
    
    self.title = @"Navigation Controller";
    
    UINib * cellNib = [UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DataAccessObject sharedInstance] reloadProductDataFromContextForCompany:self.company];
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

    return [self.company.productArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"Cell";
    ProductCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:(NSIndexPath *)indexPath];
    
    Product * selectedProduct = [self.company.productArray objectAtIndex:[indexPath row]];
    
    cell.backgroundColor = [UIColor colorWithRed:0.30 green:0.60 blue:0.68 alpha:1.0];
    cell.productNameLabel.text = selectedProduct.productName;
    cell.productImage.image = [UIImage imageNamed:selectedProduct.productImageName];
    cell.company = self.company;
    
    if (self.inEditMode) {
        cell.deleteProductButton.hidden = NO;
    } else {
        cell.deleteProductButton.hidden = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    if (self.inEditMode) {
        Product * selectedProduct = [self.company.productArray objectAtIndex:[indexPath row]];
        [self editInfoForProduct:selectedProduct];
    } else {
        NewWebViewController * webViewController = [[NewWebViewController alloc]init];
        webViewController.url = [NSURL URLWithString:[self.company.productArray[indexPath.row] productUrl]];
        [self.navigationController pushViewController:webViewController animated:YES];
        [webViewController release];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Product * productToMove = [self.company.productArray objectAtIndex:sourceIndexPath.row];
    [self.company.productArray removeObjectAtIndex:sourceIndexPath.row];
    [self.company.productArray insertObject:productToMove atIndex:destinationIndexPath.row];

    NSNumber * i = @0;
    for (Product * product in self.company.productArray) {
        [product setProductOrderNum:i];
        i = @([i floatValue] + 1);
    }
    
    [[DataAccessObject sharedInstance] moveProductsForCompany:self.company];
    [self.collectionView reloadData];
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

- (void)editInfoForProduct:(Product *)product {
    
    UserProductViewController * userProductVC = [[UserProductViewController alloc] init];
    userProductVC.company = self.company;
    userProductVC.product = product;
    [self.navigationController pushViewController:userProductVC animated:YES];
    [userProductVC release];
}

- (void)addItem:sender {
    
    UserProductViewController * userProductViewController = [[UserProductViewController alloc] init];
    userProductViewController.company = self.company;
    [self.navigationController pushViewController:userProductViewController animated:YES];
    [userProductViewController release];
}

- (void)saveChanges:sender {
    [[DataAccessObject sharedInstance] saveChanges];
}

- (void)undoLastAction:sender {
    
    [[[DataAccessObject sharedInstance] context] undo];
    [[DataAccessObject sharedInstance] reloadProductDataFromContextForCompany:self.company];
    [self.collectionView reloadData];
    NSLog(@"Last action undone.");
}

- (void)redoLastUndo:sender {
    
    [[[DataAccessObject sharedInstance] context] redo];
    [[DataAccessObject sharedInstance] reloadProductDataFromContextForCompany:self.company];
    [self.collectionView reloadData];
    NSLog(@"Last action redone.");
}

- (void)rollbackAllChanges:sender {
    
    [[[DataAccessObject sharedInstance] context] rollback];
    [[DataAccessObject sharedInstance] reloadProductDataFromContextForCompany:self.company];
    [self.collectionView reloadData];
    NSLog(@"All changes rolled back.");
}

@end
