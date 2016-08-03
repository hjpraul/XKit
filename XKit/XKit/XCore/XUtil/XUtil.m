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

+ (NSString *)systemName {
    return [[UIDevice currentDevice] systemName];
}

+ (BOOL)isIOS8Above {
    return ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8);
}

+ (BOOL)isIOS9Above {
    return ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 9);
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

@end
