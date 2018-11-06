//
//  XUpDownButton.m
//  XKit
//
//  Created by hjpraul on 16/5/26.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XUpDownButton.h"

@implementation XUpDownButton

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    self.imageEdgeInsets = UIEdgeInsetsMake(-(self.titleLabel.x_height+_space)/2,
                                            self.titleLabel.x_width/2,
                                            (self.titleLabel.x_height+_space)/2,
                                            -self.titleLabel.x_width/2);

    self.titleEdgeInsets = UIEdgeInsetsMake((self.imageView.x_height+_space)/2,
                                            -self.imageView.x_width,
                                            -(self.imageView.x_height+_space)/2,
                                            0);
}

@end
