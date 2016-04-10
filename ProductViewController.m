//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "NewWebViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        self.products = [NSMutableArray arrayWithObjects:@"iPad", @"iPod Touch",@"iPhone", nil];
    } else if ([self.title isEqualToString:@"Google mobile devices"]) {
        self.products = [NSMutableArray arrayWithObjects:@"Android Wear", @"Android Tablet",@"Android Phone", nil];
    } else if ([self.title isEqualToString:@"Huawei mobile devices"]) {
        self.products = [NSMutableArray arrayWithObjects:@"Huawei Mate", @"Huawei MateBook",@"Huawei TalkBand", nil];
    } else {
        self.products = [NSMutableArray arrayWithObjects:@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.products count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
    cell.imageView.image = [self productPicture:self.products atIndex:[self.products objectAtIndex:[indexPath row]]];
    return cell;
}

- (UIImage*)productPicture:(NSArray*)productName atIndex:(id)index {
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
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    NewWebViewController *websiteViewController = [[NewWebViewController alloc] init];
    websiteViewController.url = [NSURL URLWithString:self.urls[indexPath.row]];
    [self.navigationController
     pushViewController:websiteViewController
     animated:YES];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Sets editing, moving, and deletion of a selected row 
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row == [self.products count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.products removeObjectAtIndex:indexPath.row];
        
        //FIXME: Need to also delete from array in companyList
        
        
        [tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)tableView:(UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath {
    NSString *stringToMove = [self.products objectAtIndex:fromIndexPath.row];
    [self.products removeObjectAtIndex:fromIndexPath.row];
    [self.products insertObject:stringToMove atIndex:toIndexPath.row];
    
    //FIXME: Need to also move in array in companyList
}

@end
