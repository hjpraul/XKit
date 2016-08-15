//
//  XBSAlertView.m
//  XKit
//
//  Created by hjpraul on 13-8-18.
//  Copyright (c) 2013年 hjpraul. All rights reserved.
//

#import "XBSAlertView.h"

#define ANIMATION_DURATION  (0.3f)
#define DELAY_DURATION      (0.0f)

typedef void (^AnimationBlock)();
typedef void (^AnimationCompletionBlock)(BOOL);

@interface XBSAlertView()
@property (nonatomic, retain) UIWindow *alertWindow;
@property (nonatomic, retain) UIImageView *dimImageView;
@end

@implementation XBSAlertView

- (id)init{
    self = [super init];
    if (self) {
        [self initAlert];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAlert];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initAlert];
    }
    return self;
}

- (void)initAlert{
    [self setPresentationStyle:kXAlertViewPresentationStyleFade];
    [self setDismissalStyle:kXAlertViewDismissalStyleFade];
    [self setPosition:XAlertViewPositionCenter];
}

#pragma mark - Private Method
- (void)setStartPosition {
    switch (_presentationStyle) {
        case kXAlertViewPresentationStylePushFromTop:
            self.center = CGPointMake(XUtil.screenWidth/2, -self.x_height/2);
            break;
        case kXAlertViewPresentationStylePushFromLeft:
            self.center =  CGPointMake(-self.x_width/2, XUtil.screenHeight/2);
            break;
        case kXAlertViewPresentationStylePushFromBottom:
            self.center =  CGPointMake(XUtil.screenWidth/2, XUtil.screenHeight+self.x_height/2);
            break;
        case kXAlertViewPresentationStylePushFromRight:
            self.center =  CGPointMake(XUtil.screenWidth+self.x_width/2, XUtil.screenHeight/2);
            break;
        default:
            [self setFinalShowPosition];
            break;
    }
}

- (void)setFinalShowPosition {
    switch (_position) {
        case XAlertViewPositionTop:
            self.center = CGPointMake(XUtil.screenWidth/2, self.x_height/2);
            break;
        case XAlertViewPositionLeft:
            self.center =  CGPointMake(self.x_width/2, XUtil.screenHeight/2);
            break;
        case XAlertViewPositionBottom:
            self.center =  CGPointMake(XUtil.screenWidth/2, XUtil.screenHeight-self.x_height/2);
            break;
        case XAlertViewPositionRight:
            self.center =  CGPointMake(XUtil.screenWidth-self.x_width/2, XUtil.screenHeight/2);
            break;
        case XAlertViewPositionCenter:
        default:
            self.center =  CGPointMake(XUtil.screenWidth/2, XUtil.screenHeight/2);
            break;
    }
}

- (void)setDismissPosition {
    switch (_dismissalStyle) {
        case kXAlertViewDismissalStylePushToTop:
            self.center = CGPointMake(XUtil.screenWidth/2, -self.x_height/2);
            break;
        case kXAlertViewDismissalStylePushToLeft:
            self.center =  CGPointMake(-self.x_width/2, XUtil.screenHeight/2);
            break;
        case kXAlertViewDismissalStylePushToBottom:
            self.center =  CGPointMake(XUtil.screenWidth/2, XUtil.screenHeight+self.x_height/2);
            break;
        case kXAlertViewDismissalStylePushToRight:
            self.center =  CGPointMake(XUtil.screenWidth+self.x_width/2, XUtil.screenHeight/2);
            break;
        default:
            [self setFinalShowPosition];
            break;
    }
}

- (void)performPresentationAnimation{
    switch (self.presentationStyle) {
        case kXAlertViewPresentationStyleNone:{
            
        }break;
        case kXAlertViewPresentationStylePop:{
            CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
            bounceAnimation.duration = 0.3f;
            bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            bounceAnimation.values = @[@0.01f,@1.1f,@0.9f,@1.0f];
            [self.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
            
            CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
            fadeInAnimation.duration = 0.3f;
            fadeInAnimation.fromValue = @0.0f;
            fadeInAnimation.toValue = @1.0f;
            [self.dimImageView.layer addAnimation:fadeInAnimation forKey:@"opacity"];
        }break;
        case kXAlertViewPresentationStyleFade:{
            [self setAlpha:0.0f];
            [self.dimImageView setAlpha:0.0f];
            [UIView animateWithDuration:ANIMATION_DURATION delay:DELAY_DURATION options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setAlpha:1.0f];
                [self.dimImageView setAlpha:1.0f];
            } completion:nil];
        }break;
        case kXAlertViewPresentationStylePushFromTop:
        case kXAlertViewPresentationStylePushFromLeft:
        case kXAlertViewPresentationStylePushFromBottom:
        case kXAlertViewPresentationStylePushFromRight:{
            [self setStartPosition];
            [self.dimImageView setAlpha:0.0f];
            [UIView animateWithDuration:ANIMATION_DURATION delay:DELAY_DURATION options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setFinalShowPosition];
                [self.dimImageView setAlpha:1.0f];
            } completion:nil];
        }break;
        default:break;
    }
}

