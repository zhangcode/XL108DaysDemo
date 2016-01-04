//
//  XLAdImageTool.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLAdImageTool.h"

static NSInteger _currentIndex;
static NSArray *_imageArray;

@implementation XLAdImageTool

/**
 *  加载图片
 *
 *  @param currentIndex 当前图片在数组中的索引号
 *  @param imageArray   存放图片url数组
 *  @param scrollView   添加图片的scrollView
 */
+ (void)loadImageViewWithImageArray:(NSArray *)imageArray andScrollView:(UIScrollView *)scrollView
{
    if (!imageArray) return;
    
    _imageArray = imageArray;
    //当前页面
    UIImageView *curretImageView = [[UIImageView alloc] init];
    NSString *curretImageUrl = _imageArray[_currentIndex];
    [curretImageView sd_setImageWithURL:[NSURL URLWithString:curretImageUrl]];
    curretImageView.frame = CGRectMake(kImageWidth, 0, kImageWidth, kImageHeight);
    [scrollView addSubview:curretImageView];
    
    //左侧页面（当前显示的图片为第一张时，左侧图片应该显示最后一张图片）
    UIImageView *preImageView = [[UIImageView alloc] init];
    NSString *preImageUrl = _currentIndex == 0 ? _imageArray.lastObject : _imageArray[_currentIndex - 1];
    [preImageView sd_setImageWithURL:[NSURL URLWithString:preImageUrl]];
    preImageView.frame = CGRectMake(0, 0, kImageWidth, kImageHeight);
    [scrollView addSubview:preImageView];
    
    //右侧页面（当前显示的图片为最后一张时，右侧图片应该显示第一张图片）
    UIImageView *nextImageView = [[UIImageView alloc] init];
    NSString *nextImageUrl = _currentIndex == _imageArray.count - 1 ? imageArray[0] : _imageArray[_currentIndex + 1];
    [nextImageView sd_setImageWithURL:[NSURL URLWithString:nextImageUrl]];
    nextImageView.frame = CGRectMake(kImageWidth * 2, 0, kImageWidth, kImageHeight);
    [scrollView addSubview:nextImageView];
    //保证显示的图片总是中间的ImageView
    scrollView.contentOffset = CGPointMake(kImageWidth, 0);
}

+ (void)changeImageViewWithScrollView:(UIScrollView *)scrollView pageControl:(UIPageControl *)pageControl {
    
    //移动结束后调用此方法，销毁原来3个ImageView，重新创建3个新的ImageView，并更换图片
    for (UIView *view in scrollView.subviews) {
        [view removeFromSuperview];
    }
    int index = scrollView.contentOffset.x / kScreenWidth;
    if (index == 0) {
        //图片向右移
        _currentIndex = _currentIndex == 0 ? _imageArray.count - 1 : _currentIndex - 1;
        [XLAdImageTool loadImageViewWithImageArray:_imageArray andScrollView:scrollView];
    }
    if (index == 2) {
        //图片向左移
        _currentIndex = _currentIndex == _imageArray.count - 1 ? 0 : _currentIndex + 1;
        [XLAdImageTool loadImageViewWithImageArray:_imageArray andScrollView:scrollView];
    }
    pageControl.currentPage = _currentIndex;
    
}

@end
