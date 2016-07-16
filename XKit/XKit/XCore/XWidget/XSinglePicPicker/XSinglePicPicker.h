//
//  XSinglePicPicker.h
//  XKit
//
//  Created by hjpraul on 15/4/22.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSinglePicPicker : NSObject
// 初始化函数，必须用此做初始化；
- (void)presentFromVC:(UIViewController *)vc
           sourceType:(UIImagePickerControllerSourceType)type
                 size:(CGSize)size
            completed:(void(^)(NSData *imageData,NSString *imgName))completedBlock;

@end
