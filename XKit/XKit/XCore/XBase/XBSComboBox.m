//
//  XBSComboBox.m
//  XKit
//
//  Created by hjpraul on 16/5/23.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XBSComboBox.h"

@interface XBSComboBox ()
@property (strong, nonatomic) UIView *bgCover;
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
    // do nothing
}

- (UIView *)bgCover {
    if (!_bgCover) {
        _bgCover = [[UIView alloc] init];
        _bgCover.backgroundColor = RGBA(0, 0, 0, 0.3);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tapGesture.cancelsTouchesInView = YES;
        [_bgCover addGestureRecognizer:tapGesture];
    }
    return _bgCover;
}

#pragma mark - Public Method
- (void)showInVC:(UIViewController *)vc
         yOffset:(CGFloat)yOffset {
    [vc.view addSubview:self];
    if (![vc.view.subviews containsObject:self.bgCover]) {
        [vc.view addSubview:self.bgCover];
    }
    [self.bgCover mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vc.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vc.view).with.insets(UIEdgeInsetsMake(yOffset, 0, 0, 0));
    }];
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end
