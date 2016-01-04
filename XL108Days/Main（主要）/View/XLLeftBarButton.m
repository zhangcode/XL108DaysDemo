//
//  XLLeftBarButton.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/2.
//  Copyright © 2015年 GreatGate. All rights reserved.
//  首页导航栏左侧城市按钮

#import "XLLeftBarButton.h"

#import "XLCitySingleton.h"
//按钮内部图片和文字距离
#define Magin 5;

@implementation XLLeftBarButton

+ (instancetype)leftBarButton {
    
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //高亮状态下图片不自动调整
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        //self.titleLabel.backgroundColor = [UIColor redColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //按钮图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

/**
 返回按钮内部图片位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageH = self.frame.size.height;
    CGFloat imageW = 8;
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    CGSize textSize = [citySingleton.cityName sizeWithAttributes:attrDict];
    CGFloat imageX = textSize.width + Magin;
    return CGRectMake(imageX, imageY, imageW, imageH);
}


/**
 返回按钮内部文字位置
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = self.frame.size.height;
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    CGSize textSize = [citySingleton.cityName sizeWithAttributes:attrDict];

    CGFloat titleW = textSize.width;
    return CGRectMake(titleX, titleY, titleW, titleH);
}




@end
