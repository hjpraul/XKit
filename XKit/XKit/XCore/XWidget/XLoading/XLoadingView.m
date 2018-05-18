//
//  XLoadingView.m
//  XKit
//
//  Created by hjpraul on 15/5/25.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XLoadingView.h"
#define TAG_LOADINGVIEW     191918

#define failedImage     ([UIImage imageNamed:@"icon_loading_failed"])
#define successImage    ([UIImage imageNamed:@"icon_loading_success"])
#define infoImage       ([UIImage imageNamed:@"icon_loading_info"])

#define minDelayTime    (2.0)
#define maxDelayTime    (8.0)
#define animationDuration    (0.3)

// 加载状态(1:加载中、2加载成功、3加载失败)
typedef NS_ENUM(NSInteger, LoadingStatus) {
    kLoadingStatusLoading = 1,
    kLoadingStatusSuccess = 2,
    kLoadingStatusFailed = 3,
    kLoadingStatusInfo = 4,
};

@interface XLoadingView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UIImageView *statusImage;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (assign, nonatomic) LoadingStatus status;
@end

@implementation XLoadingView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_contentView x_setCornerRadius:5.0];
}

#pragma mark - Private Methods

- (void)setStatus:(LoadingStatus)status {
    _status = status;
    switch (status) {
        case kLoadingStatusLoading:{
            self.statusImage.hidden = YES;
            self.activity.hidden = NO;
            [self.activity startAnimating];
        }break;
        case kLoadingStatusFailed:{
            self.statusImage.hidden = NO;
            self.statusImage.image = failedImage;
            self.activity.hidden = YES;
            [self.activity stopAnimating];
        }break;
        case kLoadingStatusSuccess:{
            self.statusImage.hidden = NO;
            self.statusImage.image = successImage;
            self.activity.hidden = YES;
            [self.activity stopAnimating];
        }break;
        case kLoadingStatusInfo:{
            self.statusImage.hidden = NO;
            self.statusImage.image = infoImage;
            self.activity.hidden = YES;
            [self.activity stopAnimating];
        }break;

        default:
            break;
    }
}

+ (instancetype)loadingViewInView:(UIView *)view{
    XLoadingView *loadingView = (XLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        loadingView = [[NSBundle mainBundle] loadNibNamed:@"XLoadingView" owner:nil options:nil].firstObject;
        [loadingView setTag:TAG_LOADINGVIEW];
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *tempView = (UIScrollView *)view;
            [loadingView setFrame:CGRectMake(0, tempView.contentOffset.y, view.bounds.size.width, view.bounds.size.height)];
        } else {
            [loadingView setFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
        }
        [view addSubview:loadingView];
    }
    return loadingView;
}

+ (CGFloat)delayTimeOfMessage:(NSString *)message {
    return MIN(MAX(message.length*0.06 + 0.5, minDelayTime), maxDelayTime);
}

#pragma mark - Puboic Methods
+ (void)showLoadingMessage:(NSString *)message inView:(UIView *)view{
    XLoadingView *loadingView = [self loadingViewInView:view];
    loadingView.status = kLoadingStatusLoading;
    loadingView.message.text = message;
    [loadingView setNeedsLayout];
    loadingView.alpha = 1;
}

+ (void)showSuccessMessage:(NSString *)message inView:(UIView *)view{
    XLoadingView *loadingView = [self loadingViewInView:view];
    loadingView.status = kLoadingStatusSuccess;
    loadingView.message.text = message;
    [loadingView setNeedsLayout];
    loadingView.alpha = 1;
    
    //延迟隐藏
    [UIView animateWithDuration:animationDuration
                          delay:[self delayTimeOfMessage:message]
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
        loadingView.alpha = 0;
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
    }];
}

+ (void)showFailedMessage:(NSString *)message inView:(UIView *)view{
    XLoadingView *loadingView = [self loadingViewInView:view];
    loadingView.status = kLoadingStatusFailed;
    loadingView.message.text = message;
    [loadingView setNeedsLayout];
    loadingView.alpha = 1;

    //延迟隐藏
    [UIView animateWithDuration:animationDuration
                          delay:[self delayTimeOfMessage:message]
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
        loadingView.alpha = 0;
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
    }];
}

+ (void)showInfoMessage:(NSString *)message inView:(UIView *)view{
    XLoadingView *loadingView = [self loadingViewInView:view];
    loadingView.status = kLoadingStatusInfo;
    loadingView.message.text = message;
    [loadingView setNeedsLayout];
    loadingView.alpha = 1;

    //延迟隐藏
    [UIView animateWithDuration:animationDuration
                          delay:[self delayTimeOfMessage:message]
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
        loadingView.alpha = 0;
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
    }];
}


+ (void)dismissInView:(UIView *)view animated:(BOOL)animated{
    XLoadingView *loadingView = (XLoadingView *)[view viewWithTag:TAG_LOADINGVIEW];
    if (!loadingView) {
        return;
    }
    
    //隐藏动画
    if (animated) {
        [UIView animateWithDuration:animationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [loadingView setAlpha:0];
        } completion:^(BOOL finished) {
            [loadingView removeFromSuperview];
        }];
    } else {
        [loadingView removeFromSuperview];
    }
}

@end
