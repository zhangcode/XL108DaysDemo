//
//  XLCitySingleton.h
//  XL108Days
//
//  Created by Shelin on 15/12/2.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLCitySingleton : NSObject

+ (XLCitySingleton *)shareCitySingle;

/**
 城市id
 */
@property (nonatomic, strong) NSString *cityId;

/**
 城市名称
 */
@property (nonatomic, strong) NSString *cityName;

@end
