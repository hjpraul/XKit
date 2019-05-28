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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect rc = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, self.titleLabel.font.pointSize) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
        CGFloat offset = rc.size.width-self.titleLabel.x_width; // offset是解决原始状态下标题显示不全的情况
        
        self.imageEdgeInsets = UIEdgeInsetsMake(-(self.titleLabel.x_height+self.space)/2,
                                                self.titleLabel.x_width/2,
                                                (self.titleLabel.x_height+self.space)/2,
                                                -self.titleLabel.x_width/2);
        
        self.titleEdgeInsets = UIEdgeInsetsMake((self.imageView.x_height+self.space)/2,
                                                -self.imageView.x_width/2-offset/2,
                                                -(self.imageView.x_height+self.space)/2,
                                                self.imageView.x_width/2-offset/2);
    });
}

@end
