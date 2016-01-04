//
//  XLTabBarController.h
//  XL108Days
//
//  Created by Shelin on 15/11/26.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const XLTabBarItemTitle = @"tabBarItemTitle";
static NSString *const XLTabBarItemNormalImage = @"tabBarItemNormalImage";
static NSString *const XLTabBarItemSelectedImage = @"tabBarItemSelectedImage";
static NSString *const XLTabBarItemNormalTitleColor = @"tabBarItemNormalTitleColor";
static NSString *const XLTabBarItemSelectedTitleColor = @"tabBarItemSelectedTitleColor";

@interface XLTabBarController : UITabBarController

@property (nonatomic, strong) NSArray *childViewControllers;

@property (nonatomic, strong) NSArray *tabBarItemsAttributes;

@end
