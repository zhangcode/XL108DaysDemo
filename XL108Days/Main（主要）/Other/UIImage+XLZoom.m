//
//  UIImage+XLZoom.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "UIImage+XLZoom.h"

@implementation UIImage (XLZoom)

+ (UIImage *)resizableImage:(NSString *)imageName;
{
    UIImage *normal = [UIImage imageNamed:imageName];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

+ (UIImage *)resizedImageName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

@end
