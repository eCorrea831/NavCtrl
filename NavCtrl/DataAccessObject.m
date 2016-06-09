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

@interface DataAccessObject ()

@property (nonatomic) NSNumber * largestCompanyOrderNum;
@property (nonatomic) NSNumber * largestProductOrderNum;
@property (nonatomic) NSInteger didAlreadyRun;

@end

@implementation DataAccessObject

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithData];
    });
    
    return sharedInstance;
}

- (instancetype)initWithData {
    
    //assigns defaults for archiving
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.didAlreadyRun = [defaults integerForKey:@"defaultRunCheck"];
    
    self.companyList = [[NSMutableArray alloc] init];

        self = [super init];
        if (self) {
            if (self.didAlreadyRun) {
                [self initModelContext];
                [self fetchCompaniesAndProducts];
            } else {
                [self initModelContext];
                [self createCompanyData];
                [self createManagedData];
            }
        }
        return self;
}

- (void)updateDidAlreadyRun {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"defaultRunCheck"];
    [defaults synchronize];
}

- (void)initModelContext {
    
    self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator * psc =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    NSString * path = [self archivePath];
    NSURL * storeURL = [NSURL fileURLWithPath:path];
    NSError * error = nil;
    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
    }
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.context.undoManager = [[NSUndoManager alloc] init];
    [self.context setPersistentStoreCoordinator:psc];
    
    [self updateDidAlreadyRun];
}

- (NSString *)archivePath {
    
    NSArray * documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [documentsDirectories objectAtIndex:0];

    NSLog(@"%@", documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:@"store.data"];
}

- (void)saveChanges {
    NSError * err = nil;
    BOOL successful = [self.context save:&err];
    if (!successful){
        NSLog(@"Error saving: %@", [err userInfo]);
    } else {
        NSLog(@"Data Saved to disk");
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
    
    self.companyList = [[NSMutableArray alloc] initWithObjects:apple, samsung, google, huawei, nil];
    
    self.largestCompanyOrderNum = @4;
    [self saveChanges];
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
        
        company.productArray = [[NSMutableArray alloc] initWithObjects:iPad, iPod, iPhone, nil];
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
        
        company.productArray = [[NSMutableArray alloc] initWithObjects:galaxyS4, galaxyNote, galaxyTab, nil];
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

        company.productArray = [[NSMutableArray alloc] initWithObjects:androidWear, androidTablet, androidPhone, nil];
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
        
        company.productArray = [[NSMutableArray alloc] initWithObjects:huaweiMate, huaweiMateBook, huaweiTalkBand, nil];
    }
    self.largestProductOrderNum = @12;
}

- (void)createManagedData {
    
    for (Company * company in self.companyList) {
        
        CompanyManagedObject * managedCompany = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.context];
        
        [CompanyManagedObject create:managedCompany withManagedCompanyName:company.companyName orderNum:company.companyOrderNum imageName:company.companyImageName stockSymbol:company.companyStockSymbol];
        
        NSMutableSet * productSet = [managedCompany mutableSetValueForKey:@"products"];
        
        for (Product * product in company.productArray) {
            
            ProductManagedObject * managedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.context];
            
            [ProductManagedObject create:managedProduct withManagedProductName:product.productName orderNum:product.productOrderNum imageName:product.productImageName url:product.productUrl];
            
            [productSet addObject:managedProduct];
            
            [self saveChanges];
        }
    }
}

