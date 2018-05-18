//
//  XQRCodeAndBarCode.m
//  AnXinFu
//
//  Created by DaanTsai on 2017/11/30.
//  Copyright © 2017年 hjpraul. All rights reserved.
//


#import "XQRCodeAndBarCode.h"

static XQRCodeAndBarCode *instance = nil;
@implementation XQRCodeAndBarCode
/**
 生成对象实例
 
 @return 对象实例
 */
+ (XQRCodeAndBarCode *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XQRCodeAndBarCode alloc] init];
    });
    
    return instance;
}

/**
 生成二维码图片
 
 @param source 生成二维码的内容
 @param imageSize 二维码图片大小
 @return 二维码图片
 */
- (UIImage *)createQRCodeImageWithSource:(NSString *)source imageSize:(CGSize)imageSize {
    NSData *data = [source dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    
    return [self resizeCodeImage:filter.outputImage withSize:imageSize];
}

/**
 生成条形码图片 (iOS 8.0以上的系统才支持条形码的生成，iOS8.0以下使用第三方控件生成)
 
 @param source 生成条形码的内容
 @param imageSize 条形码图片大小
 @return 条形码图片
 */
- (UIImage *)createBarCodeImageWithSource:(NSString *)source imageSize:(CGSize)imageSize {
    NSData *data = [source dataUsingEncoding: NSASCIIStringEncoding];           // 注意生成条形码的编码方式
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:[NSNumber numberWithInteger:0] forKey:@"inputQuietSpace"]; // 设置生成的条形码的上，下，左，右的margins的值
    return [self resizeCodeImage:filter.outputImage withSize:imageSize];
}

#pragma mark - Private Methods
- (UIImage *) resizeCodeImage:(CIImage *)image withSize:(CGSize)size {
    if (image) {
        CGRect extent = CGRectIntegral(image.extent);
        CGFloat scaleWidth = size.width/CGRectGetWidth(extent);
        CGFloat scaleHeight = size.height/CGRectGetHeight(extent);
        size_t width = CGRectGetWidth(extent) * scaleWidth;
        size_t height = CGRectGetHeight(extent) * scaleHeight;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
        CGContextRef contentRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef imageRef = [context createCGImage:image fromRect:extent];
        CGContextSetInterpolationQuality(contentRef, kCGInterpolationNone);
        CGContextScaleCTM(contentRef, scaleWidth, scaleHeight);
        CGContextDrawImage(contentRef, extent, imageRef);
        CGImageRef imageRefResized = CGBitmapContextCreateImage(contentRef);
        CGContextRelease(contentRef);
        CGImageRelease(imageRef);
        return [UIImage imageWithCGImage:imageRefResized];
    }else{
        return nil;
    }
}
@end
