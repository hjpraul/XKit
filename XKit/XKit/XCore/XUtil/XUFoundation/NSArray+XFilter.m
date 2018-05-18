//
//  NSArray+XFilter.m
//  XKit
//
//  Created by hjpraul on 16/5/16.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "NSArray+XFilter.h"

@implementation NSArray (XFilter)
+ (NSArray *)x_groupArray:(NSArray *)arr byKey:(NSString *)key {
    NSMutableArray *resultArray = [NSMutableArray array];

    NSMutableOrderedSet *set=[[NSMutableOrderedSet alloc] init];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj) {
            [set addObject:[obj valueForKey:key]];  //利用set不重复的特性,得到分组个数
        }
    }];
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *formatStr = nil;   // 一定要这样，不能直接写到NSPredicate创建时
        if ([obj isKindOfClass:[NSString class]]) {
            formatStr = [NSString stringWithFormat:@"%@=\"%@\"",key,obj];
        } else {
            formatStr = [NSString stringWithFormat:@"%@=%@",key,obj];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:formatStr];
        NSArray *group = [arr filteredArrayUsingPredicate:predicate];
        if (group.count > 0) {
            [resultArray addObject:group];
        }
    }];

    return resultArray;
}

- (NSArray *)x_fetchValuesOfKey:(NSString *)key {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (id obj in self) {
        if ([obj valueForKey:key]) {
            [resultArray addObject:[obj valueForKey:key]];
        }
    }
    return resultArray;
}
@end
