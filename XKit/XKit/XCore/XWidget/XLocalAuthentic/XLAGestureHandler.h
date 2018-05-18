//
//  XLAGestureHandler.h
//  AnXinFu
//
//  Created by DaanTsai on 2018/1/10.
//  Copyright © 2018年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,XLAGestureStatus) {
    kXLAGestureStatusDisable,      // 不可用
    kXLAGestureStatusEnable,       // 可用
    kXLAGestureStatusNotSet,       // 未设置
};

@interface XLAGestureHandler : NSObject
@property (assign, readonly, nonatomic) NSInteger remainVerifyCount;  // 剩余可校验次数
@property (readonly, assign, nonatomic) XLAGestureStatus status;           // 状态


/**
 获取单例对象

 @return 单例对象
 */
+ (XLAGestureHandler *)shareHandler;


/**
 销毁单例对象
 */
+ (void)releaseHandler;

/**
 验证手势密码
 
 @param password 手势密码
 @return 成功-YES，失败-NO
 */
- (BOOL)verifyPassword:(NSString *)password;


/**
 启用手势密码

 @param password 手势密码
 */
- (void)enableByPassword:(NSString *)password;

/**
 禁用手势密码
 */
- (void)disable;

@end
