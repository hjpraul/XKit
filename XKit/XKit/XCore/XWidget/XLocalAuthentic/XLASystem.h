//
//  XLASystem.h
//  AnXinFu
//
//  Created by DaanTsai on 2018/1/22.
//  Copyright © 2018年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kXLASystemAuthBegin @"axinfu.XLASystemAuthBegin"
#define kXLASystemAuthEnd    @"axinfu.XLASystemAuthEnd"
#define kXLASystemAuthPass  @"axinfu.XLASystemAuthPass"

@interface XLASystem : NSObject
@property (assign, nonatomic) BOOL enable;

typedef NS_ENUM(NSInteger, XLASType) {
    kXLASTypeNone,           // 不支持
    kXLASTypePasscode,       // 系统密码
    kXLASTypeTouchID,        // 支持TouchID
    kXLASTypeFaceID          // 支持FaceID
};

/**
 获取单例对象
 
 @return 单例对象
 */
+ (XLASystem *)shareInstance;

/**
 销毁单例对象
 */
+ (void)releaseInstance;

/**
 检测设备支持的本地验证方式
 
 @return XLASType
 */
- (XLASType)supportedType;

/**
 FaceID Or TouchID 验证
 
 @param notice 提示消息
 @param successBlcok 验证成功
 @param failureBlock 验证失败
 */
- (void)authWithNotice:(NSString *)notice
               success:(void (^)(void))successBlcok
               failure:(void (^)(NSError *error))failureBlock;


/**
 取消正在验证的生物识别
 */
- (void)cancelAuth;
@end
