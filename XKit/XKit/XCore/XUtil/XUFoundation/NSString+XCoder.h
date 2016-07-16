//
//  NSString+XCoder.h
//  XKit
//
//  Created by hjpraul on 16/5/19.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XCoder)
- (NSString *)x_urlEncode;
- (NSString *)x_urlDecode;
- (NSString *)x_md5Encode;
@end
