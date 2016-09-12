//
//  NSArray+XFilter.h
//  XKit
//
//  Created by hjpraul on 16/5/16.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XFilter)
/**
 *  @brief 对数组内容进行分组
 *
 *  @param arr 被分组的数组
 *  @param key 分组所根据的属性
 *
 *  @return 分组后的数组：数组内容为分组好的数组列表（[组1，组2...组n]）
 */
+ (NSArray *)x_groupArray:(NSArray *)arr byKey:(NSString *)key;

/**
 *  提取数组里面每个对象的某一属性，放入新的数组返回。
 *
 *  @param key 属性key
 *
 *  @return 被提取属性的数组
 */
- (NSArray *)x_fetchValuesOfKey:(NSString *)key;
@end