- (void)fetchCompaniesAndProducts {
    
    if (!self.companyList) {
        self.companyList = [[NSMutableArray alloc]init];

        NSFetchRequest * request = [[NSFetchRequest alloc]init];

        NSEntityDescription * company = [[self.model entitiesByName] objectForKey:@"Company"];
        [request setEntity:company];
        
        //sort by companyOrderNum
        NSSortDescriptor * companySortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"companyOrderNum" ascending:YES];

        NSArray * sortDescriptors = [[NSArray alloc] initWithObjects:companySortDescriptor, nil];
        
        [request setSortDescriptors:sortDescriptors];

        //error handling
        NSError * error = nil;
        NSArray * result = [self.context executeFetchRequest:request error:&error];
        if(!result){
            [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
        } else {
        
            for (NSManagedObject * managedCompany in result) {
                Company * company = [[Company alloc]initWithCompanyName:[managedCompany valueForKey:@"companyName"]
                                                               orderNum:[managedCompany valueForKey:@"companyOrderNum"]
                                                              imageName:[managedCompany valueForKey:@"companyImageName"]
                                                            stockSymbol:[managedCompany valueForKey:@"companyStockSymbol"]];
                
                if (self.largestCompanyOrderNum < company.companyOrderNum) {
                    self.largestCompanyOrderNum = company.companyOrderNum;
                }
                
                for (NSManagedObject * managedProduct in [managedCompany valueForKey:@"products"]) {
                    
                    Product * product = [[Product alloc]initWithProductName:[managedProduct valueForKey:@"productName"]
                                                                   orderNum:[managedProduct valueForKey:@"productOrderNum"]
                                                                  imageName:[managedProduct valueForKey:@"productImageName"]
                                                                        url:[managedProduct valueForKey:@"productUrl"]];
                    
                    [company.productArray addObject:product];
                    
                    if (self.largestProductOrderNum < product.productOrderNum) {
                        self.largestProductOrderNum = product.productOrderNum;
                    }
                    //sort by productOrderNum
                    [company.productArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"productOrderNum" ascending:YES]]];
                }
                
                NSLog(@"Products count %lu", [[managedCompany valueForKey:@"products"] count]);
                [self.companyList addObject:company];
            }
            NSLog(@"Companies Count %lu", (unsigned long)[self.companyList count]);
        }
    }
}

- (Company *)createNewCompanyWithName:(NSString *)name stockSymbol:(NSString *)stockSymbol imageName:(NSString *)imageName {
    
    NSNumber * newCompnayOrderNum = @([self.largestCompanyOrderNum floatValue] + 1);
    
    CompanyManagedObject * newManagedCompany = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.context];
    [CompanyManagedObject create:newManagedCompany withManagedCompanyName:name orderNum:newCompnayOrderNum imageName:imageName stockSymbol:stockSymbol];
    
    Company * newCompany = [[Company alloc] initWithCompanyName:name orderNum:newCompnayOrderNum imageName:imageName stockSymbol:stockSymbol];
    
    [self.companyList addObject:newCompany];
    
     NSLog(@"New company created");
    
    [newCompany release];
    return newCompany;
}

- (Product *)createNewProductWithName:(NSString*)name image:(NSString *)imageName url:(NSString*)url forCompany:(Company *)company {
    
    NSNumber * newProductOrderNum = @([self.largestProductOrderNum floatValue] + 1);
    
    ProductManagedObject * newManagedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.context];
    [ProductManagedObject create:newManagedProduct withManagedProductName:name orderNum: newProductOrderNum imageName:imageName url:url];

    //fetch matching nsmanagedCompany and put in array
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Company"
                                              inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"companyOrderNum = %@", company.companyOrderNum];
    [request setPredicate:predicate];
    NSError * error;
    NSArray * array = [self.context executeFetchRequest:request error:&error];
    
    //add newManagedProduct to matching nsmanagedCompany
    NSMutableSet * newCompanyProducts = [array[0] mutableSetValueForKey:@"products"];
    [newCompanyProducts addObject:newManagedProduct];
    
    Product * newProduct = [[Product alloc]initWithProductName:name orderNum:newProductOrderNum imageName:imageName url:url];
    [company.productArray addObject:newProduct];
    
     NSLog(@"New product created");
    [newProduct release];
    return newProduct;
}

- (Company *)editcompany:(Company *)company withName:(NSString *)name imageName:(NSString *)imageName stockSymbol:(NSString *)stockSymbol {
    
    company.companyName = name;
    company.companyImageName = imageName;
    company.companyStockSymbol = stockSymbol;
    
    //fetch matching nsmanagedCompany and put in array
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Company"
                                               inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"companyOrderNum = %@", company.companyOrderNum];
    [request setPredicate:predicate];
    NSError * error;
    NSArray * array = [self.context executeFetchRequest:request error:&error];
    
    //update nsmanagedCompany
    CompanyManagedObject * managedCompany = array[0];
    managedCompany.companyName = name;
    managedCompany.companyImageName = imageName;
    managedCompany.companyStockSymbol = stockSymbol;

    NSLog(@"Company updated");
    
    return company;
}

- (Product *)editProduct:(Product *)product withName:(NSString *)name imageName:(NSString *)imageName website:(NSString *)website {
    
    product.productName = name;
    product.productImageName = imageName;
    product.productUrl = website;

    //fetch matching nsmanagedProduct and put in array
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Product"
                                               inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"productOrderNum = %@", product.productOrderNum];
    [request setPredicate:predicate];
    NSError * error;
    NSArray * array = [self.context executeFetchRequest:request error:&error];
    
    //update nsmanagedProduct
    ProductManagedObject * managedProduct = array[0];
    managedProduct.productName = name;
    managedProduct.productImageName = imageName;
    managedProduct.productUrl = website;
    
    NSLog(@"Product updated");
    
    return product;
}

