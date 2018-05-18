//
//  UIButton+ImageButton.h
//  SchoolAxinPay
//
//  Created by DaanTsai on 16/8/1.
//  Copyright © 2016年 zhax. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kButtonEdgeInsetsStyle) {
    kButtonEdgeInsetsStyleTop,      // image在上，label在下
    kButtonEdgeInsetsStyleLeft,     // image在左，label在右
    kButtonEdgeInsetsStyleBottom,   // image在下，label在上
    kButtonEdgeInsetsStyleRight     // image在右，label在左
};

@interface UIButton (ImageButton)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(kButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
