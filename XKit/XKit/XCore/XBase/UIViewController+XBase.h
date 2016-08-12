//
//  UIViewController+XBase.h
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XBase)
// ViewDidLoad初始化公共设置
- (void)customViewDidLoad;

// 设置返回按钮可见
- (void)setBackBarVisible:(BOOL)isVisible;

/**
 *  @brief 设置导航栏左键
 *
 *  @param title      标题
 *  @param image      图片
 *  @param bgImage    背景图片
 *  @param leftOffset 左边距
 *  @param size       按钮展示大小
 *  @param action     响应
 *
 *  @return 左键
 */
- (UIButton *)setLeftBarByTitle:(NSString *)title
                          image:(UIImage *)image
                        bgImage:(UIImage *)bgImage
                     leftOffset:(CGFloat)leftOffset
                           size:(CGSize)size
                         action:(SEL)action;

/**
 *  @brief 设置导航栏右键
 *
 *  @param title       标题
 *  @param image       图片
 *  @param bgImage     背景图片
 *  @param rightOffset 右边距
 *  @param size        按钮展示大小
 *  @param action      响应
 *
 *  @return 右键
 */
- (UIButton *)setRightBarByTitle:(NSString *)title
                           image:(UIImage *)image
                         bgImage:(UIImage *)bgImage
                     rightOffset:(CGFloat)rightOffset
                            size:(CGSize)size
                          action:(SEL)action;

/**
 *  @brief 缺省导航栏返回按钮响应
 */
- (void)defaultBackBarAction;

@end
