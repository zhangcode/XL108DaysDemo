//
//  AppDelegate.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/11/26.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "AppDelegate.h"
#import "XLTabBarController.h"
#import "XLTabBarControllerConfig.h"
#import "XLRootViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self uMengShared];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    if (isIphoneSimulator) {
        [self fetchCurrentCityId];
    }else {//获取用户地理位置
        
        [self fetchCurrentCityId];
    }
    //判断是否第一次进入程序，选择根控制器
    
    [self initializeTabBar];
    return YES;
}

//取出当前城市id
- (void)fetchCurrentCityId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cityId = [defaults stringForKey:@"cityId"];
    if (!cityId) {//默认城市为北京
        [defaults setObject:@"1" forKey:@"cityId"];
        [defaults setObject:@"北京" forKey:@"cityName"];
        [defaults synchronize];
        NSString *cityId = [defaults stringForKey:@"cityId"];
        NSString *cityName = [defaults stringForKey:@"cityName"];
        citySingleton.cityId = cityId;
        citySingleton.cityName = cityName;
    }else {//记录用户上一次查询的城市
        NSString *cityId = [defaults stringForKey:@"cityId"];
        NSString *cityName = [defaults stringForKey:@"cityName"];
        citySingleton.cityId = cityId;
        citySingleton.cityName = cityName;
    }
}


- (void)initializeTabBar {
    XLTabBarControllerConfig *config = [[XLTabBarControllerConfig alloc] init];
    self.window.rootViewController = config.tabBarController;
}

//友盟分享
- (void)uMengShared {
    [UMSocialData setAppKey:APP_KEY];
    
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:APP_KEY url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    // 清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


@end
