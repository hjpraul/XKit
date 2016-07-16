//
//  UIImage+XEdit.h
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XEdit)
// 图片缩放
- (UIImage *)x_imageScaledToSize:(CGSize)newSize aspectRatio:(BOOL)aspectRatio;

// 重设图片颜色
- (UIImage *)x_imageWithTintColor:(UIColor *)tintColor;

// 图片裁剪
-(UIImage *)x_subImageAtRect:(CGRect)rect;

// 生成圆角图片
- (UIImage *)x_toRoundedRectImageWithSize:(CGSize)size radius:(NSInteger)radius;
@end
