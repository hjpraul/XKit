//
//  XLASystem.m
//  AnXinFu
//
//  Created by DaanTsai on 2018/1/22.
//  Copyright © 2018年 hjpraul. All rights reserved.
//

#import "XLASystem.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "XLAGestureHandler.h"

#define kXLASEnableKey STOR_KEY_GROUP_BY_USER(@"XLASystem")

static XLASystem *instance = nil;

@interface XLASystem()
@property (strong, nonatomic) LAContext *laContext;
@end

@implementation XLASystem

+ (XLASystem *)shareInstance {
    if ([AppCache shareInstance].customer) {
        if (!instance) {
            instance = [[XLASystem alloc] init];
        }
        
        return instance;
    } else {
        [self releaseInstance];
        return nil;
    }
}

+ (void)releaseInstance {
    [instance cancelAuth];
    instance = nil;
}

- (instancetype)init {
    if (self = [super init]) {
        [self loadEnable];
    }
    return self;
}

- (BOOL)loadEnable {
    _enable = [[NSUserDefaults standardUserDefaults] boolForKey:kXLASEnableKey];
    return _enable;
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    if (enable && [XLAGestureHandler shareHandler].status == kXLAGestureStatusEnable) {
        [[XLAGestureHandler shareHandler] disable];
    }
    [[NSUserDefaults standardUserDefaults] setBool:enable forKey:kXLASEnableKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (XLASType)supportedType {
    XLASType type = kXLASTypeNone;
    self.laContext = [[LAContext alloc] init];
    NSError *authError = nil;
    BOOL isCanEvaluatePolicy = [_laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError];
    
    if (isCanEvaluatePolicy) {
        if (@available(iOS 11.0, *)) {
            switch (_laContext.biometryType) {
                case LABiometryTypeTouchID:
                    type = kXLASTypeTouchID;
                    break;
                case LABiometryTypeFaceID:
                    type = kXLASTypeFaceID;
                    break;
                default:
                    type = kXLASTypePasscode;
                    break;
            }
        } else {
            type = kXLASTypeTouchID;
        }
    } else {
        if ((authError.code == LAErrorPasscodeNotSet) || (authError.code == LAErrorTouchIDNotEnrolled)) {
            type = kXLASTypeNone;
        } else {
            type = kXLASTypePasscode;
        }
    }
    return type;
}

- (void)authWithNotice:(NSString *)notice
               success:(void (^)(void))successBlcok
               failure:(void (^)(NSError *error))failureBlock {
    if (notice.length <= 0) {
        notice = @"用于解锁应用";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kXLASystemAuthBegin object:nil];
    [_laContext evaluatePolicy:kLAPolicyDeviceOwnerAuthentication localizedReason:notice reply:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kXLASystemAuthEnd object:@(success)];
            if (success) {
                BLOCK_SAFE(successBlcok)();
            } else {
                BLOCK_SAFE(failureBlock)(error);
            }
        });
    }];
}

- (void)cancelAuth {
    [_laContext invalidate];
}
@end
