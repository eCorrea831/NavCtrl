//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"

@implementation DataAccessObject

+ (DataAccessObject*)sharedInstance {
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
    
        ProductClass *iPad = [[ProductClass alloc]initWithProductName:@"iPad" productImage: [UIImage imageNamed:@"iPad"] andProductUrl:@"http://www.apple.com/ipad/"];
        ProductClass *iPodTouch = [[ProductClass alloc]initWithProductName:@"iPod Touch" productImage: [UIImage imageNamed:@"iPod Touch"] andProductUrl:@"http://www.apple.com/ipod/"];
        ProductClass *iPhone = [[ProductClass alloc]initWithProductName:@"iPhone" productImage: [UIImage imageNamed:@"iPhone"] andProductUrl:@"http://www.apple.com/iphone/"];
        CompanyClass *apple = [[CompanyClass alloc]initWithCompanyName:@"Apple mobile devices" companyImage:[UIImage imageNamed:@"Apple Mobile Devices"] productArray:[NSMutableArray arrayWithObjects:iPad, iPodTouch, iPhone, nil] andUrlArray:[NSMutableArray arrayWithObjects:iPad.productUrl, iPodTouch.productUrl, iPhone.productUrl, nil]];
        
        ProductClass *galaxyS4 = [[ProductClass alloc]initWithProductName:@"Galaxy S4" productImage: [UIImage imageNamed:@"Galaxy S4"] andProductUrl:@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZKPVZW"];
        ProductClass *galaxyNote = [[ProductClass alloc]initWithProductName:@"Galaxy Note" productImage: [UIImage imageNamed:@"Galaxy Note"] andProductUrl:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-"];
        ProductClass *galaxyTab = [[ProductClass alloc]initWithProductName:@"Galaxy Tab" productImage: [UIImage imageNamed:@"Galaxy Tab"] andProductUrl:@"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-"];
        CompanyClass *samsung = [[CompanyClass alloc]initWithCompanyName:@"Samsung mobile devices" companyImage:[UIImage imageNamed:@"Samsung Mobile Devices"] productArray:[NSMutableArray arrayWithObjects:galaxyS4, galaxyNote, galaxyTab, nil] andUrlArray:[NSMutableArray arrayWithObjects:galaxyS4.productUrl, galaxyNote.productUrl, galaxyTab.productUrl, nil]];
        
        ProductClass *androidWear = [[ProductClass alloc]initWithProductName:@"Android Wear" productImage:[UIImage imageNamed:@"Android Wear"] andProductUrl:@"https://www.android.com/wear/"];
        ProductClass *androidTablet = [[ProductClass alloc]initWithProductName:@"Android Tablet" productImage:[UIImage imageNamed:@"Android Tablet"] andProductUrl:@"https://www.android.com/tablets/"];
        ProductClass *androidPhone = [[ProductClass alloc]initWithProductName:@"Android Phone" productImage:[UIImage imageNamed:@"Android Phone"] andProductUrl:@"https://www.android.com/phones/"];
        CompanyClass *google = [[CompanyClass alloc]initWithCompanyName:@"Google mobile devices" companyImage:[UIImage imageNamed:@"Google Mobile Devices"] productArray:[NSMutableArray arrayWithObjects:androidWear, androidTablet, androidPhone, nil] andUrlArray:[NSMutableArray arrayWithObjects:androidWear.productUrl, androidTablet.productUrl, androidPhone.productUrl, nil]];
        
        ProductClass *huaweiMate = [[ProductClass alloc]initWithProductName:@"Huawei Mate" productImage:[UIImage imageNamed:@"Huawei Mate"] andProductUrl:@"http://consumer.huawei.com/minisite/worldwide/mate8/"];
        ProductClass *huaweiMateBook = [[ProductClass alloc]initWithProductName:@"Huawei MateBook" productImage:[UIImage imageNamed:@"Huawei Matebook"] andProductUrl:@"http://consumer.huawei.com/minisite/worldwide/matebook/screen.htm"];
        ProductClass *huaweiTalkBand = [[ProductClass alloc]initWithProductName:@"Huawei TalkBand" productImage:[UIImage imageNamed:@"Huawei Talkband"] andProductUrl:@"http://consumer.huawei.com/en/wearables/talkband-b3/"];
        CompanyClass *huawei = [[CompanyClass alloc]initWithCompanyName:@"Huawei mobile devices" companyImage:[UIImage imageNamed:@"Huawei Mobile Devices"] productArray:[NSMutableArray arrayWithObjects:huaweiMate, huaweiMateBook, huaweiTalkBand, nil] andUrlArray:[NSMutableArray arrayWithObjects:huaweiMate.productUrl, huaweiMateBook.productUrl, huaweiTalkBand.productUrl, nil]];

        self.companyList = [NSMutableArray arrayWithObjects:apple, samsung, google, huawei, nil];
    }
    return self;
}

@end
