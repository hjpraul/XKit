//
//  UIView+Edit.h
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Edit)
- (void)x_setCornerRadius:(CGFloat)radius
              borderWidth:(CGFloat)borderWidth
              borderColor:(UIColor *)borderColor;

- (void)x_setCornerRadius:(CGFloat)radius;
@end
