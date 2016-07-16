//
//  XLoadingView.h
//  XKit
//
//  Created by hjpraul on 15/5/25.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLoadingView : UIView
+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view;
+ (void)showSuccessMessage:(NSString *)message inView:(UIView *)view;
+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view;
+ (void)showInfoMessage:(NSString *)message inView:(UIView *)view;
+ (void)dismissInView:(UIView *)view animated:(BOOL)animated;
@end
