//
//  XCommonLine.m
//  XKit
//
//  Created by hjpraul on 15/4/22.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XCommonLine.h"

@implementation XCommonLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self performSelector:@selector(initView) withObject:nil afterDelay:0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self performSelector:@selector(initView) withObject:nil afterDelay:0];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

- (void)initView{
    if (self.x_width<=1) {
        self.image = [[UIImage imageNamed:@"fg_line_ver"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
        self.highlightedImage = [[UIImage imageNamed:@"fg_line_ver"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    } else {
        self.image = [[UIImage imageNamed:@"fg_line_her"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
        self.highlightedImage = [[UIImage imageNamed:@"fg_line_her"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
