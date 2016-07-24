//
//  UIViewController+Base.h
//  LianghuaJifen
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Base)
// ViewDidLoad初始化公共设置
- (void)customViewDidLoad;

// 设置返回按钮可见
- (void)setBackBarVisible:(BOOL)isVisible;

// 设置左边按钮
- (UIButton *)setLeftBarByTitle:(NSString *)title
                          image:(UIImage *)image
                         action:(SEL)action;

// 设置右边按钮
- (UIButton *)setRightBarByTitle:(NSString *)title
                           image:(UIImage *)image
                          action:(SEL)action;

// 返回按钮响应
- (void)bsBackBarClicked;

@end
