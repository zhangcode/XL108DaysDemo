//
//  XLCitySingleton.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/2.
//  Copyright © 2015年 GreatGate. All rights reserved.
//  获取当前城市的单例

#import "XLCitySingleton.h"

@implementation XLCitySingleton

+ (XLCitySingleton *)shareCitySingle{
    
    static XLCitySingleton *singleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        singleton = [[self alloc] init];
    });
    
    //返回citySingleton对象
    return singleton;
}
@end
