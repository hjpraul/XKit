//
//  Util.m
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XUtil.h"
#import <UIKit/UIKit.h>

@implementation XUtil
// 目录快捷方式
+ (NSString *)x_appPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

+ (NSString *)x_docPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

+ (NSString *)x_cachePath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

+ (NSString *)x_tempPath{
    NSString *path = NSTemporaryDirectory();
    return path;
}

// 客户端相关参数快捷方式
+ (NSString *)x_appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)x_appBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)x_appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)x_appBundleID {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+ (id)x_objectOfInfoForKey:(NSString *)key {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
}

// 设备信息相关
+ (NSString *)x_systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)x_systemName {
    return [[UIDevice currentDevice] systemName];
}

+ (BOOL)x_isIOS8Above {
    return ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8);
}

+ (BOOL)x_isIOS9Above {
    return ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 9);
}

// Bundle相关（路径）
+ (NSString *)x_pngPathOfName:(NSString *)name {
    return [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
}

+ (NSString *)x_jpgPathOfName:(NSString *)name {
    return [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
}

+ (NSString *)x_bundleFilePathOfName:(NSString *)name
                               ext:(NSString *)extension {
    return [[NSBundle mainBundle] pathForResource:name ofType:extension];
}

// 坐标相关
+ (CGFloat)x_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)x_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

@end
