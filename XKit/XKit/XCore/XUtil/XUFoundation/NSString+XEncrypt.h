//
//  NSString+Encrypt.h
//  AnXinFu
//
//  Created by Mac001 on 2017/5/20.
//  Copyright © 2017年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XEncrypt)

/**
 字符串aes128加密

 @param key 加密key
 @return 加密后密文，若失败返回nil
 */
- (NSString *)aes128Encrypt:(NSString *)key;


/**
 字符串aes128解密

 @param key 揭秘key
 @return 揭秘后明文，若失败返回nil
 */
- (NSString *)aes128Decrypt:(NSString *)key;
@end
