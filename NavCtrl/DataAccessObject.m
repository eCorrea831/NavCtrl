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

@property (nonatomic) int largestCompanyOrderNum;
@property (nonatomic) int largestProductOrderNum;
@property (nonatomic) int didAlreadyRun;

- (instancetype)initWithData;
- (void)initModelContext;
- (void)updateNSUserDefaults;
- (NSString *) archivePath;
- (void)saveChanges;
- (void)createCompanyData;
- (void)createProductDataForCompany:(Company *)company productSet:(NSMutableSet *)productSet;
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
            self.companyList = [[NSMutableArray alloc]init];
            if (self.didAlreadyRun) {
                [self initModelContext];
                [self displayCompaniesAndProducts];
            } else {
                [self initModelContext];
                [self createCompanyData];
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
    
    //apple
    CompanyManagedObject * managedApple = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
    [CompanyManagedObject create:managedApple withManagedCompanyName:@"Apple Mobile Devices" orderNum:@1 imageName:@"AppleMobileDevices" stockSymbol:@"AAPL"];
    NSMutableSet * appleProducts = [managedApple mutableSetValueForKey:@"products"];
    [self saveChanges];
    
    Company * apple = [[Company alloc] initWithCompanyName:managedApple.companyName orderNum:[managedApple.companyOrderNum integerValue] imageName:managedApple.companyImageName stockSymbol:managedApple.companyStockSymbol];

    [self.companyList addObject:apple];
    [self createProductDataForCompany:apple productSet:appleProducts];
    
    //samsung
    CompanyManagedObject * managedSamsung = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
    [CompanyManagedObject create:managedSamsung withManagedCompanyName:@"Samsung Mobile Devices" orderNum:@2 imageName:@"SamsungMobileDevices" stockSymbol:@"SSNLF"];
    NSMutableSet * samsungProducts = [managedSamsung mutableSetValueForKey:@"products"];
    [self saveChanges];
    
    Company * samsung = [[Company alloc] initWithCompanyName:managedSamsung.companyName orderNum:[managedSamsung.companyOrderNum integerValue] imageName:managedSamsung.companyImageName stockSymbol:managedSamsung.companyStockSymbol];
    [self.companyList addObject:samsung];
    [self createProductDataForCompany:samsung productSet:samsungProducts];
    
    //google
    CompanyManagedObject * managedGoogle = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
    [CompanyManagedObject create:managedGoogle withManagedCompanyName:@"Google Mobile Devices" orderNum:@3 imageName:@"GoogleMobileDevices" stockSymbol:@"GOOG"];
    NSMutableSet * googleProducts = [managedGoogle mutableSetValueForKey:@"products"];
    [self saveChanges];
    
    Company * google = [[Company alloc] initWithCompanyName:managedGoogle.companyName orderNum:[managedGoogle.companyOrderNum integerValue] imageName:managedGoogle.companyImageName stockSymbol:managedGoogle.companyStockSymbol];
    [self.companyList addObject:google];
    [self createProductDataForCompany:google productSet:googleProducts];
    
    //huawei
    CompanyManagedObject * managedHuawei = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
    [CompanyManagedObject create:managedHuawei withManagedCompanyName:@"Huawei Mobile Devices" orderNum:@4 imageName:@"HuaweiMobileDevices" stockSymbol:@"TSLA"];
    NSMutableSet * huaweiProducts = [managedHuawei mutableSetValueForKey:@"products"];
    [self saveChanges];
    
    Company * huawei = [[Company alloc] initWithCompanyName:managedHuawei.companyName orderNum:[managedHuawei.companyOrderNum integerValue] imageName:managedHuawei.companyImageName stockSymbol:managedHuawei.companyStockSymbol];
    [self.companyList addObject:huawei];
    [self createProductDataForCompany:huawei productSet:huaweiProducts];
}

