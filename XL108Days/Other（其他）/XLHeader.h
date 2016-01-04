//
//  XLHeader.h
//  XL108Days
//
//  Created by Shelin on 16/1/4.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#ifndef XLHeader_h
#define XLHeader_h

#import "UIBarButtonItem+Extension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "XLDataService.h"
#import "XLNetworkRequest.h"
#import "PureLayout.h"
#import "XLCitySingleton.h"
#import "XLGifHeader.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"

/*
 日志输出
 **/
#ifdef DEBUG
#define XLLog(...) NSLog(__VA_ARGS__)
#else
#define XLLog(...)
#endif

/*
 物理屏幕宽高
 **/
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
/*
 物理屏幕宽高比例
 **/
#define kWideHighPercentage kScreenWidth / kScreenHeight

#define kImageHeight 150
#define kImageWidth kScreenWidth

#define kNavigationAndStatusBarHeight 64.0f
#define kTabBarHeight 49.0f

//主题颜色
#define ThemeColor [UIColor colorWithRed:0.00f green:0.80f blue:0.75f alpha:1.00f]

/*
 判断设备是否是模拟器
 **/
#define isIphoneSimulator TARGET_IPHONE_SIMULATOR

#define IMAGE_HEAD_URL @"https://spic-108tian-com.alikunlun.com/pic/"
/*
 城市单例
 **/
#define citySingleton  [XLCitySingleton shareCitySingle]
/*
 城市列表
 **/
#define CITYLIST_URL @"https://api.108tian.com/mobile/v3/Home?cityId=1&page=0"
/*
 首页列表
 **/
#define HOME_TABLE_URL(ID) [NSString stringWithFormat:@"https://api.108tian.com/mobile/v3/RecommendDetailList?cityId=%@&step=2&page=",ID]
/*
 首页轮播图片
 **/
#define AD_IMAGE_URL(ID) [NSString stringWithFormat:@"https://api.108tian.com/mobile/v3/Home?cityId=%@&page=0",ID]
/*
 往期回顾
 **/
#define PAST_REVIEW_URL(ID) [NSString stringWithFormat:@"https://api.108tian.com/mobile/v3/RecommendDetailList?cityId=%@&sid=3833d6a3cbb43f0ce0a5a47c5fc8864a361dab28&step=10&page=",ID]
/*
 当季主题图标
 **/
#define CURRENT_SUBJECT_URL @"https://api.108tian.com/mobile/v3/ThemeItems?type=scene"

/*
 APP_KEY
 **/
#define APP_KEY @"56728170e0f55a7c70001293"



#endif /* XLHeader_h */
