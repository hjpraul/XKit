//
//  NSString+XCoder.m
//  XKit
//
//  Created by hjpraul on 16/5/19.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "NSString+XCoder.h"
#include <CommonCrypto/CommonCrypto.h>

@implementation NSString (Coder)
// -Url encode
- (NSString *)x_urlEncode {
    NSString * encodedString = (NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
    return encodedString;

}

// -Url decode
- (NSString *)x_urlDecode {
    NSString *tempStr = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString *decodeString = [tempStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return decodeString;//[decodeString stringByReplacingOccurrencesOfString:@"+" withString:@" "];

}

- (NSString *)x_md5Encode {
    if (self.length == 0) {
        return nil;
    }
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    CC_MD5(data.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
