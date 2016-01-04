//
//  UIImage+XLZoom.h
//  XL108Days
//
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XLZoom)
/*
 从中间拉伸图片
 **/
+ (UIImage *)resizableImage:(NSString *)imageName;

+ (UIImage *)resizedImageName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top;

@end
