//
//  UIImage+XCreate.h
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XCreate)
// 创建纯色图片
+(UIImage *)x_imageWithColor:(UIColor *)color size:(CGSize)size;

// 视图转图片
+ (UIImage *)x_imageWithView:(UIView *)view;
@end
