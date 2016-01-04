//
//  XLAdImageTool.h
//  XL108Days
//
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLAdImageTool : NSObject

/**
 *  加载轮播图片
 */
+ (void)loadImageViewWithImageArray:(NSArray *)imageArray andScrollView:(UIScrollView *)scrollView;

/**
 *  更换轮播图片
 */
+ (void)changeImageViewWithScrollView:(UIScrollView *)scrollView pageControl:(UIPageControl *)pageControl;

@end
