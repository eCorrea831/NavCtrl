//
//  StocksAFNetworking.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/10/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "StocksAFNetworking.h"
#import "AFNetworking.h"
#import "DataAccessObject.h"

@implementation StocksAFNetworking

- (void)makeRequest {
    
    NSMutableArray * stockPriceArray = [[NSMutableArray alloc]init];
    for (Company * company in [DataAccessObject sharedInstance].companyList) {
        [stockPriceArray addObject:company.companyStockSymbol];
    }
    
    NSString * stockURLBase = [NSString stringWithFormat:@"http://finance.yahoo.com/webservice/v1/symbols/%@",[stockPriceArray componentsJoinedByString:@"," ]];
    NSString * stockURl = [stockURLBase stringByAppendingString:@"/quote?format=json"];

    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL * URL = [NSURL URLWithString:stockURl];
    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            for (int i = 0; i<[[responseObject valueForKeyPath:@"list.resources"] count]; i++) {
                NSString * stockPrice = [[[responseObject valueForKeyPath:@"list.resources"]objectAtIndex:i]valueForKeyPath:@"resource.fields.price"];
                [[[DataAccessObject sharedInstance].companyList objectAtIndex:i]setCompanyStockPrice:stockPrice];
                
                NSLog(@"The stock price is %@", stockPrice);
            }
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Reload" object:nil];
    }];
    [dataTask resume];
    
    [stockPriceArray dealloc];
}

@end
