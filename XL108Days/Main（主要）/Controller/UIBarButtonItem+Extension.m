//
//  UIBarButtonItem+Extension.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/2.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "XLLeftBarButton.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)barButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title imageName:(NSString *)imageName {

    if (title) {
        
        XLLeftBarButton *leftBarButton = [XLLeftBarButton leftBarButton];
        [leftBarButton setTitle:title forState:UIControlStateNormal];
        [leftBarButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [leftBarButton setTitle:title forState:UIControlStateNormal];
        leftBarButton.frame = CGRectMake(0, 0, 40, 44);
        [leftBarButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        return [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
        
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    // 设置尺寸
    CGFloat btnW = btn.currentImage.size.width;
    CGFloat btnH = btn.currentImage.size.height;
    btn.frame = CGRectMake(0, 0, btnW + 10, btnH);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
@end
