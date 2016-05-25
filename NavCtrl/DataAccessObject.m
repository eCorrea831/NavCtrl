//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"

@interface DataAccessObject () {
    sqlite3 * dataDB;
    NSString * dbPathString;
}

@property (nonatomic, strong) NSString * documentsDirectory;
@property (nonatomic, strong) NSString * databaseFilename;
@property (nonatomic) int largestCompanyOrderNum;
@property (nonatomic) int largestCompanyID;
@property (nonatomic) int largestProductOrderNum;
@property (nonatomic) int largestProductID;

- (instancetype)initWithData;
- (void)createDatabase;
- (void)copyDatabaseIntoDocumentsDirectory;
- (void)displayCompanies;
- (void)displayProductsForCompany:(Company *)company;

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

- (instancetype)initWithData {

    self = [super init];
    if (self) {
        self.companyList = [[NSMutableArray alloc]init];
        [self createDatabase];
        [self displayCompanies];
    }
    return self;
}

- (void)createDatabase {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.documentsDirectory = [paths objectAtIndex:0];
    self.databaseFilename = @"sqlData.db";
    [self copyDatabaseIntoDocumentsDirectory];
}

- (void)copyDatabaseIntoDocumentsDirectory {
    
    NSString * destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    dbPathString = destinationPath;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        NSString * sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError * error;
        if(![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error]) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    }
}

- (void)displayCompanies {
    
    sqlite3_stmt * companyStatement;
    
    if (sqlite3_open([dbPathString UTF8String], &dataDB) == SQLITE_OK) {
        
        [self.companyList removeAllObjects];
        NSString * querySQLCompanies = [NSString stringWithFormat:@"SELECT * FROM companies ORDER BY company_order"];
        const char * query_sql_companies = [querySQLCompanies UTF8String];
        
        if (sqlite3_prepare(dataDB, query_sql_companies, -1, &companyStatement, NULL) == SQLITE_OK) {
            
            self.largestCompanyID = 0;
            self.largestCompanyOrderNum = 0;
            
            while (sqlite3_step(companyStatement) == SQLITE_ROW) {
                
                int companyID = sqlite3_column_int(companyStatement, 0);
                int companyOrderNum = sqlite3_column_int(companyStatement, 3);
                
                if (companyID > self.largestCompanyID) {
                    self.largestCompanyID = companyID;
                }
                
                if (companyOrderNum > self.largestCompanyOrderNum) {
                    self.largestCompanyOrderNum = companyOrderNum;
                }
                
                NSString * companyDBName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(companyStatement, 1)];
                NSString * companyDBImage = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(companyStatement, 2)];
                NSString * companyDBStockSymbol = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(companyStatement, 4)];
                
                Company * dbCompany = [[Company alloc]initWithCompanyName:companyDBName imageName:companyDBImage stockSymbol:companyDBStockSymbol];
                [dbCompany setCompanyID:companyID];
                [dbCompany setCompanyOrderNum:companyOrderNum];
                [self.companyList addObject:dbCompany];
                
                [self displayProductsForCompany:dbCompany];
                
                [dbCompany release];
            }
        }
    }
}

- (void)displayProductsForCompany:(Company *)company {
    
    sqlite3_stmt * productStatement;
    
    NSString * querySQLProducts = [NSString stringWithFormat:@"SELECT * FROM products WHERE company_id = %d ORDER BY product_order", company.companyID];
    const char * query_sql_products = [querySQLProducts UTF8String];
    
    if (sqlite3_prepare(dataDB, query_sql_products, -1, &productStatement, NULL) == SQLITE_OK) {
        
        self.largestProductID = 0;
        self.largestProductOrderNum = 0;
        
        while (sqlite3_step(productStatement) == SQLITE_ROW) {
    
            int productID = sqlite3_column_int(productStatement, 4);
            int productOrderNum = sqlite3_column_int(productStatement, 5);
            
            if (productID > self.largestProductID) {
                self.largestProductID = productID;
            }
            
            if (productOrderNum > self.largestProductOrderNum) {
                self.largestProductOrderNum = productOrderNum;
            }
            
            NSString * productDBName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(productStatement, 1)];
            NSString * productDBImage = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(productStatement, 2)];
            NSString * productDBUrl = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(productStatement, 3)];
            Product * dbProduct = [[Product alloc]initWithProductName:productDBName imageName:productDBImage url:productDBUrl];
            
            [dbProduct setProductID:productID];
            [dbProduct setProductOrderNum:productOrderNum];
            [company.productArray addObject:dbProduct];
            [dbProduct release];
        }
    }
}

