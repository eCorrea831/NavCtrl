//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Erica Correa on 4/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"

@implementation DataAccessObject

+ (void)createData {
    
    
    ProductClass *iPad = [[ProductClass alloc]initWithProductName:@"iPad" productPicture: [UIImage imageNamed:@"iPad"] andProductUrl:@"http://www.apple.com/ipad/"];
    ProductClass *iPodTouch = [[ProductClass alloc]initWithProductName:@"iPod Touch" productPicture: [UIImage imageNamed:@"iPod Touch"] andProductUrl:@"http://www.apple.com/ipod/"];
    ProductClass *iPhone = [[ProductClass alloc]initWithProductName:@"iPhone" productPicture: [UIImage imageNamed:@"iPhone"] andProductUrl:@"http://www.apple.com/iphone/"];
    CompanyClass *apple = [[CompanyClass alloc]initWithCompanyName:@"Apple mobile devices" companyPicture:[UIImage imageNamed:@"Apple Mobile Devices"] andProductArray:@[iPad, iPodTouch, iPhone]];
    
    ProductClass *galaxyS4 = [[ProductClass alloc]initWithProductName:@"Galaxy S4" productPicture: [UIImage imageNamed:@"Galaxy S4"] andProductUrl:@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZKPVZW"];
    ProductClass *galaxyNote = [[ProductClass alloc]initWithProductName:@"Galaxy Note" productPicture: [UIImage imageNamed:@"Galaxy Note"] andProductUrl:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-"];
    ProductClass *galaxyTab = [[ProductClass alloc]initWithProductName:@"Galaxy Tab" productPicture: [UIImage imageNamed:@"Galaxy Tab"] andProductUrl:@"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-"];
    CompanyClass *samsung = [[CompanyClass alloc]initWithCompanyName:@"Samsung mobile devices" companyPicture:[UIImage imageNamed:@"Samsung Mobile Devices"] andProductArray:@[galaxyS4, galaxyNote, galaxyTab]];
    
    ProductClass *androidWear = [[ProductClass alloc]initWithProductName:@"Android Wear" productPicture:[UIImage imageNamed:@"Android Wear"] andProductUrl:@"https://www.android.com/wear/"];
    ProductClass *androidTablet = [[ProductClass alloc]initWithProductName:@"Android Tablet" productPicture:[UIImage imageNamed:@"Android Tablet"] andProductUrl:@"https://www.android.com/tablets/"];
    ProductClass *androidPhone = [[ProductClass alloc]initWithProductName:@"Android Phone" productPicture:[UIImage imageNamed:@"Android Phone"] andProductUrl:@"https://www.android.com/phones/"];
    CompanyClass *google = [[CompanyClass alloc]initWithCompanyName:@"Google mobile devices" companyPicture:[UIImage imageNamed:@"Google Mobile Devices"] andProductArray:@[androidWear, androidTablet, androidPhone]];
    
    ProductClass *huaweiMate = [[ProductClass alloc]initWithProductName:@"Huawei Mate" productPicture:[UIImage imageNamed:@"Huawei Mate"] andProductUrl:@"http://consumer.huawei.com/minisite/worldwide/mate8/"];
    ProductClass *huaweiMateBook = [[ProductClass alloc]initWithProductName:@"Huawei MateBook" productPicture:[UIImage imageNamed:@"Huawei Matebook"] andProductUrl:@"http://consumer.huawei.com/minisite/worldwide/matebook/screen.htm"];
    ProductClass *huaweiTalkBand = [[ProductClass alloc]initWithProductName:@"Huawei TalkBand" productPicture:[UIImage imageNamed:@"Huawei Talkband"] andProductUrl:@"http://consumer.huawei.com/en/wearables/talkband-b3/"];
    CompanyClass *huawei = [[CompanyClass alloc]initWithCompanyName:@"Huawei mobile devices" companyPicture:[UIImage imageNamed:@"Huawei Mobile Devices"] andProductArray:@[huaweiMate, huaweiMateBook, huaweiTalkBand]];

    self.companyList = [NSMutableArray arrayWithObjects:apple, samsung, google, huawei, nil];
}

@end
