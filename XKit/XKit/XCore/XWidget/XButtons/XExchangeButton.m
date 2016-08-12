//
//  XExchangeButton.m
//  XKit
//
//  Created by hjpraul on 16/5/26.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XExchangeButton.h"

@implementation XExchangeButton

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.x_width, 0, -self.titleLabel.x_width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.x_width, 0, self.imageView.x_width);
}

@end