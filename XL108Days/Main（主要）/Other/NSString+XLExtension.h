//
//  NSString+XLExtension.h
//  XL108Days
//
//  Created by Shelin on 16/1/4.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XLExtension)
/**
 *  计算字符串尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
