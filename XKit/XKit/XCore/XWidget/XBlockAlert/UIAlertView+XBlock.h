//
//  UIAlertView+Block.h
//  PalmSchool
//
//  Created by DaanTsai on 16/6/5.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^alertBlock)(NSInteger buttonIndex);

@interface UIAlertView (XBlock)<UIAlertViewDelegate>
- (void)showWithBlock:(alertBlock)block;
@end