- (void)createProductDataForCompany:(Company *)company productSet:(NSMutableSet *)productSet {
    
    if ([company.companyName isEqualToString:@"Apple Mobile Devices"]) {

        //iPad
        ProductManagedObject * managedIPad = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedIPad withManagedProductName:@"iPad" orderNum:@1 imageName:@"iPad" url:@"http://www.apple.com/ipad/"];
        [productSet addObject:managedIPad];
        [self saveChanges];
        
        Product * iPad = [[Product alloc] initWithProductName:managedIPad.productName  orderNum:[managedIPad.productOrderNum integerValue] imageName:managedIPad.productImageName url:managedIPad.productUrl];
        [company.productArray addObject:iPad];
        
        //iPod
        ProductManagedObject * managedIPod = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedIPod withManagedProductName:@"iPod Touch" orderNum:@2 imageName:@"iPodTouch" url:@"http://www.apple.com/ipod/"];
        [productSet addObject:managedIPod];
        [self saveChanges];
        
        Product * iPod = [[Product alloc] initWithProductName:managedIPod.productName orderNum:[managedIPod.productOrderNum integerValue] imageName:managedIPod.productImageName url:managedIPod.productUrl];
        [company.productArray addObject:iPod];
        
        //iPhone
        ProductManagedObject * managedIPhone = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedIPhone withManagedProductName:@"iPhone" orderNum:@3 imageName:@"iPhone" url:@"http://www.apple.com/iphone/"];
        [productSet addObject:managedIPhone];
        [self saveChanges];
        
        Product * iPhone = [[Product alloc] initWithProductName:managedIPhone.productName orderNum:[managedIPhone.productOrderNum integerValue] imageName:managedIPhone.productImageName url:managedIPhone.productUrl];
        [company.productArray addObject:iPhone];
    }
    
    if ([company.companyName isEqualToString:@"Samsung Mobile Devices"]) {
        
        //galaxyS4
        ProductManagedObject * managedGalaxyS4 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedGalaxyS4 withManagedProductName:@"Galaxy S4" orderNum:@4 imageName:@"GalaxyS4" url:@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZKPVZW"];
        [productSet addObject:managedGalaxyS4];
        [self saveChanges];
        
        Product * galaxyS4 = [[Product alloc] initWithProductName:managedGalaxyS4.productName  orderNum:[managedGalaxyS4.productOrderNum integerValue] imageName:managedGalaxyS4.productImageName url:managedGalaxyS4.productUrl];
        [company.productArray addObject:galaxyS4];
        
        //galaxyNote
        ProductManagedObject * managedGalaxyNote = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedGalaxyNote withManagedProductName:@"Galaxy Note" orderNum:@5 imageName:@"GalaxyNote" url:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-"];
        [productSet addObject:managedGalaxyNote];
        [self saveChanges];
        
        Product * galaxyNote = [[Product alloc] initWithProductName:managedGalaxyNote.productName orderNum:[managedGalaxyNote.productOrderNum integerValue] imageName:managedGalaxyNote.productImageName url:managedGalaxyNote.productUrl];
        [company.productArray addObject:galaxyNote];
        
        //galaxyTab
        ProductManagedObject * managedGalaxyTab = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedGalaxyTab withManagedProductName:@"Galaxy Tab" orderNum:@6 imageName:@"GalaxyTab" url:@"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-"];
        [productSet addObject:managedGalaxyTab];
        [self saveChanges];
        
        Product * galaxyTab = [[Product alloc] initWithProductName:managedGalaxyTab.productName orderNum:[managedGalaxyTab.productOrderNum integerValue] imageName:managedGalaxyTab.productImageName url:managedGalaxyTab.productUrl];
        [company.productArray addObject:galaxyTab];
    }
    
    if ([company.companyName isEqualToString:@"Google Mobile Devices"]) {
        
        //androidWear
        ProductManagedObject * managedAndroidWear = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedAndroidWear withManagedProductName:@"Android Wear" orderNum:@7 imageName:@"AndroidWear" url:@"https://www.android.com/wear/"];
        [productSet addObject:managedAndroidWear];
        [self saveChanges];
        
        Product * androidWear = [[Product alloc] initWithProductName:managedAndroidWear.productName orderNum:[managedAndroidWear.productOrderNum integerValue] imageName:managedAndroidWear.productImageName url:managedAndroidWear.productUrl];
        [company.productArray addObject:androidWear];
        
        //androidTablet
        ProductManagedObject * managedAndroidTablet = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedAndroidTablet withManagedProductName:@"Android Tablet" orderNum:@8 imageName:@"AndroidTablet" url:@"https://www.android.com/tablets/"];
        [productSet addObject:managedAndroidTablet];
        [self saveChanges];
        
        Product * androidTablet = [[Product alloc] initWithProductName:managedAndroidTablet.productName orderNum:[managedAndroidTablet.productOrderNum integerValue] imageName:managedAndroidTablet.productImageName url:managedAndroidTablet.productUrl];
        [company.productArray addObject:androidTablet];
        
        //androidPhone
        ProductManagedObject * managedAndroidPhone = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedAndroidPhone withManagedProductName:@"Android Phone" orderNum:@9 imageName:@"AndroidPhone" url:@"https://www.android.com/phones/"];
        [productSet addObject:managedAndroidPhone];
        [self saveChanges];
        
        Product * androidPhone = [[Product alloc] initWithProductName:managedAndroidPhone.productName orderNum:[managedAndroidPhone.productOrderNum integerValue] imageName:managedAndroidPhone.productImageName url:managedAndroidPhone.productUrl];
        [company.productArray addObject:androidPhone];
    }
    
    if ([company.companyName isEqualToString:@"Huawei Mobile Devices"]) {
        
        //huaweiMate
        ProductManagedObject * managedHuaweiMate = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedHuaweiMate withManagedProductName:@"Huawei Mate" orderNum:@10 imageName:@"HuaweiMate" url:@"http://consumer.huawei.com/minisite/worldwide/mate8/"];
        [productSet addObject:managedHuaweiMate];
         [self saveChanges];
        
        Product * huaweiMate = [[Product alloc] initWithProductName:managedHuaweiMate.productName orderNum:[managedHuaweiMate.productOrderNum integerValue] imageName:managedHuaweiMate.productImageName url:managedHuaweiMate.productUrl];
        [company.productArray addObject:huaweiMate];
        
        //huaweiMateBook
        ProductManagedObject * managedHuaweiMateBook = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedHuaweiMateBook withManagedProductName:@"Huawei MateBook" orderNum:@11 imageName:@"HuaweiMatebook" url:@"http://consumer.huawei.com/minisite/worldwide/matebook/screen.htm"];
        [productSet addObject:managedHuaweiMateBook];
        [self saveChanges];
        
        Product * huaweiMateBook = [[Product alloc] initWithProductName:managedHuaweiMateBook.productName orderNum:[managedHuaweiMateBook.productOrderNum integerValue] imageName:managedHuaweiMateBook.productImageName url:managedHuaweiMateBook.productUrl];
        [company.productArray addObject:huaweiMateBook];
        
        //huaweiTalkBand
        ProductManagedObject * managedHuaweiTalkBand = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        [ProductManagedObject create:managedHuaweiTalkBand withManagedProductName:@"Huawei Talkband" orderNum:@12 imageName:@"HuaweiTalkband" url:@"http://consumer.huawei.com/en/wearables/talkband-b3/"];
        [productSet addObject:managedHuaweiTalkBand];
        [self saveChanges];
        
        Product * huaweiTalkBand = [[Product alloc] initWithProductName:managedHuaweiTalkBand.productName orderNum:[managedHuaweiTalkBand.productOrderNum integerValue] imageName:managedHuaweiTalkBand.productImageName url:managedHuaweiTalkBand.productUrl];
        [company.productArray addObject:huaweiTalkBand];
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
        
            for (NSManagedObject * managedCompany in result) {
                Company * company = [[Company alloc]initWithCompanyName:[managedCompany valueForKey:@"companyName"] orderNum:[[managedCompany valueForKey:@"companyOrderNum"] integerValue] imageName:[managedCompany valueForKey:@"companyImageName"] stockSymbol:[managedCompany valueForKey:@"companyStockSymbol"]];
                
                for (NSManagedObject * managedProduct in [managedCompany valueForKey:@"products"]) {
                    
                    Product * product = [[Product alloc]initWithProductName:[managedProduct valueForKey:@"productName"] orderNum:[[managedProduct valueForKey:@"productOrderNum"] integerValue] imageName:[managedProduct valueForKey:@"productImageName"] url:[managedProduct valueForKey:@"productUrl"]];
                    [company.productArray addObject:product];
                }
                
                NSLog(@"Products count %u", [[managedCompany valueForKey:@"products"] count]);
                [self.companyList addObject:company];
            }
            NSLog(@"Companies Count %lu", (unsigned long)[self.companyList count]);
        }
    }
}

