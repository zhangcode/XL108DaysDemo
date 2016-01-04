//
//  XLGetTableViewData.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLGetTableViewData.h"
#import "XLGroupItem.h"
#import "XLCellItem.h"
#import "XLDataBase.h"

@implementation XLGetTableViewData
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass {
//    XLLog(@"网络请求数据");
    NSArray *listArray = responseObj[@"data"][@"list"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *itemDict in listArray) {
    
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
        
        XLGroupItem *groupItem = [XLGroupItem mj_objectWithKeyValues:itemDict];
        [array addObject:groupItem];
        
        //先判断数据是否存储过，如果没有，网络请求新数据存入数据库
        
        if (![XLDataBase isExistWithId:itemDict[@"id"]]) {
            //存数据库
//            NSLog(@"存入数据库");
            [XLDataBase saveItemDict:itemDict];
        }
    }
    return array;
}

@end
