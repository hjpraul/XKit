//
//  UIViewController+LXoading.h
//  XKit
//
//  Created by hjpraul on 15/4/22.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XLoading)
- (void)showLoadingWithMessage:(NSString *)message;
- (void)showSuccessWithMessage:(NSString *)message;
- (void)showFailedWithMessage:(NSString *)message;
- (void)showInfoWithMessage:(NSString *)message;
- (void)hideLoading;

@end
