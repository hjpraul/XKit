//
//  XExchangeButton.m
//  XKit
//
//  Created by hjpraul on 16/5/26.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XExchangeButton.h"

@implementation XExchangeButton

- (void)awakeFromNib {
    [super awakeFromNib];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                self.titleLabel.x_width+self.space/2,
                                                0,
                                                -(self.titleLabel.x_width+self.space/2));
        self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                -(self.imageView.x_width+self.space/2),
                                                0,
                                                (self.imageView.x_width+self.space/2));
    });
}

@end
