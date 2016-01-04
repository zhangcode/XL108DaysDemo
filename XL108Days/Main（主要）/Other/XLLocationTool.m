//
//  XLLocationTool.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/7.
//  Copyright © 2015年 GreatGate. All rights reserved.
//  处理定位相关

#import "XLLocationTool.h"
#import <CoreLocation/CoreLocation.h>

@interface XLLocationTool () <CLLocationManagerDelegate>


@end

static CLLocationManager *_locationManger;
@implementation XLLocationTool

+ (BOOL)isOpenTheLocationService {
    
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
            _locationManger = [[CLLocationManager alloc] init];
//            _locationManger.delegate = self;
            [_locationManger startUpdatingLocation];
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        NSLog(@"定位功能不可用，提示用户或忽略");
    }
    return YES;
}

+ (CGFloat)distanceWithLatitude:(NSString *)latitude andLongitude:(NSString *)longitude {
    return 1.0;
}

+ (double)distanceBetweenOrderBy:(double)lat1 :(double)lng1 :(double)lat2 :(double)lng2 {
    
    double dd = M_PI / 180;
    double x1 = lat1 * dd,x2 = lat2 * dd;
    double y1 = lng1 * dd,y2 = lng2 * dd;
    double R = 6371004;
    double distance = (2  *R * asin(sqrt(2-2 * cos(x1) * cos(x2) * cos(y1-y2) - 2 * sin(x1) * sin(x2)) / 2));
    //km  返回
    return  distance * 1000;
}

@end
