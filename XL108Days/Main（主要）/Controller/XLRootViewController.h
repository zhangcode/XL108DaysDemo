//
//  XLRootViewController.h
//  XL108Days
//
//  Created by Shelin on 15/11/26.
//  Copyright © 2015年 GreatGate. All rights reserved.
//  根控制器

#import <UIKit/UIKit.h>

@interface XLRootViewController : UIViewController

/*
 是否设置过约束
 **/
@property (nonatomic, assign) BOOL didSetupConstraints;

/*
 当前城市id，判断是否切换城市
 **/
@property (nonatomic, strong) NSString *currentCityId;;


@end
