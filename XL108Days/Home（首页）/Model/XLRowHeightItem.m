//
//  XLRowHeightItem.m
//  XL108Days
//
//  Created by Shelin on 16/1/4.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "XLRowHeightItem.h"
#import <UIKit/UIKit.h>
#import "NSString+XLExtension.h"

@implementation XLRowHeightItem

- (void)setDetailItem:(XLDetailItem *)detailItem {
    _detailItem = detailItem;

    NSRange range = [detailItem.detailStr rangeOfString:@"http"];
    if (range.length) {
        _cellHeight = 200;
    }else {

        CGSize textSize = [detailItem.detailStr sizeWithFont:[UIFont systemFontOfSize:15.0] maxSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT)];
        _cellHeight = textSize.height + 20;
        
    }
    
}

@end
