//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "NewWebViewController.h"
#import "UserProductViewController.h"

@interface ProductViewController ()

@property (nonatomic, retain) DataAccessObject * dao;

- (void)showProductInfoForProduct:(Product *)product;
- (void)addItem:sender;

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    
    NSMutableArray * buttons = [[NSMutableArray alloc] initWithCapacity:2];
    [buttons addObject:self.editButtonItem];
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    [buttons addObject:addButton];
    self.navigationItem.rightBarButtonItems = buttons;
    
    self.dao = [DataAccessObject sharedInstance];
    [buttons release];
    [addButton release];
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
    return [self.company.productArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Product * selectedProduct = [self.company.productArray objectAtIndex:[indexPath row]];
    
    NSLog(@"%@",selectedProduct.productName);
    
    cell.textLabel.text = selectedProduct.productName;
    cell.imageView.image = [UIImage imageNamed:selectedProduct.productImageName];
    
    return cell;
}

- (UIImage *)productPicture:(NSArray *)productName atIndex:(id)index {
    return [UIImage imageNamed:index];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewWebViewController * webViewController = [[NewWebViewController alloc]init];
    Product * selectedProduct = [self.company.productArray objectAtIndex:[indexPath row]];
    if (self.isEditing) {
        [self showProductInfoForProduct:selectedProduct];
    } else {
        webViewController.url = [NSURL URLWithString:[self.company.productArray[indexPath.row] productUrl]];
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    [webViewController release];
}

#pragma mark - Sets editing, moving, and deletion of a selected row 
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.company.productArray count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
      return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Product * selectedProduct = [self.company.productArray objectAtIndex:[indexPath row]];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dao deleteProduct:selectedProduct];
        [self.company.productArray removeObjectAtIndex:indexPath.row];
        selectedProduct = NULL;
        [tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    Product * selectedProduct = [self.company.productArray objectAtIndex:fromIndexPath.row];
    [self.tableView beginUpdates];
    [self.company.productArray removeObjectAtIndex:fromIndexPath.row];
    [self.company.productArray insertObject:selectedProduct atIndex:toIndexPath.row];
    [self.tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    
    int i = 0;
    for (Product * product in self.company.productArray) {
        [product setProductOrderNum:i];
        i++;
    }
    
    [self.dao moveProductsForCompany:self.company];
    [self.tableView endUpdates];
    [self.tableView reloadData];
}

- (void)showProductInfoForProduct:(Product *)product {
    
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

- (void)dealloc {
    [super dealloc];
}

@end
