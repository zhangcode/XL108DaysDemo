//
//  UIBarButtonItem+Extension.h
//  XL108Days
//
//  Created by Shelin on 15/12/2.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)barButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title imageName:(NSString *)imageName;
@end
