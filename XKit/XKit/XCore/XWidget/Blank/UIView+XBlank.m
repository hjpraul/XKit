//
//  UIView+Blank.m
//  XKit
//
//  Created by hjpraul on 16/7/18.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "UIView+XBlank.h"

#define IMAGE_TAG   (8709141)
#define MESSAGE_TAG (8709142)
#define BUTTON_TAG  (8709143)

@implementation UIView (Blank)

- (void)showBlankWithImage:(UIImage *)image
                   message:(NSString *)message
                    action:(void (^)(void))action {
    __weak typeof(self) weakSelf = self;
    
    UIImageView *imageView = [self viewWithTag:IMAGE_TAG];
    if (image && !CGSizeEqualToSize(image.size, CGSizeZero)) {
        if (imageView == nil) {
            imageView = [[UIImageView alloc] init];
            imageView.tag = IMAGE_TAG;
            imageView.backgroundColor = [UIColor clearColor];
            imageView.contentMode = UIViewContentModeCenter;
            [self insertSubview:imageView atIndex:0];
        }
        imageView.image = image;
        
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.mas_centerY).offset(-32);
        }];
    } else {
        [imageView removeFromSuperview];
        imageView = nil;
    }

    UILabel *messageLabel = [self viewWithTag:MESSAGE_TAG];
    if (message) {
        if (messageLabel == nil) {
            messageLabel = [[UILabel alloc] init];
            messageLabel.tag = MESSAGE_TAG;
            messageLabel.backgroundColor = [UIColor clearColor];
            messageLabel.textColor = [UIColor lightGrayColor];
            messageLabel.textAlignment = NSTextAlignmentCenter;
            messageLabel.font = [UIFont systemFontOfSize:15];
            messageLabel.numberOfLines = 0;
            [self insertSubview:messageLabel atIndex:0];
        }
        messageLabel.text= message;
        
        if (imageView) {
            [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf);
                make.top.equalTo(imageView.mas_bottom).offset(8);
                make.left.greaterThanOrEqualTo(weakSelf).offset(16);
                make.right.lessThanOrEqualTo(weakSelf).offset(-16);
            }];
        } else {
            [messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf);
                make.bottom.equalTo(weakSelf.mas_centerY);
                make.left.greaterThanOrEqualTo(weakSelf).offset(16);
                make.right.lessThanOrEqualTo(weakSelf).offset(-16);
            }];
        }
    } else {
        [messageLabel removeFromSuperview];
        messageLabel = nil;
    }
    
    UIButton *button = [self viewWithTag:BUTTON_TAG];
    if (action) {
        if (button == nil) {
            button = [[UIButton alloc] init];
            button.tag = BUTTON_TAG;
            button.backgroundColor = [UIColor clearColor];
            button.adjustsImageWhenHighlighted = NO;
            [button addTarget:self action:@selector(__blankAction:) forControlEvents:UIControlEventTouchUpInside];
            [self insertSubview:button atIndex:0];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(weakSelf);
                make.top.left.equalTo(weakSelf);
            }];
        }
    } else {
        [button removeFromSuperview];
        button = nil;
    }
    
    objc_setAssociatedObject(self, "__blankAction__", action, OBJC_ASSOCIATION_COPY);
}

- (void)showBlankWithType:(BlankType)type
                  message:(NSString *)message
                   action:(void (^)(void))action {
    UIImage *image = nil;
    switch (type) {
        case kBlankTypeLoading:{
            image = [UIImage animatedImageNamed:@"blank_loading_gif" duration:0.8];
        }break;
        case kBlankTypeFailed:{
            image = [UIImage imageNamed:@"空白提示-加载失败"];
        }break;
        case kBlankTypeNoInfo:{
            image = [UIImage imageNamed:@"空白提示-加载无数据"];
        }break;
        default:{
            image = [UIImage imageNamed:@"空白提示-缺省"];
        }break;
    }
    [self showBlankWithImage:image message:message action:action];
}

- (void)dismissBlank {
    UIImageView *imageView = [self viewWithTag:IMAGE_TAG];
    [imageView removeFromSuperview];
    
    UILabel *messageLabel = [self viewWithTag:MESSAGE_TAG];
    [messageLabel removeFromSuperview];
    
    UIButton *button = [self viewWithTag:BUTTON_TAG];
    [button removeFromSuperview];
    
    objc_setAssociatedObject(self, "__blankAction__", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)__blankAction:(UIButton *)sender {
    void (^action)(void) = objc_getAssociatedObject(self, "__blankAction__");
    if (action) {
        action();
    }
}

@end
