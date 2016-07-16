//
//  XToast.h
//  XKit
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XToast : NSObject
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) CGFloat duration;

+ (void)showWithText:(NSString *)text;
+ (void)showWithText:(NSString *)text
            duration:(CGFloat)duration;

+ (void)showWithText:(NSString *)text
           topOffset:(CGFloat) topOffset;

+ (void)showWithText:(NSString *)text
           topOffset:(CGFloat) topOffset
            duration:(CGFloat) duration;

+ (void)showWithText:(NSString *)text
        bottomOffset:(CGFloat) bottomOffset;

+ (void)showWithText:(NSString *)text
        bottomOffset:(CGFloat) bottomOffset
            duration:(CGFloat) duration;

@end
