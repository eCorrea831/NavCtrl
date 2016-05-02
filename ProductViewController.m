//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "NewWebViewController.h"
#import "EditProductViewController.h"
#import "AddProductViewController.h"

@interface ProductViewController ()

@property (nonatomic, retain) DataAccessObject *dao;
@property (nonatomic, retain) Product * selectedProduct;
@property (nonatomic, retain) NewWebViewController * webViewController;
@property (nonatomic, retain) EditProductViewController * editProductViewController;
@property (nonatomic, retain) AddProductViewController * addProductViewController;
@property (nonatomic, retain) UIBarButtonItem * addButton;
@property (nonatomic, retain) UITapGestureRecognizer *tap;

- (void)showProductInfo;
- (void)addItem:sender;

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
    [buttons addObject:self.editButtonItem];
    self.addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    [buttons addObject:self.addButton];
    self.navigationItem.rightBarButtonItems = buttons;
    
    self.dao = [DataAccessObject sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.products objectAtIndex:[indexPath row] ]productName];
    cell.imageView.image = [[self.products objectAtIndex:[indexPath row] ]productImage];
    return cell;
}

- (UIImage *)productPicture:(NSArray *)productName atIndex:(id)index {
    return [UIImage imageNamed:index];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.webViewController = [[NewWebViewController alloc] init];
    self.selectedProduct = [self.company.productArray objectAtIndex:[indexPath row]];
    if (self.isEditing) {
        [self showProductInfo];
    } else {
        self.webViewController.url = [NSURL URLWithString:[self.products[indexPath.row] productUrl]];
        [self.navigationController pushViewController:self.webViewController animated:YES];
    }
}

#pragma mark - Sets editing, moving, and deletion of a selected row 
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.products count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
      return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.selectedProduct = [self.company.productArray objectAtIndex:[indexPath row]];
        [self.products removeObjectAtIndex:indexPath.row];
        [self.dao deleteProduct:self.selectedProduct];
        [tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    self.selectedProduct = [self.products objectAtIndex:fromIndexPath.row];
    [self.tableView beginUpdates];
    [self.products removeObjectAtIndex:fromIndexPath.row];
    [self.products insertObject:self.selectedProduct atIndex:toIndexPath.row];
    [self.tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    
    for (int i = 0; i < self.company.productArray.count; i++ ) {
        [self.company.productArray[i] setProductOrderNum:i];
    }
    
    [self.dao moveProductsForCompany:self.company];
    [self.tableView endUpdates];
    [self.tableView reloadData];
}

- (void)showProductInfo {
    if (self.editProductViewController == nil) {
        self.editProductViewController = [[EditProductViewController alloc] init];
    }
    self.editProductViewController.company = self.company;
    self.editProductViewController.product = self.selectedProduct;
    [self.navigationController pushViewController:self.editProductViewController animated:YES];
}

- (void)addItem:sender {
    if (self.addProductViewController == nil) {
        self.addProductViewController = [[AddProductViewController alloc] init];
    }
    self.addProductViewController.company = self.company;
    [self.navigationController pushViewController:self.addProductViewController animated:YES];
}

- (void)dealloc {
    [super dealloc];
}

@end
