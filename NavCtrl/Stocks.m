//
//  Stocks.m
//  NavCtrl
//
//  Created by Erica Correa on 5/24/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Stocks.h"
#import "DataAccessObject.h"

@interface Stocks()

@property (nonatomic, retain) DataAccessObject * dao;

@end

@implementation Stocks

- (void)getStockPrices:(CompanyViewController*)companyVC {
    
    self.dao = [DataAccessObject sharedInstance];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSMutableString * stockSymbolString = [[NSMutableString alloc]initWithString:@"http://finance.yahoo.com/d/quotes.csv?s="];
    for (Company * company in self.dao.companyList) {
        [stockSymbolString appendString:company.stockSymbol];
        [stockSymbolString appendString:@"+"];
    }
    [stockSymbolString appendString:@"&f=a"];
    
    NSURLSessionDataTask * stockData = [session dataTaskWithURL:[NSURL URLWithString:stockSymbolString] completionHandler:^(NSData * data, NSURLResponse *response, NSError * error) {
        NSString *csv = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSMutableArray * stockArray = (NSMutableArray *)[csv componentsSeparatedByString:@"\n"];
        [stockArray removeLastObject];
        for (int index = 0; index < [self.dao.companyList count]; index++) {
            self.dao.companyList[index].companyStockPrice = stockArray[index];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [companyVC.tableView reloadData];
        });
        [csv release];
    }];
    [stockData resume];
    [stockSymbolString release];
}

@end
