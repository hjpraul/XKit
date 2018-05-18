//
//  XLAGestureView.h
//  AnXinFu
//
//  Created by DaanTsai on 2018/1/5.
//  Copyright © 2018年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLAGestureView : UIView
@property (assign, nonatomic) BOOL isForbidden;
@property (strong, nonatomic) BOOL (^passwordFinishedBlock)(NSString *password);
@end
