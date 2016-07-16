//
//  UIImage+XCreate.m
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "UIImage+XCreate.h"

@implementation UIImage (XCreate)
+(UIImage *)x_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)x_imageWithView:(UIView *)view {
//    [view.layer setContentsScale:[[UIScreen mainScreen] scale]];

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 1.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];

    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationHigh);
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

//    UIImageView *currentView = [[UIImageView alloc] initWithImage: img];
//
//    //Fix the position to handle status bar and navigation bar
//    [currentView setFrame:CGRectMake(0, view.frame.origin.y, currentView.frame.size.width, currentView.frame.size.height)];

    return img;
}
@end
