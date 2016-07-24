//
//  BSTabBarItem.m
//  PalmSchool
//
//  Created by Mac001 on 16/5/6.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "BSTabBarItem.h"

@implementation BSTabBarItem
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return self;
}

@end