- (void)updateSqlWithString:(NSString *)string {
    
    NSString * destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    dbPathString = destinationPath;
    char * error;
    if(sqlite3_open([dbPathString UTF8String], &dataDB) == SQLITE_OK) {
        const char * insert_stmt = [string UTF8String];
        if (sqlite3_exec(dataDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK) {
            NSLog(@"Saved Successfully");
        }
        sqlite3_close(dataDB);
    }
}

- (Company *)createNewCompanyWithName:(NSString *)name stockSymbol:(NSString *)stockSymbol imageName:(NSString *)imageName {
    
    Company * newCompany = [[Company alloc] initWithCompanyName:name imageName:imageName stockSymbol:stockSymbol];
    
    [self.companyList addObject:newCompany];
    newCompany.companyID = self.largestCompanyID + 1;
    newCompany.companyOrderNum = self.largestCompanyOrderNum + 1;
    NSString * insertCompanyStmt = [NSString stringWithFormat:@"INSERT INTO companies (company_name, company_image, company_stock_symbol, company_order) VALUES ('%s','%s', '%s', %d)",[name UTF8String],[imageName UTF8String], [stockSymbol UTF8String], self.largestCompanyOrderNum + 1];
    [self updateSqlWithString:insertCompanyStmt];
     NSLog(@"New company created");
    [newCompany release];
    return newCompany;
}

- (Product *)createNewProductWithName:(NSString*)name image:(NSString *)imageName url:(NSString*)url forCompany:(Company *)company {
    
    Product * newProduct = [[Product alloc]initWithProductName:name imageName:imageName url:url];
    newProduct.productID = self.largestProductID + 1;
    newProduct.productOrderNum = self.largestProductOrderNum + 1;
    NSString * insertProductStmt = [NSString stringWithFormat:@"INSERT INTO products (company_id, product_name, product_image, product_url, product_order) VALUES ('%d','%s','%s', '%s', %d)", company.companyID, [name UTF8String], [imageName UTF8String], [url UTF8String], self.largestProductOrderNum + 1];
    [self updateSqlWithString:insertProductStmt];
    [company.productArray addObject:newProduct];
     NSLog(@"New product created");
    [newProduct release];
    return newProduct;
}

- (Company *)editcompany:(Company *)company withName:(NSString *)name imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol {
    
    company.companyName = name;
    company.companyImageName = imageName;
    company.stockSymbol = stockSymbol;
    
    NSString * updateCompanyStmt = [NSString stringWithFormat:@"UPDATE companies SET company_name = '%s', company_image = '%s', company_stock_symbol = '%s' WHERE company_id = %d", [name UTF8String], [imageName UTF8String], [stockSymbol UTF8String], company.companyID];
    [self updateSqlWithString:updateCompanyStmt];
    NSLog(@"Company updated");
    
    return company;
}

- (Product *)editProduct:(Product *)product withName:(NSString *)name {
    
    product.productName = name;
    NSString * updateProductNameStmt = [NSString stringWithFormat:@"UPDATE products SET product_name = '%s' WHERE product_id = %d", [name UTF8String], product.productID];
    [self updateSqlWithString:updateProductNameStmt];
    NSLog(@"Product name updated");
    return product;
}

- (Product *)editProduct:(Product *)product withUrl:(NSString *)url {
    
    product.productUrl = url;
    NSString * updateProductUrlStmt = [NSString stringWithFormat:@"UPDATE products SET product_url = '%s' WHERE product_id = %d", [url UTF8String], product.productID];
    [self updateSqlWithString:updateProductUrlStmt];
    NSLog(@"Product url updated");
    return product;
}

- (Product *)editProduct:(Product *)product withImageName:(NSString *)imageName {
    
    product.productImageName = imageName;
    NSString * updateProductImageStmt = [NSString stringWithFormat:@"UPDATE products SET product_image = '%s' WHERE product_id = %d", [imageName UTF8String], product.productID];
    [self updateSqlWithString:updateProductImageStmt];
    NSLog(@"Product image updated");
    return product;
}

- (void)deleteCompanyAndItsProducts:(Company *)company {
    
    NSString * deleteProdStmt = [NSString stringWithFormat:@"Delete FROM products WHERE company_id = %d", company.companyID];
    [self updateSqlWithString:deleteProdStmt];
    NSString * deleteCoStmt = [NSString stringWithFormat:@"DELETE FROM companies WHERE company_id = %d", company.companyID];
    [self updateSqlWithString:deleteCoStmt];
    NSLog(@"Company Deleted");
}

- (void)deleteProduct:(Product *)product {
    
    NSString * deleteProductStmt = [NSString stringWithFormat:@"DELETE FROM products WHERE product_id = %d", product.productID];
    [self updateSqlWithString:deleteProductStmt];
    NSLog(@"Product Deleted");
}

- (void)moveCompanies {
    
    for (int index = 0; index < [self.companyList count]; index++) {
        Company * company = self.companyList[index];
        NSString * moveCompanyStmt = [NSString stringWithFormat:@"UPDATE companies SET company_order = %d WHERE company_id = %d", company.companyOrderNum, company.companyID];
        [self updateSqlWithString:moveCompanyStmt];
    }
    NSLog(@"Company Moved");
}

- (void)moveProductsForCompany:(Company *)company {
    
    for (int index = 0; index < [self.companyList count]; index++) {
        Product * product = company.productArray[index];
        NSString * moveProductStmt = [NSString stringWithFormat:@"UPDATE products SET product_order = %d WHERE product_id = %d", product.productOrderNum, product.productID];
        [self updateSqlWithString:moveProductStmt];
    }
    NSLog(@"Product Moved");
}

- (void)dealloc {
    [super dealloc];
}

@end
