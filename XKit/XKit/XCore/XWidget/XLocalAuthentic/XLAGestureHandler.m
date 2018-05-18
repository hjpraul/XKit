//
//  XLAGestureHandler.m
//  AnXinFu
//
//  Created by DaanTsai on 2018/1/10.
//  Copyright © 2018年 hjpraul. All rights reserved.
//

#define kXLAGestureKey STOR_KEY_GROUP_BY_USER(@"XLAGesture")
#define kXLAGestureStatusKey STOR_KEY_GROUP_BY_USER(@"XLAGestureStatus")
#define kXLAGestureCountKey STOR_KEY_GROUP_BY_USER(@"XLAGestureCount")

#define kVerifyXLAGestureMaxCounnt 5

#import "XLAGestureHandler.h"
#import "NSString+XEncrypt.h"
#import "XLASystem.h"

static XLAGestureHandler *instance = nil;

@interface XLAGestureHandler()
@property (assign, nonatomic) NSInteger verifyCount;
@property (strong, nonatomic) NSString *password;
@end

@implementation XLAGestureHandler
@synthesize status = _status;
@synthesize verifyCount = _verifyCount;
@synthesize password = _password;

+ (XLAGestureHandler *)shareHandler {
    if ([AppCache shareInstance].customer) {
        if (!instance) {
            instance = [[XLAGestureHandler alloc] init];
        }
        
        return instance;
    } else {
        [self releaseHandler];
        return nil;
    }
}

+ (void)releaseHandler {
    instance = nil;
}

- (instancetype)init {
    if (self = [super init]) {
        [self loadPassword];
        [self loadVerifyCount];
        [self loadStatus];
    }
    return self;
}

#pragma mark - property load/set method
- (NSInteger)loadVerifyCount {
    id currentCount = [[NSUserDefaults standardUserDefaults] objectForKey:kXLAGestureCountKey];
    _verifyCount = [currentCount integerValue];
    return _verifyCount;
}

- (void)setVerifyCount:(NSInteger)verifyCount {
    _verifyCount = verifyCount;
    [[NSUserDefaults standardUserDefaults] setInteger:verifyCount forKey:kXLAGestureCountKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)loadPassword {
    id orgPassword = [[NSUserDefaults standardUserDefaults] objectForKey:kXLAGestureKey];
    _password = [orgPassword aes128Decrypt:[MD5Key substringToIndex:16]];
    return _password;
}

- (void)setPassword:(NSString *)password {
    _password = password;
    [[NSUserDefaults standardUserDefaults] setObject:[password aes128Encrypt:[MD5Key substringToIndex:16]] forKey:kXLAGestureKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (XLAGestureStatus)loadStatus {
    NSNumber *statusNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kXLAGestureStatusKey];
    if (!statusNumber) {
        _status = kXLAGestureStatusNotSet;
    } else {
        _status = statusNumber.integerValue;
    }
    return _status;
}

- (void)setStatus:(XLAGestureStatus)status {
    _status = status;
    [[NSUserDefaults standardUserDefaults] setObject:@(_status) forKey:kXLAGestureStatusKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Public Method
- (NSInteger)remainVerifyCount {
    return kVerifyXLAGestureMaxCounnt-_verifyCount;
}

- (BOOL)verifyPassword:(NSString *)password {
    if (!_password) {
        return NO;
    } else if ([_password isEqualToString:password]) {
        self.verifyCount = 0;
        return YES;
    } else {
        self.verifyCount++;
        return NO;
    }
}

- (void)enableByPassword:(NSString *)password {
    if (!password) {
        return;
    }
    
    self.status = kXLAGestureStatusEnable;
    self.password = password;
    [XLASystem shareInstance].enable = NO;
    self.verifyCount = 0;
}

- (void)disable {
    self.status = kXLAGestureStatusDisable;
    self.password = nil;
}
@end
