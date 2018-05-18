//
//  NSObject+DecimalNumber.h
//  AnXinFu
//
//  Created by Mac001 on 2018/2/7.
//  Copyright © 2018年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DecimalNumber)
+ (float)floatWithdecimalNumber:(double)num;

+ (double)doubleWithdecimalNumber:(double)num;

+ (NSString *)stringWithDecimalNumber:(double)num;

+ (NSDecimalNumber *)decimalNumber:(double)num;
@end
