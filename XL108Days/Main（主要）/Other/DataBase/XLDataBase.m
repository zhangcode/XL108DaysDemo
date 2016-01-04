//
//  XLDataBase.m
//  XLNetwork
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/11/18.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLDataBase.h"
#import "FMDatabase.h"
#import "XLGroupItem.h"
#import "XLCellItem.h"

@implementation XLDataBase

static FMDatabase *_db;

+ (void)initialize {
    
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/TourList.db",NSHomeDirectory()];
    
    _db = [FMDatabase databaseWithPath:path];
    
    [_db open];
    //存储首页cell的表格
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_item (id integer PRIMARY KEY, itemDict blob NOT NULL, idStr text NOT NULL)"];
    //存储图片url的表格
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_images (id integer PRIMARY KEY, imageArray blob NOT NULL)"];
}

+ (void)saveImagesWith:(NSArray *)imageArray {
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:imageArray];
    [_db executeUpdateWithFormat:@"INSERT INTO t_images (imageArray) VALUES (%@)",dictData];
}

+ (NSArray *)fetchImagesFromDataBase {
    
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_images"];
    NSMutableArray *images = [NSMutableArray array];
    
    while (set.next) {
        // 获得当前所指向的数据
        
        NSData *arrayData = [set objectForColumnName:@"itemDict"];
        images = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
      }
    return images;
}

+ (void)saveItemDict:(NSDictionary *)itemDict {
    
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:itemDict];
    [_db executeUpdateWithFormat:@"INSERT INTO t_item (itemDict, idStr) VALUES (%@, %@)",dictData, itemDict[@"id"]];
}

+ (void)deleteList {
    
    [_db executeUpdate:@"DELETE FROM t_item"];
}

+ (NSArray *)listWithRange:(NSRange)range {
    
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM t_item LIMIT %lu, %lu",range.location, range.length];
    FMResultSet *set = [_db executeQuery:SQL];
    NSMutableArray *list = [NSMutableArray array];
    
    while (set.next) {
        // 获得当前所指向的数据
        
        NSData *dictData = [set objectForColumnName:@"itemDict"];
        
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        [XLGroupItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"items" : @"XLCellItem",
                     };
        }];
        
        [XLCellItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"fav" : @"recommend.fav",
                     @"ID" : @"recommend.id",
                     @"price" : @"recommend.price",
                     @"lnglat" : @"recommend.lnglat",
                     };
        }];
        
        XLGroupItem *groupItem = [XLGroupItem mj_objectWithKeyValues:dict];
        [list addObject:groupItem];
    }
    return list;
}

+ (BOOL)isExistWithId:(NSString *)idStr
{
    BOOL isExist = NO;
    
    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM t_item WHERE idStr = ?",idStr];
    while ([resultSet next]) {
        if([resultSet stringForColumn:@"idStr"]) {
            isExist = YES;
        }else{
            isExist = NO;
        }
    }
    return isExist;
}



@end
