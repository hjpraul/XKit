//
//  UIView+Blank.h
//  XKit
//
//  Created by hjpraul on 16/7/18.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kBlankTypeLoading,
    kBlankTypeFailed,
    kBlankTypeNoInfo,
}BlankType;

@interface UIView (Blank)

- (void)showBlankWithImage:(UIImage *)image
                   message:(NSString *)message
                    action:(void (^)(void))action;

- (void)showBlankWithType:(BlankType)type
                  message:(NSString *)message
                   action:(void (^)(void))action;

- (void)dismissBlank;

@end
