//
//  XToast.m
//  XKit
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XToast.h"

#define DISPLAY_DURATION (3.0f)
#define FONT_SIZE   (14)
#define EDG_OFFSET   (16)

@interface XToast ()
@property (strong, nonatomic) UIButton *contentView;
@end

@implementation XToast
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
}

- (id)initWithText:(NSString *)text{
    if (self = [super init]) {
        
        self.text = [text copy];
        
        UIFont *font = [UIFont boldSystemFontOfSize:FONT_SIZE];
        CGRect textRect = [text boundingRectWithSize:CGSizeMake([XUtil screenWidth]-EDG_OFFSET*4, MAXFLOAT)
                                             options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:font}
                                             context:NULL];
        CGSize textSize = textRect.size;

        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDG_OFFSET/2, EDG_OFFSET/2, textSize.width, textSize.height)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        self.contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width+EDG_OFFSET, textLabel.frame.size.height+EDG_OFFSET)];
        self.contentView.layer.cornerRadius = 5.0f;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
        [self.contentView addSubview:textLabel];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addTarget:self
                        action:@selector(toastTaped:)
              forControlEvents:UIControlEventTouchDown];
        self.contentView.alpha = 0.0f;
        
        self.duration = DISPLAY_DURATION;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify{
    [self hideAnimation];
}

-(void)dismissToast{
    [self.contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender{
    [self hideAnimation];
}

- (void)setDuration:(CGFloat) duration{
    _duration = duration;
}

-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([IQKeyboardManager sharedManager].isKeyboardShowing) {
        if ([IQKeyboardManager sharedManager].enableAutoToolbar) {
            self.contentView.center = CGPointMake(window.center.x, window.center.y-44);
        } else {
            self.contentView.center = window.center;
        }
    } else {
        self.contentView.center = window.center;
    }
    [window  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

- (void)showFromTopOffset:(CGFloat) top{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.contentView.center = CGPointMake(window.center.x, top + self.contentView.frame.size.height/2);
    [window  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

- (void)showFromBottomOffset:(CGFloat) bottom{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom + self.contentView.frame.size.height/2));
    [window  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}


+ (void)showWithText:(NSString *)text{
    [XToast showWithText:text duration:DISPLAY_DURATION];
}

+ (void)showWithText:(NSString *)text
            duration:(CGFloat)duration{
    XToast *toast = [[XToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast show];
}

+ (void)showWithText:(NSString *)text
           topOffset:(CGFloat)topOffset{
    [XToast showWithText:text  topOffset:topOffset duration:DISPLAY_DURATION];
}

+ (void)showWithText:(NSString *)text
           topOffset:(CGFloat)topOffset
            duration:(CGFloat)duration{
    XToast *toast = [[XToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromTopOffset:topOffset];
}

+ (void)showWithText:(NSString *)text
        bottomOffset:(CGFloat)bottomOffset{
    [XToast showWithText:text  bottomOffset:bottomOffset duration:DISPLAY_DURATION];
}

+ (void)showWithText:(NSString *)text
        bottomOffset:(CGFloat)bottomOffset
            duration:(CGFloat)duration{
    XToast *toast = [[XToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromBottomOffset:bottomOffset];
}
@end
