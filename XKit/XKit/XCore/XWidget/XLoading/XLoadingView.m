//
//  XLoadingView.m
//  XKit
//
//  Created by hjpraul on 15/5/25.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XLoadingView.h"
#define TAG_LOADINGVIEW     191918

#define failedImage     ([UIImage imageNamed:@""])
#define successImage    ([UIImage imageNamed:@""])
#define infoImage       ([UIImage imageNamed:@""])

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
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (retain, nonatomic) IBOutlet UIImageView *statusImage;
@property (retain, nonatomic) IBOutlet UILabel *message;
@property (assign, nonatomic) LoadingStatus status;
@end

@implementation XLoadingView

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - Private Methods
- (void)initView {
    [_contentView x_setCornerRadius:3.0];
}

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
        [loadingView setFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
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
