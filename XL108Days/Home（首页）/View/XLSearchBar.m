//
//  XLSearchBar.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLSearchBar.h"
#import "UIImage+XLZoom.h"

@implementation XLSearchBar

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.background = [UIImage resizableImage:@"searchbar_textfield_background@2x"];
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        leftImageView.frame = CGRectMake(0, 0, 40, 35);
        leftImageView.contentMode = UIViewContentModeCenter;
        self.leftView = leftImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //1.文字大小
        self.font = [UIFont systemFontOfSize:13];
        
        //2.右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        //3.提醒文字
        self.placeholder = @"请输入城市名称";
        
        //4.键盘右下角按钮样式
        self.returnKeyType = UIReturnKeySearch;
        //自动调整按钮是否能点击
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

@end
