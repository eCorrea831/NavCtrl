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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.companyList = @[@"Apple mobile devices",@"Samsung mobile devices", @"Google mobile devices", @"Huawei mobile devices"];
    self.title = @"Mobile device makers";
    
    self.appleProductsArray = @[@"iPad", @"iPod Touch", @"iPhone"];
    self.appleUrlArray = @[@"http://www.apple.com/ipad/", @"http://www.apple.com/ipod/",@"http://www.apple.com/iphone/"];
    
    self.samsungProductsArray = @[@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab"];
    self.samsungUrlArray = @[@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZKPVZW", @"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-", @"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-"];
    
    self.googleProductsArray = @[@"Android Wear", @"Android Tablet",@"Android Phone"];
    self.googleUrlArray = @[@"https://www.android.com/wear/", @"https://www.android.com/tablets/", @"https://www.android.com/phones/"];
    
    self.huaweiProductsArray = @[@"Huawei Mate", @"Huawei MateBook",@"Huawei TalkBand"];
    self.huaweiUrlArray = @[@"http://consumer.huawei.com/minisite/worldwide/mate8/", @"http://consumer.huawei.com/minisite/worldwide/matebook/screen.htm", @"http://consumer.huawei.com/en/wearables/talkband-b3/"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
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
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
 


@end
