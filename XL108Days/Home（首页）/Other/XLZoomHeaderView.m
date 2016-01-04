//
//  XLZoomHeaderView.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/8.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLZoomHeaderView.h"

static UIView *_headerView;
static CGFloat headerViewWidth;
static CGFloat headerViewHeight;

@implementation XLZoomHeaderView


+ (void)customZoomHeaderViewWithTableView:(UITableView *)tableView HeaderView:(UIView *)headerView {
    
    _headerView = headerView;
    headerViewWidth = _headerView.frame.size.width;
    headerViewHeight = _headerView.frame.size.height;
    UIView *emptyHeadView = [[UIView alloc] initWithFrame:_headerView.frame];
    tableView.tableHeaderView = emptyHeadView;
}

+ (void)updateHeaderViewFrameWithScrollView:(UIScrollView *)scrollView {

    CGFloat yOffset = scrollView.contentOffset.y;

    if (scrollView.contentOffset.y < 0) {
        
        CGFloat factor = ((ABS(yOffset) + headerViewHeight) * headerViewWidth) / headerViewHeight;
        CGRect frame = CGRectMake(-(factor - headerViewWidth) / 2, 0, factor, headerViewHeight + ABS(yOffset));
        _headerView.frame = frame;
    }else {
       
        CGRect frame = _headerView.frame;
        frame.origin.y = -yOffset;
        _headerView.frame = frame;
    }
}
@end
