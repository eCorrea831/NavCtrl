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
    
    self.companyList = [NSMutableArray arrayWithObjects:@"Apple mobile devices",@"Samsung mobile devices", @"Google mobile devices", @"Huawei mobile devices", nil];
    self.title = @"Mobile device makers";
    
    self.appleProductsArray = [NSMutableArray arrayWithObjects:@"iPad", @"iPod Touch", @"iPhone", nil];
    self.appleUrlArray = @[@"http://www.apple.com/ipad/", @"http://www.apple.com/ipod/",@"http://www.apple.com/iphone/"];
    
    self.samsungProductsArray = [NSMutableArray arrayWithObjects:@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
    self.samsungUrlArray = @[@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZKPVZW", @"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-", @"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-"];
    
    self.googleProductsArray = [NSMutableArray arrayWithObjects:@"Android Wear", @"Android Tablet",@"Android Phone", nil];
    self.googleUrlArray = @[@"https://www.android.com/wear/", @"https://www.android.com/tablets/", @"https://www.android.com/phones/"];
    
    self.huaweiProductsArray = [NSMutableArray arrayWithObjects:@"Huawei Mate", @"Huawei MateBook",@"Huawei TalkBand", nil];
    self.huaweiUrlArray = @[@"http://consumer.huawei.com/minisite/worldwide/mate8/", @"http://consumer.huawei.com/minisite/worldwide/matebook/screen.htm", @"http://consumer.huawei.com/en/wearables/talkband-b3/"];
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
   // Override to support rearranging the table view.
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        self.productViewController.title = @"Apple mobile devices";
        self.productViewController.products = self.appleProductsArray;
        self.productViewController.urls = self.appleUrlArray;
    } else if (indexPath.row == 1) {
        self.productViewController.title = @"Samsung mobile devices";
        self.productViewController.products = self.samsungProductsArray;
        self.productViewController.urls = self.samsungUrlArray;
    } else if (indexPath.row == 2) {
        self.productViewController.title = @"Google mobile devices";
        self.productViewController.products = self.googleProductsArray;
        self.productViewController.urls = self.googleUrlArray;
    } else {
        self.productViewController.title = @"Huawei mobile devices";
        self.productViewController.products = self.huaweiProductsArray;
        self.productViewController.urls = self.huaweiUrlArray;
    }
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
}

#pragma mark - Sets editing of a selected row and sets action for deletion
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.companyList removeObjectAtIndex:indexPath.row];
        //FIXME: Put logic here to also delete the product rows from the productview controller
        [tableView reloadData];
    }
}

@end
