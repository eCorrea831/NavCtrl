//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"

@interface DataAccessObject ()

- (id)initWithData;
- (UIImage *)createDefaultCompanyImage;
- (UIImage*)createDefaultProductImage;


@end

@implementation DataAccessObject

+ (DataAccessObject *)sharedInstance {
    static DataAccessObject *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DataAccessObject alloc] initWithData];
    });
    return _sharedInstance;
}

- (id)initWithData {

    self = [super init];
    if (self) {
        
        Company * apple = [[Company alloc]initWithCompanyName:@"Apple mobile devices" companyImage:[UIImage imageNamed:@"Apple Mobile Devices"]];
        
        Product * iPad = [[Product alloc]initWithProductName:@"iPad" productImage: [UIImage imageNamed:@"iPad"] andProductUrl:@"http://www.apple.com/ipad/"];
        Product * iPodTouch = [[Product alloc]initWithProductName:@"iPod Touch" productImage: [UIImage imageNamed:@"iPod Touch"] andProductUrl:@"http://www.apple.com/ipod/"];
        Product * iPhone = [[Product alloc]initWithProductName:@"iPhone" productImage: [UIImage imageNamed:@"iPhone"] andProductUrl:@"http://www.apple.com/iphone/"];
        apple.productArray = [NSMutableArray arrayWithObjects:iPad, iPodTouch, iPhone, nil];
        
        Company * samsung = [[Company alloc]initWithCompanyName:@"Samsung mobile devices" companyImage:[UIImage imageNamed:@"Samsung Mobile Devices"]];
        Product * galaxyS4 = [[Product alloc]initWithProductName:@"Galaxy S4" productImage: [UIImage imageNamed:@"Galaxy S4"] andProductUrl:@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZKPVZW"];
        Product * galaxyNote = [[Product alloc]initWithProductName:@"Galaxy Note" productImage: [UIImage imageNamed:@"Galaxy Note"] andProductUrl:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-"];
        Product * galaxyTab = [[Product alloc]initWithProductName:@"Galaxy Tab" productImage: [UIImage imageNamed:@"Galaxy Tab"] andProductUrl:@"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-"];
        samsung.productArray = [NSMutableArray arrayWithObjects:galaxyS4, galaxyNote, galaxyTab, nil];
        
        Company * google = [[Company alloc]initWithCompanyName:@"Google mobile devices" companyImage:[UIImage imageNamed:@"Google Mobile Devices"]];
        Product * androidWear = [[Product alloc]initWithProductName:@"Android Wear" productImage:[UIImage imageNamed:@"Android Wear"] andProductUrl:@"https://www.android.com/wear/"];
        Product * androidTablet = [[Product alloc]initWithProductName:@"Android Tablet" productImage:[UIImage imageNamed:@"Android Tablet"] andProductUrl:@"https://www.android.com/tablets/"];
        Product * androidPhone = [[Product alloc]initWithProductName:@"Android Phone" productImage:[UIImage imageNamed:@"Android Phone"] andProductUrl:@"https://www.android.com/phones/"];
        google.productArray = [NSMutableArray arrayWithObjects:androidWear, androidTablet, androidPhone, nil];
        
        Company * huawei = [[Company alloc]initWithCompanyName:@"Huawei mobile devices" companyImage:[UIImage imageNamed:@"Huawei Mobile Devices"]];
        Product * huaweiMate = [[Product alloc]initWithProductName:@"Huawei Mate" productImage:[UIImage imageNamed:@"Huawei Mate"] andProductUrl:@"http://consumer.huawei.com/minisite/worldwide/mate8/"];
        Product * huaweiMateBook = [[Product alloc]initWithProductName:@"Huawei MateBook" productImage:[UIImage imageNamed:@"Huawei Matebook"] andProductUrl:@"http://consumer.huawei.com/minisite/worldwide/matebook/screen.htm"];
        Product * huaweiTalkBand = [[Product alloc]initWithProductName:@"Huawei TalkBand" productImage:[UIImage imageNamed:@"Huawei Talkband"] andProductUrl:@"http://consumer.huawei.com/en/wearables/talkband-b3/"];
        huawei.productArray = [NSMutableArray arrayWithObjects:huaweiMate, huaweiMateBook, huaweiTalkBand, nil];

        self.companyList = [NSMutableArray arrayWithObjects:apple, samsung, google, huawei, nil];
    }
    return self;
}

- (UIImage *)createDefaultCompanyImage {
    UIImage * defaultCompanyImage = [[UIImage alloc] init];
    defaultCompanyImage = [UIImage imageNamed:@"Default Company Image"];
    return defaultCompanyImage;
}

- (Company *)createNewCompanyWithName:(NSString*)addNewCompanyName {
    Company * newCompany = [[Company alloc]initWithCompanyName:addNewCompanyName companyImage:[self createDefaultCompanyImage]];
    [self.companyList addObject:newCompany];
    return newCompany;
}

- (Company *)editCompany:(Company *)company withName:(NSString *)updatedCompanyName {
    company.companyName = updatedCompanyName;
    return company;
}

- (UIImage *)createDefaultProductImage {
    UIImage * defaultProductImage = [[UIImage alloc] init];
    defaultProductImage = [UIImage imageNamed:@"Default Product Image"];
    return defaultProductImage;
}

- (Product *)createNewProductWithName:(NSString*)addNewProductName url:(NSString*)addNewProductUrl {
    Product * newProduct = [[Product alloc]initWithProductName:addNewProductName productImage:[self createDefaultProductImage] andProductUrl:addNewProductUrl];
    return newProduct;
}

- (Product *)editProduct:(Product *)product withName:(NSString *)updatedProductName withUrl:(NSString *)updatedUrl {
    product.productName = updatedProductName;
    product.productUrl = updatedUrl;
    return product;
}

- (void)getStockPrices:(CompanyViewController*)companyVC {
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * stockData = [session dataTaskWithURL:[NSURL URLWithString:@"http://finance.yahoo.com/d/quotes.csv?s=AAPL+SSNLF+GOOG+TSLA&f=a"] completionHandler:^(NSData *data, NSURLResponse *response, NSError * error) {
        NSString *csv = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSArray * stockArray = [csv componentsSeparatedByString:@"\n"];
        for (int index = 0; index < [self.companyList count]; index++) {
            [self.companyList[index] setCompanyStockPrice:stockArray[index]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [companyVC.tableView reloadData];
        });
    }];
    [stockData resume];
}

@end
