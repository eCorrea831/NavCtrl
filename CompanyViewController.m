//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.leftBarButtonItem = self.addButton;
    self.dao = [DataAccessObject sharedInstance];
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

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    CompanyClass *company = [self.dao.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = [company companyName];
    cell.imageView.image = [company companyImage];
    return cell;
}

- (UIImage*)companyLogo:(NSArray*)companyName atIndex:(id)index {
    return [UIImage imageNamed:index];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    CompanyClass *company = [self.dao.companyList objectAtIndex:[indexPath row]];
    self.productViewController.title = [company companyName];
    self.productViewController.products = [company productArray];
    [self.navigationController pushViewController:self.productViewController animated:YES];
}

#pragma mark - Sets editing, moving, and deletion of a selected row
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row == [self.dao.companyList count]) return UITableViewCellEditingStyleInsert;
    else return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dao.companyList removeObjectAtIndex:indexPath.row];
        [self.productViewController.products removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

 - (BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath*)indexPath {
     return YES;
 }

 - (void)tableView:(UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath {
     NSString *stringToMove = [self.dao.companyList objectAtIndex:fromIndexPath.row];
     NSString *otherStringToMove = [self.productViewController.products objectAtIndex:fromIndexPath.row];
     [self.dao.companyList removeObjectAtIndex:fromIndexPath.row];
     [self.dao.companyList insertObject:stringToMove atIndex:toIndexPath.row];
     [self.productViewController.products removeObjectAtIndex:fromIndexPath.row];
     [self.productViewController.products insertObject:otherStringToMove atIndex:toIndexPath.row];
 }

- (void)addItem:sender {
    if (self.addCompanyViewController == nil) self.addCompanyViewController = [[AddCompanyViewController alloc] init];
    
    [self.navigationController pushViewController:self.addCompanyViewController animated:YES];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

@end
