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
    [DataAccessObject createData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.companyList count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.companyList objectAtIndex:[indexPath row]];
    cell.imageView.image = [self companyLogo:self.companyList atIndex:[self.companyList objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (UIImage*)companyLogo:(NSArray*)companyName atIndex:(id)index {
    return [UIImage imageNamed:index];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        self.productViewController.title = self.companyList[0];
        self.productViewController.products = self.productsArray[0];
        self.productViewController.urls = self.urlArray[0];
    } else if (indexPath.row == 1) {
        self.productViewController.title = self.companyList[1];
        self.productViewController.products = self.productsArray[1];
        self.productViewController.urls = self.urlArray[1];
    } else if (indexPath.row == 2) {
        self.productViewController.title = self.companyList[2];
        self.productViewController.products = self.productsArray[2];
        self.productViewController.urls = self.urlArray[2];
    } else {
        self.productViewController.title = self.companyList[3];
        self.productViewController.products = self.productsArray[3];
        self.productViewController.urls = self.urlArray[3];
    }
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
}

#pragma mark - Sets editing, moving, and deletion of a selected row
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.companyList count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.companyList removeObjectAtIndex:indexPath.row];
        [self.productViewController.products removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

 - (BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath*)indexPath {
     return YES;
 }

 - (void)tableView:(UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath {
     NSString *stringToMove = [self.companyList objectAtIndex:fromIndexPath.row];
     NSString *otherStringToMove = [self.productViewController.products objectAtIndex:fromIndexPath.row];
     
     [self.companyList removeObjectAtIndex:fromIndexPath.row];
     [self.companyList insertObject:stringToMove atIndex:toIndexPath.row];
     
     [self.productViewController.products removeObjectAtIndex:fromIndexPath.row];
     [self.productViewController.products insertObject:otherStringToMove atIndex:toIndexPath.row];
 }

@end
