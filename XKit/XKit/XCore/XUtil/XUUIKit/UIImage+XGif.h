//
//  UIImage+XGif.h
//  AnXinFu
//
//  Created by Mac001 on 2016/12/15.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XGif)
+ (NSArray<UIImage *> *)imagesOfGifByName:(NSString *)name
                                 duration:(NSTimeInterval *)duration;
@end
