//
//  NSDate+XFormat.h
//  XKit
//
//  Created by hjpraul on 16/4/29.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XFormat)
- (NSString *)x_toShowYMD;
- (NSString *)x_toFullShow;
- (NSString *)x_toPrettyShow;
- (NSString *)x_toNetFull;
- (NSString *)x_toShowYMDHM;
- (NSString *)x_toShowChineseYMDHM;
- (NSString *)x_toShowChineseYMD;
@end
