//
//  XQRCodeAndBarCode.h
//  AnXinFu
//
//  Created by DaanTsai on 2017/11/30.
//  Copyright © 2017年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQRCodeAndBarCode : NSObject

/**
 生成XQRCodeAndBarCode实例

 @return XQRCodeAndBarCode实例
 */
+ (XQRCodeAndBarCode *)sharedInstance;

/**
 生成二维码图片

 @param source 生成二维码的内容
 @param imageSize 二维码图片大小
 @return 二维码图片
 */
- (UIImage *)createQRCodeImageWithSource:(NSString *)source imageSize:(CGSize)imageSize;

/**
 生成条形码图片

 @param source 生成条形码的内容
 @param imageSize 条形码图片大小
 @return 条形码图片
 */
- (UIImage *)createBarCodeImageWithSource:(NSString *)source imageSize:(CGSize)imageSize;
@end