- (void)deleteCompanyAndItsProducts:(Company *)company {
    
    //fetch matching nsmanagedCompany and put in array
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Company"
                                               inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"companyOrderNum = %@", company.companyOrderNum];
    [request setPredicate:predicate];
    NSError * error;
    NSArray * array = [self.context executeFetchRequest:request error:&error];

    [self.context deleteObject:array[0]];
    
    [self.companyList removeObject:company];
    company = nil;

    NSLog(@"Company Deleted");
}

- (void)deleteProduct:(Product *)product forCompany:(Company *)company {
    
    //fetch matching nsmanagedProduct and put in array
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Product"
                                               inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"productOrderNum = %@", product.productOrderNum];
    [request setPredicate:predicate];
    NSError * error;
    NSArray * array = [self.context executeFetchRequest:request error:&error];
    
    [self.context deleteObject:array[0]];
    
    [company.productArray removeObject:product];
    
    product = nil;
    
    NSLog(@"Product Deleted");
}

- (void)moveCompanies {
   
    //fetch all nsmanagedCompanies and put in array
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Company"
                                               inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"companyOrderNum > -1"];
    [request setPredicate:predicate];
    NSError * error;
    NSArray * array = [self.context executeFetchRequest:request error:&error];
    
    //update nsmanagedCompanies
    for (CompanyManagedObject * managedCompany in array) {
        for (Company * company in self.companyList) {
            if ([managedCompany.companyName isEqualToString:company.companyName]) {
                managedCompany.companyOrderNum = company.companyOrderNum;
            }
        }
    }

    NSLog(@"Company Moved");
}

- (void)moveProductsForCompany:(Company *)company {
    
    //fetch all nsmanagedProducts and put in array
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Product"
                                               inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"productOrderNum > -1"];
    [request setPredicate:predicate];
    NSError * error;
    NSArray * array = [self.context executeFetchRequest:request error:&error];
    
    //update nsmanagedProduccts
    for (ProductManagedObject * managedProduct in array) {
        for (Product * product in company.productArray) {
            if ([managedProduct.productName isEqualToString:product.productName]) {
                managedProduct.productOrderNum = product.productOrderNum;
            }
        }
    }

    NSLog(@"Product Moved");
}

- (void)reloadCompanyDataFromContext {
    
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    
    //sort by companyOrderNum
    NSSortDescriptor * companySortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"companyOrderNum" ascending:YES];
    
    NSArray * sortDescriptors = [[NSArray alloc] initWithObjects:companySortDescriptor, nil];
    
    [request setSortDescriptors:sortDescriptors];
    
    NSEntityDescription * company = [[self.model entitiesByName] objectForKey:@"Company"];
    [request setEntity:company];
    
    NSError * error = nil;
    
    //This gets data only from context, not from store
    NSArray * result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    //need to convert managed objects to nsobjects then fill array
    
    [self.companyList removeAllObjects];
    
    for (CompanyManagedObject * managedCompany in result) {
        Company * newCompany = [[Company alloc]init];
        newCompany.companyName = managedCompany.companyName;
        newCompany.companyImageName = managedCompany.companyImageName;
        newCompany.companyOrderNum = managedCompany.companyOrderNum;
        newCompany.companyStockSymbol = managedCompany.companyStockSymbol;
        [self.companyList addObject:newCompany];
    }
}

- (void)reloadProductDataFromContextForCompany:(Company *)company {
    
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    
    //sort by productOrderNum
    NSSortDescriptor * productSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"productOrderNum" ascending:YES];
    
    NSArray * sortDescriptors = [[NSArray alloc] initWithObjects:productSortDescriptor, nil];
    
    [request setSortDescriptors:sortDescriptors];
    
    NSEntityDescription * product = [[self.model entitiesByName] objectForKey:@"Product"];
    [request setEntity:product];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"company.companyName = %@", company.companyName];
    [request setPredicate:predicate];
    
    NSError * error = nil;
    
    //This gets data only from context, not from store
    NSArray * result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    company.productArray = [[NSMutableArray alloc]initWithArray:result];
}

- (void)dealloc {
    [super dealloc];
}

@end
