//
//  XLGetPastReviewCollData.m
//  XL108Days
//
//  Created by Shelin on 15/12/9.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLGetPastReviewCollData.h"
#import "XLPastReviewItem.h"

@implementation XLGetPastReviewCollData
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass {
    
    NSMutableArray *array = [NSMutableArray array];
    NSArray *list = responseObj[@"data"][@"list"];
    for (NSDictionary *listDict in list) {
        NSArray *items = listDict[@"items"];
        for (NSDictionary *itemDict in items) {
            
            [XLPastReviewItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"ID" : @"recommend.id",
                         };
            }];
            XLPastReviewItem *item = [XLPastReviewItem mj_objectWithKeyValues:itemDict];
            [array addObject:item];
        }
    }
    return array;
}

@end
