//
//  UIImage+XGif.m
//  AnXinFu
//
//  Created by Mac001 on 2016/12/15.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "UIImage+XGif.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (XGif)

+ (NSArray<UIImage *> *)imagesOfGifByName:(NSString *)name
                                 duration:(NSTimeInterval *)duration {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval tempDuration = 0.0f;
    
    for (size_t i = 0; i < count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!image) {
            continue;
        }
        
        // 获取当前帧的duration
        NSTimeInterval frameDuration = 0.1f;
        CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, i, nil);
        NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
        NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
        NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
        if (delayTimeUnclampedProp) {
            frameDuration = [delayTimeUnclampedProp doubleValue];
        } else {
            NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
            if (delayTimeProp) {
                frameDuration = [delayTimeProp floatValue];
            }
        }
        if (frameDuration < 0.011f) {
            frameDuration = 0.100f;
        }
        CFRelease(cfFrameProperties);
        
        tempDuration += frameDuration;
        
        [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
        
        CGImageRelease(image);
    }
    
    if (!tempDuration) {
        tempDuration = (1.0f / 10.0f) * count;
    }
    *duration = tempDuration;
    
    CFRelease(source);
    
    return images;
}

@end
