//
//  NSString+XFormat.h
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XFormat)
// 替换掉电话中某些特殊的字符
- (NSString *)x_toPurePhoneNum;

- (NSDate *)x_netDateToDate;

@end
