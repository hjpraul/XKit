//
//  UIAlertView+Block.m
//  PalmSchool
//
//  Created by DaanTsai on 16/6/5.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "UIAlertView+XBlock.h"
#import <objc/runtime.h>

static const char alertKey;

@implementation UIAlertView (XBlock)
- (void)showWithBlock:(alertBlock)block {
    if (block) {
        objc_setAssociatedObject(self, &alertKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        self.delegate = self;
    }
    
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    alertBlock block = objc_getAssociatedObject(self, &alertKey);
    
    block(buttonIndex);
}
@end
