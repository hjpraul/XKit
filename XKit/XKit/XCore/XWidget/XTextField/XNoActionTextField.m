//
//  XNoActionTextField.m
//  AnXinFu
//
//  Created by hjpraul on 2017/12/7.
//  Copyright © 2017年 hjpraul. All rights reserved.
//

#import "XNoActionTextField.h"

@implementation XNoActionTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // 禁用粘贴功能
    if (action == @selector(paste:))
        return NO;
    
    // 禁用选择功能
    if (action == @selector(select:))
        return NO;
    
    // 禁用全选功能
    if (action == @selector(selectAll:))
        return NO;
    
    return [super canPerformAction:action withSender:sender];
}

@end
