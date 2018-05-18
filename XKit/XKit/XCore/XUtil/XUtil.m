//
//  Util.m
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XUtil.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@implementation XUtil
// 目录快捷方式
+ (NSString *)appPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

+ (NSString *)docPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

+ (NSString *)cachePath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

+ (NSString *)tempPath{
    NSString *path = NSTemporaryDirectory();
    return path;
}

// 客户端相关参数快捷方式
+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appBundleID {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+ (id)objectOfInfoPlistForKey:(NSString *)key {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
}

// 设备信息相关
+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSInteger)systemMainVersion {
    return [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] integerValue];
}

+ (NSString *)systemName {
    return [[UIDevice currentDevice] systemName];
}

+ (BOOL)isIOS8Above {
    return ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8);
}

+ (BOOL)isIOS9Above {
    return ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 9);
}

+ (BOOL)isIOS11Above {
    return ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 11);
}

+ (CGFloat)videoMaxFactor {
    static CGFloat factor = 1.0f;
    if (factor == 1.0f) {
        AVCaptureDevice *avDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        factor = avDevice.activeFormat.videoMaxZoomFactor;
    }
    return factor;
}

// Bundle相关（路径）
+ (NSString *)pngPathOfName:(NSString *)name {
    return [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
}

+ (NSString *)jpgPathOfName:(NSString *)name {
    return [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
}

+ (NSString *)bundleFilePathOfName:(NSString *)name
                               ext:(NSString *)extension {
    return [[NSBundle mainBundle] pathForResource:name ofType:extension];
}

// 坐标相关
+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)statusBarHeight {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}

+ (CGFloat)navgationBarHeight {
    UIViewController *vc = [[UIViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    CGRect rectNav = nav.navigationBar.frame;
    return rectNav.size.height;
}

+ (CGFloat)tabBarHeight {
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    return tabBarVC.tabBar.frame.size.height;
}

// 当前最前面的vc
+ (UIViewController *)appFrontVc {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}
@end
