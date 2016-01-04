//
//  NSString+XLExtension.m
//  XL108Days
//
//  Created by Shelin on 16/1/4.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "NSString+XLExtension.h"

@implementation NSString (XLExtension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
