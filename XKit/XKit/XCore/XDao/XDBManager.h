//
//  XDBManager.h
//  SchoolPalmUser
//
//  Created by hjpraul on 15/6/12.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "MJExtension.h"

#define kXDBTableActType     @"kXDBTableActType"

/**
 *  数据库对象协议
 */
@protocol XDBModelDelegate <NSObject>
@required
/**
 *  对象转数据库字典    注：如无此方法则调用MJExtension来转，建议凡非系统数据对象或数组都转成JSONString，不然会出问题
 *
 *  @return 数据库存储所需字典
 */
- (NSDictionary *)DBDic;

/**
 *  数据库存储字典转数据对象    注：如无此方法则调用MJExtension来转，数组对象这里需要自己转一下，MJExtension无能为力
 *
 *  @param dic 数据库存储字典
 *
 *  @return 数据对象
 */
+ (id<XDBModelDelegate>)modelWithDBDic:(NSDictionary *)dic;
@end

@interface XDBManager : NSObject
/**
 *  数据存储，已存在则更新，不存在则插入
 *
 *  @param objects    要存储的数据数组
 *  @param tableName  表名称
 *  @param cls        数据类型class
 *  @param primaryKey 主键，如果为nil或在属性中未看到则自动建自增主键
 */
+ (void)storeObjects:(NSArray *)objects
             toTable:(NSString *)tableName
               class:(Class)cls
          primaryKey:(NSString *)primaryKey;

/**
 *  数据加载
 *
 *  @param tableName 表名称
 *  @param cls       数据类型class
 *  @param range     分页范围：range.length=0表示全部
 *
 *  @return 查询到的结果数组
 */
+ (NSArray *)loadObjectsFromTable:(NSString *)tableName
                            class:(Class)cls
                            range:(NSRange)range;


/**
 *  删除表
 *
 *  @param tableName 表名
 */
+ (void)removeTable:(NSString *)tableName;

/**
 *  清除表中所有数据
 *
 *  @param tableName 表名
 */
+ (void)cleanTable:(NSString *)tableName;

/**
 *  删除整个数据库文件
 */
+ (void)removeDB;
@end
