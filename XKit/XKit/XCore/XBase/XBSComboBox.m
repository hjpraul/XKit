//
//  XBSComboBox.m
//  XKit
//
//  Created by hjpraul on 16/5/23.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XBSComboBox.h"

@interface XBSComboBox ()
@end

@implementation XBSComboBox

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }

    return self;
}

#pragma mark - Private method
- (void)initView {
    ;   // TODO:
}

#pragma mark - Public Method
- (void)showInVC:(UIViewController *)vc
         yOffset:(CGFloat)yOffset {
    [vc.view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vc.view).with.insets(UIEdgeInsetsMake(yOffset, 0, 0, 0));
    }];
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end
