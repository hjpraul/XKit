//
//  UIScrollView+XAdapt.m
//  AnXinFu
//
//  Created by Mac001 on 2018/1/16.
//  Copyright © 2018年 hjpraul. All rights reserved.
//

#import "UIScrollView+XAdapt.h"

@implementation UIScrollView (XAdapt)

- (void)adjustsScrollViewInsets {
#pragma("clang diagnostic push")
#pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
    if ([self respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {
        NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        NSInteger argument = 2;
        invocation.target = self;
        invocation.selector = @selector(setContentInsetAdjustmentBehavior:);
        [invocation setArgument:&argument atIndex:2];
        [invocation retainArguments];
        [invocation invoke];
    }
#pragma("clang diagnostic pop")
}

@end
