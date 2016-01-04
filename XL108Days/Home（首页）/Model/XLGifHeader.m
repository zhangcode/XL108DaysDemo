//
//  XLGifHeader.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/7.
//  Copyright © 2015年 GreatGate. All rights reserved.
//  刷新动画头部控件

#import "XLGifHeader.h"

@implementation XLGifHeader

- (void)prepare
{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *normalImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"compass_spinner_%zd@2x", i]];
        [normalImages addObject:image];
    }
    [self setImages:normalImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"compass_spinner_%zd@2x", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
}

@end
