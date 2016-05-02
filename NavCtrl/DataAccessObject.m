//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"
//TODO: add textfield for user to enter string of new image and update code accordingly
//TODO: add textfield where user can enter stock symbol for company and update code accordingly

@interface DataAccessObject () {
sqlite3 * dataDB;
NSString * dbPathString;
}

@property (nonatomic, strong) NSString * documentsDirectory;
@property (nonatomic, strong) NSString * databaseFilename;
@property (nonatomic, retain) NSString * companyDBName;

- (id)initWithData;
- (UIImage *)createDefaultCompanyImage;
- (UIImage *)createDefaultProductImage;
- (instancetype)initDatabase;
- (void)copyDatabaseIntoDocumentsDirectory;
- (void)displayData;

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
        self.companyList = [[NSMutableArray alloc]init];
        [self initDatabase];
        [self displayData];
    }
    return self;
}

- (instancetype)initDatabase {
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        self.databaseFilename = @"sqlData.db";
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}

- (void)copyDatabaseIntoDocumentsDirectory{
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    dbPathString = destinationPath;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

- (void)displayData {
    sqlite3_stmt *companyStatement;
    if (sqlite3_open([dbPathString UTF8String], &dataDB) == SQLITE_OK) {
        [self.companyList removeAllObjects];
        NSString *querySQLCompanies = [NSString stringWithFormat:@"SELECT * FROM companies ORDER BY company_order"];
        const char *query_sql_companies = [querySQLCompanies UTF8String];
        if (sqlite3_prepare(dataDB, query_sql_companies, -1, &companyStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(companyStatement) == SQLITE_ROW) {
                int companyID = sqlite3_column_int(companyStatement, 0);
                float companyOrderNum = sqlite3_column_int(companyStatement, 3);
                NSString * companyDBName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(companyStatement, 1)];
                NSString * companyDBImage = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(companyStatement, 2)];
                Company * dbCompany = [[Company alloc]initWithCompanyName:companyDBName companyImage:[UIImage imageNamed:companyDBImage]];
                [dbCompany setCompanyID:companyID];
                [dbCompany setCompanyOrderNum:companyOrderNum];
                
                sqlite3_stmt *productStatement;
                NSString *querySQLProducts = [NSString stringWithFormat:@"SELECT * FROM products WHERE company_id = %d ORDER BY product_order", dbCompany.companyID];
                const char *query_sql_products = [querySQLProducts UTF8String];
                if (sqlite3_prepare(dataDB, query_sql_products, -1, &productStatement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(productStatement) == SQLITE_ROW) {
                        int productID = sqlite3_column_int(productStatement, 4);
                        float productOrderNum = sqlite3_column_int(productStatement, 5);
                        NSString * productDBName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(productStatement, 1)];
                        NSString * productDBImage = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(productStatement, 2)];
                        NSString * productDBUrl = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(productStatement, 3)];
                        Product * dbProduct = [[Product alloc]initWithProductName:productDBName productImage:[UIImage imageNamed:productDBImage] andProductUrl:productDBUrl];
                        [dbProduct setProductID:productID];
                        [dbProduct setProductOrderNum:productOrderNum];
                        [dbCompany.productArray addObject:dbProduct];
                    }
                }
                [self.companyList addObject:dbCompany];
            }
        }
    }
}

//TODO: change line 122 to have dynamic max
- (void)getStockPrices:(CompanyViewController*)companyVC {
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * stockData = [session dataTaskWithURL:[NSURL URLWithString:@"http://finance.yahoo.com/d/quotes.csv?s=AAPL+SSNLF+GOOG+TSLA&f=a"] completionHandler:^(NSData *data, NSURLResponse *response, NSError * error) {
        NSString *csv = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSArray * stockArray = [csv componentsSeparatedByString:@"\n"];
        for (int index = 0; index < 1; index++) {
            [self.companyList[index] setCompanyStockPrice:stockArray[index]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [companyVC.tableView reloadData];
        });
    }];
    [stockData resume];
}

- (Company *)createNewCompanyWithName:(NSString*)addNewCompanyName {
    Company * newCompany = [[Company alloc] initWithCompanyName:addNewCompanyName companyImage:[self createDefaultCompanyImage]];
    [self.companyList addObject:newCompany];
    
    NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO companies (company_name, company_image) VALUES ('%s','%s')",[addNewCompanyName UTF8String],[@"Default Company Image" UTF8String]];
    [self updateSqlWithString:insertStmt];
     NSLog(@"New company created");
    return newCompany;
}

- (UIImage *)createDefaultCompanyImage {
    UIImage * defaultCompanyImage = [[UIImage alloc] init];
    defaultCompanyImage = [UIImage imageNamed:@"Default Company Image"];
    return defaultCompanyImage;
}

