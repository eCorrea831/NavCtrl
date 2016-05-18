//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "DataAccessObject.h"
#import "EditCompanyViewController.h"
#import "AddCompanyViewController.h"

@class ProductViewController;
@class DataAccessObject;

@interface CompanyViewController ()

@property (nonatomic, retain) IBOutlet ProductViewController * productViewController;
@property (nonatomic, retain) DataAccessObject * dao;
@property (nonatomic, retain) Company * selectedCompany;

- (void)showCompanyInfo;
- (void)addItem:sender;

@end

@implementation CompanyViewController

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
    [self.dao getStockPrices:self];
    [self.tableView reloadData];
}

- (void)showCompanyInfo {
    EditCompanyViewController * editCompanyVC = [[EditCompanyViewController alloc] init];
    editCompanyVC.company = self.selectedCompany;
    [self.navigationController pushViewController:editCompanyVC animated:YES];
    [editCompanyVC release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dao.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    self.selectedCompany = [self.dao.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = [self.selectedCompany companyName];
    cell.imageView.image = [self.selectedCompany companyImage];
    UILabel *stockPrice = [[UILabel alloc]init];
    stockPrice.adjustsFontSizeToFitWidth = YES;
    stockPrice.text = [NSString stringWithFormat:@"%.2f", [self.selectedCompany.companyStockPrice floatValue]];
    cell.accessoryView = stockPrice;
    [cell.accessoryView setFrame:CGRectMake(0, 0, 50, 50)];
    return cell;
    [stockPrice release];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedCompany = [self.dao.companyList objectAtIndex:[indexPath row]];
    if (self.isEditing) {
        [self showCompanyInfo];
    } else {
        self.productViewController.title = [self.selectedCompany companyName];
        self.productViewController.company.productArray = [self.selectedCompany productArray];
        self.productViewController.company = self.selectedCompany;
        [self.navigationController pushViewController:self.productViewController animated:YES];
    }
}

#pragma mark - Sets editing, moving, and deletion of a selected row
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.dao.companyList count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dao deleteCompanyAndItsProducts:self.selectedCompany];
        for (Product *product in self.selectedCompany.productArray) {
            product = nil;
        }
        [self.dao.companyList removeObjectAtIndex:indexPath.row];
        self.selectedCompany = nil;
        [tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    Company * companyToMove =[self.dao.companyList objectAtIndex:fromIndexPath.row];
    [self.tableView beginUpdates];
    [self.dao.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.dao.companyList insertObject:companyToMove atIndex:toIndexPath.row];
    [self.tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    
    for (int i = 0; i < self.dao.companyList.count; i++ ) {
        [self.dao.companyList[i] setCompanyOrderNum:i];
    }
    [self.dao moveCompanies];
    [self.tableView endUpdates];
    [self.tableView reloadData];
}

- (void)addItem:sender {
    AddCompanyViewController * addCompanyVC = [[AddCompanyViewController alloc]init];
    [self.navigationController pushViewController:addCompanyVC animated:YES];
    [addCompanyVC release];
}

- (void)dealloc {
    [super dealloc];
}

@end
