//
//  UIView+Blank.h
//  DNF
//
//  Created by Jayla on 16/2/23.
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
                     title:(NSString *)title
                   message:(NSString *)message
                    action:(void (^)(void))action;

- (void)showBlankWithType:(BlankType)type
                    title:(NSString *)title
                  message:(NSString *)message
                   action:(void (^)(void))action;

- (void)dismissBlank;

@end