- (Product *)createNewProductWithName:(NSString*)addNewProductName url:(NSString*)addNewProductUrl forCompany:(Company *)company {
    Product * newProduct = [[Product alloc]initWithProductName:addNewProductName productImage:[self createDefaultProductImage] andProductUrl:addNewProductUrl];
    
    NSString * insertStmt = [NSString stringWithFormat:@"INSERT INTO products (company_id, product_name, product_image, product_url) VALUES ('%d','%s','%s', '%s')", company.companyID, [addNewProductName UTF8String], [@"Default Product Image" UTF8String], [addNewProductUrl UTF8String]];
    [self updateSqlWithString:insertStmt];
     NSLog(@"New product created");
    return newProduct;
}

- (UIImage *)createDefaultProductImage {
    UIImage * defaultProductImage = [[UIImage alloc] init];
    defaultProductImage = [UIImage imageNamed:@"Default Product Image"];
    return defaultProductImage;
}

- (void)updateSqlWithString:(NSString *)string {
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    dbPathString = destinationPath;
    char *error;
    if(sqlite3_open([dbPathString UTF8String], &dataDB) == SQLITE_OK) {
        const char *insert_stmt = [string UTF8String];
        if (sqlite3_exec(dataDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK) {
            NSLog(@"Saved Successfully");
        }
        sqlite3_close(dataDB);
    }
}

- (Company *)editCompany:(Company *)company withName:(NSString *)updatedCompanyName {
    
    company.companyName = updatedCompanyName;
    
    NSString *updateStmt = [NSString stringWithFormat:@"UPDATE companies SET company_name = '%s' WHERE company_id = %d", [updatedCompanyName UTF8String], company.companyID];
    [self updateSqlWithString:updateStmt];
     NSLog(@"Company updated");
    return company;
}

- (Product *)editProduct:(Product *)product withName:(NSString *)updatedProductName withUrl:(NSString *)updatedUrl {
    product.productUrl = updatedUrl;
    if ([updatedProductName isEqualToString: @""]) {
        NSString *updateStmt = [NSString stringWithFormat:@"UPDATE products SET product_url = '%s' WHERE product_id = %d", [updatedUrl UTF8String], product.productID];
        [self updateSqlWithString:updateStmt];
    } else if ([updatedUrl isEqualToString:@""]) {
        NSString *updateStmt = [NSString stringWithFormat:@"UPDATE products SET product_name = '%s' WHERE product_id = %d", [updatedProductName UTF8String], product.productID];
        [self updateSqlWithString:updateStmt];
    } else {
        NSString *updateStmt = [NSString stringWithFormat:@"UPDATE products SET product_name = '%s', product_url = '%s' WHERE product_id = %d", [updatedProductName UTF8String], [updatedUrl UTF8String], product.productID];
        [self updateSqlWithString:updateStmt];
    }
    NSLog(@"Product updated");
    return product;
}

//FIXME: Deleting wrong company, correct at time of deletion, not persisting correctly
- (void)deleteCompanyAndItsProducts:(Company *)company {
    NSString * deleteCoStmt = [NSString stringWithFormat:@"DELETE FROM companies WHERE company_id = %d", company.companyID];
    [self updateSqlWithString:deleteCoStmt];
    
    NSString * deleteProdStmt = [NSString stringWithFormat:@"Delete FROM products WHERE company_id = %d", company.companyID];
    [self updateSqlWithString:deleteProdStmt];
    
    NSLog(@"Company Deleted");
}

- (void)deleteProduct:(Product *)product {
    
    NSString * deleteStmt = [NSString stringWithFormat:@"DELETE FROM products WHERE product_id = %d", product.productID];
    [self updateSqlWithString:deleteStmt];
    NSLog(@"Product Deleted");
}

- (void)moveCompanies {
    for (int index = 0; index < [self.companyList count]; index++) {
        Company * company = self.companyList[index];
        NSString * moveStmt = [NSString stringWithFormat:@"UPDATE companies SET company_order = %d WHERE company_id = %d", company.companyOrderNum, company.companyID];
        [self updateSqlWithString:moveStmt];
    }
    NSLog(@"Company Moved");
}

- (void)moveProductsForCompany:(Company *)company {
    for (int index = 0; index < [self.companyList count]; index++) {
        Product * product = company.productArray[index];
        NSString * moveStmt = [NSString stringWithFormat:@"UPDATE products SET product_order = %d WHERE product_id = %d", product.productOrderNum, product.productID];
        [self updateSqlWithString:moveStmt];
    }
    NSLog(@"Product Moved");
}

@end
