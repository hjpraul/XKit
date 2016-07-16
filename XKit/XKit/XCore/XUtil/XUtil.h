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
+ (NSString *)x_appPath;          // 程序目录，不能存任何东西
+ (NSString *)x_docPath;          // 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)x_cachePath;        // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)x_tempPath;         // 临时目录，APP退出后，系统可能会删除这里的内容

// 客户端相关参数快捷方式
+ (NSString *)x_appVersion;
+ (NSString *)x_appBuild;
+ (NSString *)x_appName;
+ (NSString *)x_appBundleID;
+ (id)x_objectOfInfoForKey:(NSString *)key;   // 获取info.plist中对应字段

// 设备相关信息
+ (NSString *)x_systemVersion;
+ (NSString *)x_systemName;
+ (BOOL)x_isIOS8Above;
+ (BOOL)x_isIOS9Above;

// Bundle相关（路径）
+ (NSString *)x_pngPathOfName:(NSString *)name;
+ (NSString *)x_jpgPathOfName:(NSString *)name;
+ (NSString *)x_bundleFilePathOfName:(NSString *)name
                                 ext:(NSString *)extension;

// 坐标相关
+ (CGFloat)x_screenWidth;
+ (CGFloat)x_screenHeight;

@end
