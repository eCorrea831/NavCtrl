//
//  SqliteDB.h
//  NavCtrl
//
//  Created by Erica Correa on 4/25/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteDB : NSObject 

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
- (NSArray *)loadDataFromDB:(NSString *)query;
- (void)executeQuery:(NSString *)query;

@end
