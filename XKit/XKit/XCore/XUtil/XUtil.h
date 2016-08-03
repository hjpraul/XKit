//
//  Util.h
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XUtil : NSObject
// 目录相关快捷方式
+ (NSString *)appPath;          // 程序目录，不能存任何东西
+ (NSString *)docPath;          // 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)cachePath;        // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tempPath;         // 临时目录，APP退出后，系统可能会删除这里的内容

// 客户端相关参数快捷方式
+ (NSString *)appVersion;
+ (NSString *)appBuild;
+ (NSString *)appName;
+ (NSString *)appBundleID;
+ (id)objectOfInfoPlistForKey:(NSString *)key;   // 获取info.plist中对应字段

// 设备相关信息
+ (NSString *)systemVersion;
+ (NSString *)systemName;
+ (BOOL)isIOS8Above;
+ (BOOL)isIOS9Above;

// Bundle相关（路径）
+ (NSString *)pngPathOfName:(NSString *)name;
+ (NSString *)jpgPathOfName:(NSString *)name;
+ (NSString *)bundleFilePathOfName:(NSString *)name
                               ext:(NSString *)extension;

// 坐标相关
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

@end
