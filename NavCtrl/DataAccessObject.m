//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"

/* 
 create new method that loops through the companyArray and productArrays and converts them from NSObject to NSManagedObjects (see notes in Google Drive)
 
 (later when you need to fetch entities you'll convert them from NSManagedObjects to NSObjects then convert them back.)
 */

@interface DataAccessObject () {
    
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

@property (nonatomic) NSNumber * largestCompanyOrderNum;
@property (nonatomic) NSNumber * largestProductOrderNum;
@property (nonatomic) NSInteger didAlreadyRun;

- (instancetype)initWithData;
- (void)initModelContext;
- (void)updateNSUserDefaults;
- (NSString *) archivePath;
- (void)saveChanges;
- (void)createCompanyData;
- (void)createProductDataForCompany:(Company *)company;
- (void)createManagedData;
- (void)displayCompaniesAndProducts;
- (void)matchNSObjectCompany:(Company *)company toManagedObjectCompany:(CompanyManagedObject *)managedCompany;
- (void)matchNSObjectProduct:(Product *)product toManagedObjectProduct:(ProductManagedObject *)managedProduct;

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
    
    //assigns defaults for archiving
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.didAlreadyRun = [defaults integerForKey:@"defaultRunCheck"];
    
        self = [super init];
        if (self) {
            if (self.didAlreadyRun) {
                [self initModelContext];
                [self displayCompaniesAndProducts];
            } else {
                [self initModelContext];
                [self createCompanyData];
                [self createManagedData];
            }
        }
        return self;
}

- (void)updateNSUserDefaults {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"defaultRunCheck"];
    [defaults synchronize];
}

- (void)initModelContext {
    
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSString *path = [self archivePath];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
    }
    context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [context setPersistentStoreCoordinator:psc];
    [context setUndoManager:nil];
    
    [self updateNSUserDefaults];
}

- (NSString *) archivePath {
    
    NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];

    NSLog(@"%@", documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:@"store.data"];
}

- (void) saveChanges {
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if(!successful){
        NSLog(@"Error saving: %@", [err userInfo]);
    } else {
        NSLog(@"Data Saved");
    }
}

- (void)createCompanyData {
    
    Company * apple = [[Company alloc] initWithCompanyName:@"Apple Mobile Devices"
                                                  orderNum:@1
                                                 imageName:@"AppleMobileDevices"
                                               stockSymbol:@"AAPL"];
    [self createProductDataForCompany:apple];
    
    Company * samsung = [[Company alloc] initWithCompanyName:@"Samsung Mobile Devices"
                                                    orderNum:@2
                                                   imageName:@"SamsungMobileDevices"
                                                 stockSymbol:@"SSNLF"];
    [self createProductDataForCompany:samsung];
    
    Company * google = [[Company alloc] initWithCompanyName:@"Google Mobile Devices"
                                                   orderNum:@3
                                                  imageName:@"GoogleMobileDevices"
                                                stockSymbol:@"GOOG"];
    [self createProductDataForCompany:google];
    
    Company * huawei = [[Company alloc] initWithCompanyName:@"Huawei Mobile Devices"
                                                   orderNum:@4
                                                  imageName:@"HuaweiMobileDevices"
                                                stockSymbol:@"TSLA"];
    [self createProductDataForCompany:huawei];
    
    self.companyList = [[NSMutableArray alloc]initWithObjects:apple, samsung, google, huawei, nil];
}

