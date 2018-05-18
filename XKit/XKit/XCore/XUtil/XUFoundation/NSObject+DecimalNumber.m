//
//  NSObject+DecimalNumber.m
//  AnXinFu
//
//  Created by Mac001 on 2018/2/7.
//  Copyright © 2018年 hjpraul. All rights reserved.
//

#import "NSObject+DecimalNumber.h"

@implementation NSObject (DecimalNumber)
+ (float)floatWithdecimalNumber:(double)num {
    return [[self decimalNumber:num] floatValue];
}

+ (double)doubleWithdecimalNumber:(double)num {
    return [[self decimalNumber:num] doubleValue];
}

+ (NSString *)stringWithDecimalNumber:(double)num {
    return [[self decimalNumber:num] stringValue];
}

+ (NSDecimalNumber *)decimalNumber:(double)num {
    NSString *numString = [NSString stringWithFormat:@"%lf", num];
    return [NSDecimalNumber decimalNumberWithString:numString];
}
@end
