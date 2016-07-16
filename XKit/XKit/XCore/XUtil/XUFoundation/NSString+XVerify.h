//
//  NSString+XVerify.h
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XVerify)
// 是否是合法电话号码
- (BOOL)x_isLegalPhoneNum;

// 是否是合法电子邮箱地址
- (BOOL)x_isLegalEmailAddr;

// 判断密码格式是否正确
- (BOOL)x_isLegalPasswd;

// 判断是否是整型
- (BOOL)x_isPureInt;

// 判断是否是浮点型
- (BOOL)x_isPureFloat;

// 是否是金额表示方式
- (BOOL)x_isAmount;
@end
