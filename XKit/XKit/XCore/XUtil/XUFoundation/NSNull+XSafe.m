//
//  NSNull+XSafe.m
//  XKit
//
//  Created by hjpraul on 16/5/20.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "NSNull+XSafe.h"

@implementation NSNull (XSafe)

- (NSInteger)integerValue {
    return 0;
}

- (NSInteger)length {
    return 0;
}

- (NSInteger)count {
    return 0;
}

- (BOOL)boolValue {
    return NO;
}
@end