- (void)performDismissalAnimation{
    
    AnimationCompletionBlock completionBlock = ^(BOOL finished){
        [self.dimImageView removeFromSuperview];
        [self removeFromSuperview];
        
        [self.previousWindow makeKeyWindow];
        [self setPreviousWindow:nil];
        [self setDimImageView:nil];
        [self setAlertWindow:nil];
        BLOCK_SAFE(_dismissBlock)();
    };
    
    switch (self.dismissalStyle) {
        case kXAlertViewDismissalStyleNone:{
            completionBlock(YES);
        }break;
        case kXAlertViewDismissalStyleZoomIn:{
            [UIView animateWithDuration:ANIMATION_DURATION delay:DELAY_DURATION options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self setTransform:CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(0.01, 0.01))];
                [self setAlpha:0.0f];
                [self.dimImageView setAlpha:0.0f];
            } completion:completionBlock];
        }break;
        case kXAlertViewDismissalStyleZoomOut:{
            [UIView animateWithDuration:ANIMATION_DURATION delay:DELAY_DURATION options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self setTransform:CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(10, 10))];
                [self setAlpha:0.0f];
                [self.dimImageView setAlpha:0.0f];
            } completion:completionBlock];
        }break;
        case kXAlertViewDismissalStyleFade:{
            [UIView animateWithDuration:ANIMATION_DURATION delay:DELAY_DURATION options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setAlpha:0.0f];
                [self.dimImageView setAlpha:0.0f];
            } completion:completionBlock];
        }break;
        case kXAlertViewDismissalStylePushToTop:
        case kXAlertViewDismissalStylePushToLeft:
        case kXAlertViewDismissalStylePushToBottom:
        case kXAlertViewDismissalStylePushToRight:{
            [UIView animateWithDuration:ANIMATION_DURATION delay:DELAY_DURATION options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setDismissPosition];
                [self.dimImageView setAlpha:0.0f];
            } completion:completionBlock];
        }break;
        default:{
        }break;
    }
}

// 点旁边dismiss
- (void)bgTapped:(UITapGestureRecognizer *)sender{
    if (_dismissWhenClickBlank) {
        [self dismiss];
    }
}

#pragma mark - Public Method
- (void)show{
    [self showWithStyle:self.presentationStyle];
}

- (void)showWithStyle:(XAlertViewPresentationStyle)presentationStyle{
    [self setPresentationStyle:presentationStyle];
    
    // 记住KeyWindow
    [self setPreviousWindow:[[UIApplication sharedApplication] keyWindow]];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    // 设置AlertWindow
    UIWindow *window = [[UIWindow alloc] initWithFrame:bounds];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];
    window.rootViewController = vc;
    [window setWindowLevel:UIWindowLevelAlert];
    [window makeKeyAndVisible];
    [self setAlertWindow:window];
    
    
    // 设置遮罩背景
    UIImage *bgImage = [UIImage x_imageWithColor:RGBA(0, 0, 0, 0.4) size:bounds.size];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:bounds];
    [imageView setUserInteractionEnabled:YES];
    [imageView setImage:bgImage];
    [self setDimImageView:imageView];
	[vc.view addSubview:imageView];
    
    // 增加点击背景关闭的手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapped:)];
    [imageView addGestureRecognizer:gesture];
    
    //设置提示弹框
    [self setFinalShowPosition];
	[vc.view addSubview:self];
    
	//出入场动画
    [self performPresentationAnimation];
}

- (void)dismiss{
    BLOCK_SAFE(_dismissBlock)();
    [self dismissWithStyle:self.dismissalStyle];
}
- (void)dismissWithStyle:(XAlertViewDismissalStyle)dismissalStyle{
    [self setDismissalStyle:dismissalStyle];
    
    //隐藏键盘
	[self endEditing:YES];
    
	//出场动画
	[self performDismissalAnimation];
}

@end
