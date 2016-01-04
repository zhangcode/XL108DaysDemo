//
//  XLLocationTool.h
//  XL108Days
//
//  Created by Shelin on 15/12/7.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLLocationTool : NSObject

/*
 检查定位服务是否可用
 **/
+ (BOOL)isOpenTheLocationService;

/*
 根据经纬度获取与用户的距离
 **/
+ (CGFloat)distanceWithLatitude:(NSString *)latitude  andLongitude:(NSString *)longitude;

@end
