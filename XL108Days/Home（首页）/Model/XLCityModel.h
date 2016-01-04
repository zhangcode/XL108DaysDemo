//
//  XLCityModel.h
//  XL108Days
//
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLCityModel : UITextField
/*
 城市id
 **/
@property (nonatomic, strong) NSNumber *ID;
/*
 城市中文
 **/
@property (nonatomic, strong) NSString *name;
/*
 城市拼音
 **/
@property (nonatomic, strong) NSString *city;

//- (instancetype)initWithDict:(NSDictionary *)dict;
//+ (instancetype)cityWithDict:(NSDictionary *)dict;

@end