- (void)createProductDataForCompany:(Company *)company {

    if ([company.companyName isEqualToString:@"Apple Mobile Devices"]) {
        
        Product * iPad = [[Product alloc] initWithProductName:@"iPad"
                                                     orderNum:@1
                                                    imageName:@"iPad"
                                                          url:@"http://www.apple.com/ipad/"];
        
        Product * iPod = [[Product alloc] initWithProductName:@"iPod Touch"
                                                     orderNum:@2
                                                    imageName:@"iPodTouch"
                                                          url:@"http://www.apple.com/ipod/"];
        
        Product * iPhone = [[Product alloc] initWithProductName:@"iPhone"
                                                       orderNum:@3
                                                      imageName:@"iPhone"
                                                            url:@"http://www.apple.com/iphone/"];
        
        company.productArray = [[NSMutableArray alloc]initWithObjects:iPad, iPod, iPhone, nil];
    }
    
    if ([company.companyName isEqualToString:@"Samsung Mobile Devices"]) {
        
        Product * galaxyS4 = [[Product alloc] initWithProductName:@"Galaxy S4"
                                                         orderNum:@4
                                                        imageName:@"GalaxyS4"
                                                              url:@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZKPVZW"];
        
        Product * galaxyNote = [[Product alloc] initWithProductName:@"Galaxy Note"
                                                           orderNum:@5
                                                          imageName:@"GalaxyNote"
                                                                url:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-"];
        
        Product * galaxyTab = [[Product alloc] initWithProductName:@"Galaxy Tab"
                                                          orderNum:@6
                                                         imageName:@"GalaxyTab"
                                                               url:@"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-"];
        
        company.productArray = [[NSMutableArray alloc]initWithObjects:galaxyS4, galaxyNote, galaxyTab, nil];
    }
    
    if ([company.companyName isEqualToString:@"Google Mobile Devices"]) {
        
        Product * androidWear = [[Product alloc] initWithProductName:@"Android Wear"
                                                            orderNum:@7
                                                           imageName:@"AndroidWear"
                                                                 url:@"https://www.android.com/wear/"];
        
        
        Product * androidTablet = [[Product alloc] initWithProductName:@"Android Tablet"
                                                              orderNum:@8
                                                             imageName:@"AndroidTablet"
                                                                   url:@"https://www.android.com/tablets/"];
        
        Product * androidPhone = [[Product alloc] initWithProductName:@"Android Phone"
                                                             orderNum:@9
                                                            imageName:@"AndroidPhone"
                                                                  url:@"https://www.android.com/phones/"];

        company.productArray = [[NSMutableArray alloc]initWithObjects:androidWear, androidTablet, androidPhone, nil];
    }
    
    if ([company.companyName isEqualToString:@"Huawei Mobile Devices"]) {
        
        Product * huaweiMate = [[Product alloc] initWithProductName:@"Huawei Mate"
                                                           orderNum:@10
                                                          imageName:@"HuaweiMate"
                                                                url:@"http://consumer.huawei.com/minisite/worldwide/mate8/"];
        
        Product * huaweiMateBook = [[Product alloc] initWithProductName:@"Huawei MateBook"
                                                               orderNum:@11
                                                              imageName:@"HuaweiMatebook"
                                                                    url:@"http://consumer.huawei.com/minisite/worldwide/matebook/screen.htm"];
        
        Product * huaweiTalkBand = [[Product alloc] initWithProductName:@"Huawei Talkband"
                                                               orderNum:@12
                                                               imageName:@"HuaweiTalkband"
                                                                    url:@"http://consumer.huawei.com/en/wearables/talkband-b3/"];
        
        company.productArray = [[NSMutableArray alloc]initWithObjects:huaweiMate, huaweiMateBook, huaweiTalkBand, nil];
    }
}

- (void)createManagedData {
    
    for (Company * company in self.companyList) {
        
        CompanyManagedObject * managedCompany = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
        
        [CompanyManagedObject create:managedCompany withManagedCompanyName:company.companyName orderNum:company.companyOrderNum imageName:company.companyImageName stockSymbol:company.companyStockSymbol];
        
        NSMutableSet * productSet = [managedCompany mutableSetValueForKey:@"products"];
        
        for (Product * product in company.productArray) {
            
            ProductManagedObject * managedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
            
            [ProductManagedObject create:managedProduct withManagedProductName:product.productName orderNum:product.productOrderNum imageName:product.productImageName url:product.productUrl];
            
            [productSet addObject:managedProduct];

            [self saveChanges];
        }
    }
}

- (void)displayCompaniesAndProducts {
    
    if ([self.companyList count] == 0){
        NSFetchRequest * request = [[NSFetchRequest alloc]init];

        NSEntityDescription * company = [[model entitiesByName] objectForKey:@"Company"];
        [request setEntity:company];
        
        NSError * error = nil;
        NSArray * result = [context executeFetchRequest:request error:&error];
        if(!result){
            [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
        } else {
        
            //FIXME: Issue is either in saving the data or in fetching here
            for (NSManagedObject * managedCompany in result) {
                Company * company = [[Company alloc]initWithCompanyName:[managedCompany valueForKey:@"companyName"]
                                                               orderNum:[managedCompany valueForKey:@"companyOrderNum"]
                                                              imageName:[managedCompany valueForKey:@"companyImageName"]
                                                            stockSymbol:[managedCompany valueForKey:@"companyStockSymbol"]];
                [self.companyList addObject:company];
                
                for (NSManagedObject * managedProduct in [managedCompany valueForKey:@"products"]) {
                    
                    Product * product = [[Product alloc]initWithProductName:[managedProduct valueForKey:@"productName"]
                                                                   orderNum:[managedProduct valueForKey:@"productOrderNum"]
                                                                  imageName:[managedProduct valueForKey:@"productImageName"]
                                                                        url:[managedProduct valueForKey:@"productUrl"]];
                    [company.productArray addObject:product];
                }
                
                NSLog(@"Products count %lu", [[managedCompany valueForKey:@"products"] count]);
                [self.companyList addObject:company];
            }
            NSLog(@"Companies Count %lu", (unsigned long)[self.companyList count]);
        }
    }
}

- (void)matchNSObjectCompany:(Company *)company toManagedObjectCompany:(CompanyManagedObject *)managedCompany {
    company.companyName = managedCompany.companyName;
    company.companyOrderNum = managedCompany.companyOrderNum;
    company.companyImageName = managedCompany.companyImageName;
    company.companyStockSymbol = managedCompany.companyStockSymbol;
}

- (void)matchNSObjectProduct:(Product *)product toManagedObjectProduct:(ProductManagedObject *)managedProduct {
    product.productName = managedProduct.productName;
    product.productOrderNum = managedProduct.productOrderNum;
    product.productImageName = managedProduct.productImageName;
    product.productUrl = managedProduct.productUrl;
}

- (Company *)createNewCompanyWithName:(NSString *)name stockSymbol:(NSString *)stockSymbol imageName:(NSString *)imageName {
    
    NSNumber * newCompnayOrderNum = @([self.largestCompanyOrderNum floatValue] + 1);
    
    CompanyManagedObject * newManagedCompany = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
    [CompanyManagedObject create:newManagedCompany withManagedCompanyName:name orderNum:newCompnayOrderNum imageName:imageName stockSymbol:stockSymbol];
    [self saveChanges];
    
    Company * newCompany = [[Company alloc] initWithCompanyName:name orderNum:newCompnayOrderNum imageName:imageName stockSymbol:stockSymbol];
    
    [self.companyList addObject:newCompany];
    
     NSLog(@"New company created");
    
    [newCompany release];
    return newCompany;
}

- (Product *)createNewProductWithName:(NSString*)name image:(NSString *)imageName url:(NSString*)url forCompany:(Company *)company {
    
    NSNumber * newProductOrderNum = @([self.largestProductOrderNum floatValue] + 1);
    
    ProductManagedObject * newManagedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
    [ProductManagedObject create:newManagedProduct withManagedProductName:name orderNum: newProductOrderNum imageName:imageName url:url];
    
    
    //NSMutableSet * newCompanyProducts = [newManagedCompany mutableSetValueForKey:@"products"];
    //[productSet addObject:newManagedProduct];
    
    
    [self saveChanges];
    
    Product * newProduct = [[Product alloc]initWithProductName:name orderNum:newProductOrderNum imageName:imageName url:url];
    [company.productArray addObject:newProduct];
    
     NSLog(@"New product created");
    [newProduct release];
    return newProduct;
}

- (Company *)editcompany:(Company *)company withName:(NSString *)name imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol {
    
//    company.companyName = name;
//    company.companyImageName = imageName;
//    company.stockSymbol = stockSymbol;
//    
//    NSString * updateCompanyStmt = [NSString stringWithFormat:@"UPDATE companies SET company_name = '%s', company_image = '%s', company_stock_symbol = '%s' WHERE company_id = %d", [name UTF8String], [imageName UTF8String], [stockSymbol UTF8String], company.companyID];
//    [self updateSqlWithString:updateCompanyStmt];
    NSLog(@"Company updated");
    
    return company;
}

- (Product *)editProduct:(Product *)product withName:(NSString *)name imageName:(NSString *)imageName website:(NSString *)website {
    
//    product.productName = name;
//    product.productImageName = imageName;
//    product.productUrl = website;
//    
//    NSString * updateProductStmt = [NSString stringWithFormat:@"UPDATE products SET product_name = '%s', product_image = '%s', product_url = '%s' WHERE product_id = %d", [name UTF8String], [imageName UTF8String], [website UTF8String], product.productID];
//    [self updateSqlWithString:updateProductStmt];
//    NSLog(@"Product updated");
    
    return product;
}

- (void)deleteCompanyAndItsProducts:(Company *)company {
   
//    NSString * deleteProdStmt = [NSString stringWithFormat:@"Delete FROM products WHERE company_id = %d", company.companyID];
//    [self updateSqlWithString:deleteProdStmt];
//    NSString * deleteCoStmt = [NSString stringWithFormat:@"DELETE FROM companies WHERE company_id = %d", company.companyID];
//    [self updateSqlWithString:deleteCoStmt];
    NSLog(@"Company Deleted");
}

- (void)deleteProduct:(Product *)product {
    
//    NSString * deleteProductStmt = [NSString stringWithFormat:@"DELETE FROM products WHERE product_id = %d", product.productID];
//    [self updateSqlWithString:deleteProductStmt];
    NSLog(@"Product Deleted");
}

- (void)moveCompanies {
//    
//    for (int index = 0; index < [self.companyList count]; index++) {
//        Company * company = self.companyList[index];
//        NSString * moveCompanyStmt = [NSString stringWithFormat:@"UPDATE companies SET company_order = %d WHERE company_id = %d", company.companyOrderNum, company.companyID];
//        [self updateSqlWithString:moveCompanyStmt];
//    }
    NSLog(@"Company Moved");
}

- (void)moveProductsForCompany:(Company *)company {
    
//    for (int index = 0; index < [self.companyList count]; index++) {
//        Product * product = company.productArray[index];
//        NSString * moveProductStmt = [NSString stringWithFormat:@"UPDATE products SET product_order = %d WHERE product_id = %d", product.productOrderNum, product.productID];
//        [self updateSqlWithString:moveProductStmt];
//    }
    NSLog(@"Product Moved");
}

- (void)dealloc {
    [super dealloc];
}

@end
