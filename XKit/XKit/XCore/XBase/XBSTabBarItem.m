//
//  XBSTabBarItem.m
//  XKit
//
//  Created by Mac001 on 16/5/6.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XBSTabBarItem.h"

@implementation XBSTabBarItem
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    self = [super initWithTitle:title image:image selectedImage:selectedImage];
    if (self) {
        [self initView];
    }

    return self;
}

#pragma mark - Private Method
- (void)initView {
    self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.imageInsets = UIEdgeInsetsMake(8, -32, -8, 32);
    self.titlePositionAdjustment = UIOffsetMake(20, -14);
}
@end
