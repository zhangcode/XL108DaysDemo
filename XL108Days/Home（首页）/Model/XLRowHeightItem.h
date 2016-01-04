//
//  XLRowHeightItem.h
//  XL108Days
//
//  Created by Shelin on 16/1/4.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLDetailItem.h"

@interface XLRowHeightItem : NSObject

@property (nonatomic, assign, readonly) CGRect titleF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) XLDetailItem *detailItem;


@end
