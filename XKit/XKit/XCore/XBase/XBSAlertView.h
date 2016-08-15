//
//  XBSAlertView.h
//  XKit
//
//  Created by hjpraul on 13-8-18.
//  Copyright (c) 2013年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XAlertViewPresentationStyle){
	kXAlertViewPresentationStyleNone,
	kXAlertViewPresentationStylePop,
	kXAlertViewPresentationStyleFade,
	kXAlertViewPresentationStylePushFromTop,
    kXAlertViewPresentationStylePushFromLeft,
    kXAlertViewPresentationStylePushFromBottom,
    kXAlertViewPresentationStylePushFromRight,
};

typedef NS_ENUM(NSInteger, XAlertViewDismissalStyle){
	kXAlertViewDismissalStyleNone,
	kXAlertViewDismissalStyleZoomIn,
	kXAlertViewDismissalStyleZoomOut,
	kXAlertViewDismissalStyleFade,
	kXAlertViewDismissalStylePushToTop,
    kXAlertViewDismissalStylePushToLeft,
    kXAlertViewDismissalStylePushToBottom,
    kXAlertViewDismissalStylePushToRight,
};

typedef NS_ENUM(NSInteger, XAlertViewPosition){
    XAlertViewPositionTop,
    XAlertViewPositionRight,
    XAlertViewPositionBottom,
    XAlertViewPositionLeft,
    XAlertViewPositionCenter,
};

@interface XBSAlertView : UIView
@property(nonatomic, assign) IBInspectable BOOL dismissWhenClickBlank;
@property(nonatomic, assign) XAlertViewPresentationStyle presentationStyle;
@property(nonatomic, assign) XAlertViewDismissalStyle dismissalStyle;
@property(nonatomic, assign) XAlertViewPosition position;
@property(nonatomic, copy) void (^dismissBlock)(void);

@property (nonatomic, retain) UIWindow *previousWindow;

- (void)show;
- (void)showWithStyle:(XAlertViewPresentationStyle)presentationStyle;

- (void)dismiss;
- (void)dismissWithStyle:(XAlertViewDismissalStyle)dismissalStyle;
@end
