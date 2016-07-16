//
//  NSString+XToast.m
//  XKit
//
//  Created by hjpraul on 15/4/16.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "NSString+XToast.h"
#import "XToast.h"

@implementation NSString (XToast)
- (void)x_toast{
    [XToast showWithText:self];
}
@end
