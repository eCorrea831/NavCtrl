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

@end

@implementation Stocks

- (NSMutableString *)createUrl {
    
    NSMutableString * stockSymbolString = [[NSMutableString alloc]initWithString:@"http://finance.yahoo.com/d/quotes.csv?s="];
    for (Company * company in [DataAccessObject sharedInstance].companyList) {
        [stockSymbolString appendString:company.companyStockSymbol];
        [stockSymbolString appendString:@"+"];
    }
    [stockSymbolString appendString:@"&f=a"];
    
    return stockSymbolString;
}

- (void)makeRequest:(CompanyCollectionViewController *)companyVC {
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSMutableString * stockSymbolString = [self createUrl];
    
    NSURLSessionDataTask * stockData = [session dataTaskWithURL:[NSURL URLWithString:stockSymbolString] completionHandler:^(NSData * data, NSURLResponse *response, NSError * error) {

        [self parseData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [companyVC.collectionView reloadData];
        });
    }];
    [stockSymbolString release];

    [stockData resume];
}

- (void)parseData:(NSData *)data {
    
    NSString *csv = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableArray * stockArray = (NSMutableArray *)[csv componentsSeparatedByString:@"\n"];
    //[stockArray removeLastObject];
    for (int index = 0; index < [[DataAccessObject sharedInstance].companyList count]; index++) {
        [DataAccessObject sharedInstance].companyList[index].companyStockPrice = stockArray[index];
    }
        [csv release];
}

@end