- (void)matchNSObjectCompany:(Company *)company toManagedObjectCompany:(CompanyManagedObject *)managedCompany {
    company.companyName = managedCompany.companyName;
    company.companyOrderNum = [managedCompany.companyOrderNum integerValue];
    company.companyImageName = managedCompany.companyImageName;
    company.companyStockSymbol = managedCompany.companyStockSymbol;
}

- (void)matchNSObjectProduct:(Product *)product toManagedObjectProduct:(ProductManagedObject *)managedProduct {
    product.productName = managedProduct.productName;
    product.productOrderNum = [managedProduct.productOrderNum integerValue];
    product.productImageName = managedProduct.productImageName;
    product.productUrl = managedProduct.productUrl;
}

- (Company *)createNewCompanyWithName:(NSString *)name stockSymbol:(NSString *)stockSymbol imageName:(NSString *)imageName {
    
    CompanyManagedObject * newManagedCompany = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
    [CompanyManagedObject create:newManagedCompany withManagedCompanyName:name orderNum:[NSNumber numberWithInt:self.largestCompanyOrderNum + 1] imageName:imageName stockSymbol:stockSymbol];
    [self saveChanges];
    
    Company * newCompany = [[Company alloc] initWithCompanyName:name orderNum:self.largestCompanyOrderNum + 1 imageName:imageName stockSymbol:stockSymbol];
    
    [self.companyList addObject:newCompany];
    
     NSLog(@"New company created");
    
    [newCompany release];
    return newCompany;
}

- (Product *)createNewProductWithName:(NSString*)name image:(NSString *)imageName url:(NSString*)url forCompany:(Company *)company {
    
    ProductManagedObject * newManagedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
    [ProductManagedObject create:newManagedProduct withManagedProductName:name orderNum:[NSNumber numberWithInt:self.largestProductOrderNum + 1] imageName:imageName url:url];
    
    
    //NSMutableSet * newCompanyProducts = [newManagedCompany mutableSetValueForKey:@"products"];
    //[productSet addObject:newManagedProduct];
    
    
    [self saveChanges];
    
    Product * newProduct = [[Product alloc]initWithProductName:name orderNum:self.largestProductOrderNum + 1 imageName:imageName url:url];
    [company.productArray addObject:newProduct];
    
     NSLog(@"New product created");
    //[newProduct release];
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
