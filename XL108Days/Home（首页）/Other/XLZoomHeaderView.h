//
//  XLZoomHeaderView.h
//  XL108Days
//
//  Created by Shelin on 15/12/8.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLZoomHeaderView : NSObject

/*
 添加一个自定义头部缩放控件
 **/
+ (void)customZoomHeaderViewWithTableView:(UITableView *)tableView HeaderView:(UIView *)headerView;
/*
 更新头部控件frame
 **/
+ (void)updateHeaderViewFrameWithScrollView:(UIScrollView *)scrollView;
@end
