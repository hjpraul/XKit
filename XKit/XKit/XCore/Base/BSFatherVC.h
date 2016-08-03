//
//  BSFatherVC.h
//  PalmSchool
//
//  Created by hjpraul on 16/6/11.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "BSVC.h"

@interface BSFatherVC : BSVC
@property (strong, nonatomic, readonly) NSArray *childVcs;
/**
 *  @brief 初始化设置
 *
 *  @param childVcs      childViewController数组
 *  @param containerView childViewController试图容器
 */
- (void)setChildVcs:(NSArray *)childVcs
      containerView:(UIView *)containerView;

/**
 *  @brief 显示childViewController
 *
 *  @param childVc 对应要显示的childViewController
 */
- (void)showChildVc:(UIViewController *)childVc;

/**
 *  @brief 显示childViewController
 *
 *  @param index 对应childViewController的索引
 */
- (void)showChildWithIndex:(NSInteger)index;
@end
