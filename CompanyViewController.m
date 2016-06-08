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
#import "UserCompanyViewController.h"
#import "Stocks.h"

@class ProductViewController;
@class DataAccessObject;

@interface CompanyViewController ()

@property (nonatomic, retain) IBOutlet ProductViewController * productViewController;
@property (nonatomic, retain) DataAccessObject * dao;

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
    
    self.dao = [DataAccessObject sharedInstance];
    
    UIBarButtonItem * saveToDiskButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveChanges:)];

    UIBarButtonItem * rollbackButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rollbackAllChanges:)];

    UIBarButtonItem * redoButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(redoLastUndo:)];

    UIBarButtonItem * undoButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undoLastAction:)];

    UIBarButtonItem * addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    
    NSMutableArray * buttons = [[NSMutableArray alloc] initWithObjects:saveToDiskButton, rollbackButton, redoButton, undoButton, self.editButtonItem, addButton, nil];
    
    self.navigationItem.rightBarButtonItems = buttons;
    
    [buttons release];
    [addButton release];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Stocks * stockPrice = [[Stocks alloc] init];
    [stockPrice makeRequest:self];
    
    [self.tableView reloadData];
}

- (void)showCompanyInfoForCompany:(Company*)company {
    UserCompanyViewController * userCompanyVC = [[UserCompanyViewController alloc] init];
    userCompanyVC.company = company;
    [self.navigationController pushViewController:userCompanyVC animated:YES];
    [userCompanyVC release];
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
    Company * company = [self.dao.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = [company companyName];
    cell.imageView.image = [UIImage imageNamed:company.companyImageName];

    UILabel * stockPrice = [[UILabel alloc]init];
    stockPrice.adjustsFontSizeToFitWidth = YES;
    stockPrice.text = [NSString stringWithFormat:@"%.2f", [company.companyStockPrice floatValue]];
    cell.accessoryView = stockPrice;
    [cell.accessoryView setFrame:CGRectMake(0, 0, 50, 50)];
    [stockPrice release];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Company * company = [[self.dao.companyList objectAtIndex:indexPath.row] retain];
    
    if (self.isEditing) {
        [self showCompanyInfoForCompany:company];
    } else {
        self.productViewController.title = company.companyName;
        self.productViewController.company = company;
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
    
    Company * company = [self.dao.companyList objectAtIndex:indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dao deleteCompanyAndItsProducts:company];
        [self.dao.companyList removeObjectAtIndex:indexPath.row];
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
    
    NSNumber * i = @0;
    for (Company * company in self.dao.companyList) {
        [company setCompanyOrderNum:i];
        i = @([i floatValue] + 1);
    }

    [self.dao moveCompanies];
    [self.tableView endUpdates];
    [self.tableView reloadData];
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
    [self.tableView reloadData];
}

- (void)redoLastUndo:sender {
    
    [[self.dao context] redo];
    [self.dao reloadCompanyDataFromContext];
    [self.tableView reloadData];
}

- (void)rollbackAllChanges:sender {
    
    [[self.dao context] rollback];
    [self.dao reloadCompanyDataFromContext];
    [self.tableView reloadData];
}

- (void)dealloc {
    [super dealloc];
}

@end
