//
//  UIViewController+XLoading.m
//  XKit
//
//  Created by hjpraul on 15/4/22.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "UIViewController+XLoading.h"
#import "XLoadingView.h"

#define LOADING_IS_VERTICAL YES

@implementation UIViewController (Loading)
- (void)showLoadingWithMessage:(NSString *)message{
    [XLoadingView showLoadingMessage:message inView:self.view];
}

- (void)showSuccessWithMessage:(NSString *)message{
    [XLoadingView showSuccessMessage:message inView:self.view];
}

- (void)showFailedWithMessage:(NSString *)message{
    [XLoadingView showFailedMessage:message inView:self.view];
}

- (void)hideLoading{
    [XLoadingView dismissInView:self.view animated:YES];
}

@end
