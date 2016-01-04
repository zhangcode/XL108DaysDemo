//
//  XLTabBarController.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/11/26.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLTabBarController.h"
#import "XLRootViewController.h"
#import "XLNavigationController.h"

@interface XLTabBarController ()

@end

@implementation XLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置tabBar的风格
    [self customizeTabBarAppearance];
}

- (void)setChildViewControllers:(NSArray *)childViewControllers {
    
    if (_childViewControllers && _childViewControllers.count) {
        
        for (UIViewController *viewController in _childViewControllers) {
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    if (childViewControllers && [childViewControllers isKindOfClass:[NSArray class]]) {
        
        _childViewControllers = childViewControllers;
        
        if (!_tabBarItemsAttributes) {
            NSLog(@"请先设置tabBarItemsAttributes，再添加childViewControllers！");
            return;
        }
        NSInteger index = 0;
        for (UIViewController *viewController in childViewControllers) {
            
            NSString *title = _tabBarItemsAttributes[index][XLTabBarItemTitle];
            NSString *normalImageName = _tabBarItemsAttributes[index][XLTabBarItemNormalImage];
            NSString *selectedImageName = _tabBarItemsAttributes[index][XLTabBarItemSelectedImage];
            
            [self addChildViewController:viewController WithTitle:title normalImageName:normalImageName selectedImageName:selectedImageName];
            index ++;
        }
    }
}

- (void)addChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName {
    
    viewController.tabBarItem.title = title;
    
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    //图片渲染模式设置为始终展现原始图片效果
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = normalImage;
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectedImage;
    
    [self addChildViewController:viewController];
}


- (void)customizeTabBarAppearance {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = ThemeColor;
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


@end
