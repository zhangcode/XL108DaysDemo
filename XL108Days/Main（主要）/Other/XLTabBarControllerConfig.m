//
//  XLTabBarControllerConfig.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/3.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLTabBarControllerConfig.h"
#import "XLHomeViewController.h"
#import "XLDiscoverViewController.h"
#import "XLActivityViewController.h"
#import "XLMineViewController.h"
#import "XLNavigationController.h"


@implementation XLTabBarControllerConfig

- (XLTabBarController *)tabBarController {
    
    if (!_tabBarController) {
        XLHomeViewController *hvc = [[XLHomeViewController alloc] init];
        hvc.title = @"首页";
        XLNavigationController *nav1 = [[XLNavigationController alloc] initWithRootViewController:hvc];
        
        XLDiscoverViewController *dvc = [[XLDiscoverViewController alloc] init];
        dvc.title = @"发现";
        XLNavigationController *nav2 = [[XLNavigationController alloc] initWithRootViewController:dvc];
        
        XLActivityViewController *avc = [[XLActivityViewController alloc] init];
        avc.title = @"活动";
        XLNavigationController *nav3 = [[XLNavigationController alloc] initWithRootViewController:avc];
        
        XLMineViewController *mvc = [[XLMineViewController alloc] init];
//        XLMineViewController *mvc = [[NSBundle mainBundle] loadNibNamed:@"XLMineViewController" owner:nil options:nil].lastObject;
        XLNavigationController *nav4 = [[XLNavigationController alloc] initWithRootViewController:mvc];
        nav4.navigationBar.hidden = YES;
        
        XLTabBarController *tbc = [[XLTabBarController alloc] init];
        
        NSDictionary *dict1 = @{
                                XLTabBarItemTitle : @"首页",
                                XLTabBarItemNormalImage : @"home",
                                XLTabBarItemSelectedImage : @"home_h",
                                };
        
        NSDictionary *dict2 = @{
                                XLTabBarItemTitle : @"发现",
                                XLTabBarItemNormalImage : @"choiceness",
                                XLTabBarItemSelectedImage : @"choiceness_h",
                                };
        
        NSDictionary *dict3 = @{
                                XLTabBarItemTitle : @"活动",
                                XLTabBarItemNormalImage : @"active",
                                XLTabBarItemSelectedImage : @"active_h",
                                };
        
        NSDictionary *dict4 = @{
                                XLTabBarItemTitle : @"我的",
                                XLTabBarItemNormalImage : @"mine",
                                XLTabBarItemSelectedImage : @"mine_h"
                                };
        
        NSArray *tabBarItemsAttributes = @[dict1, dict2, dict3, dict4];
        tbc.tabBarItemsAttributes = tabBarItemsAttributes;
        tbc.childViewControllers = @[nav1, nav2, nav3, nav4];
        _tabBarController = tbc;
    }
    return _tabBarController;
}

@end
