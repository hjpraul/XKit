//
//  XDBManager.m
//  SchoolPalmUser
//
//  Created by hjpraul on 15/6/12.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XDBManager.h"
#import "FMDB.h"

#define DB_PATH [[XUtil x_docPath] stringByAppendingPathComponent:@"APPData.db"]

@implementation XDBManager
+ (NSString *)columTypeStringWithClass:(Class)cls {
    if ([[cls new] isKindOfClass:[NSNumber class]]) {
        return @"DOUBLE";
    } else if ([[cls new] isKindOfClass:[NSData class]]) {
        return @"BLOB";
    } else {
        return @"TEXT";
    }
}

+ (NSArray *)getPropertiesByClassName:(Class)cls {
    uint propertyCount;
    objc_property_t *ps = class_copyPropertyList(cls, &propertyCount);
    NSMutableArray* properties = [NSMutableArray arrayWithCapacity:propertyCount];

    for (uint i = 0; i < propertyCount; i++) {
        objc_property_t property = ps[i];
        const char *propertyName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:propertyName];

        const char *propertyAttributes = property_getAttributes(property);
        NSString* type = [NSString stringWithUTF8String:propertyAttributes];
        type = [type componentsSeparatedByString:@","][1];
        
        if ([type hasPrefix:@"T@"]) {
            type = [type substringFromIndex:2];
        } else {
            type = @"NSNumber";
        }
        // TODO:不全面，不安全

        [properties addObject:@{@"name":name, @"type":type}];
    }
    free(ps);
    return properties;
}

#pragma mark - Public Method
// 存储
+ (void)storeObjects:(NSArray *)objects
             toTable:(NSString *)tableName
               class:(Class)cls
          primaryKey:(NSString *)primaryKey{
    if (objects.count <= 0) {
        return;
    }

    FMDatabase *db = [FMDatabase databaseWithPath:DB_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return;
    }

    NSArray *properties = [self getPropertiesByClassName:cls];

    if ([db tableExists:tableName]) {
        // 如果表存在，枚举出列名
        FMResultSet *rs = [db getTableSchema:tableName];
        NSMutableArray *columnNames = [NSMutableArray array];
        while ([rs next]) {
            NSString *columnName = [rs stringForColumn:@"name"];
            if (columnName) {
                [columnNames addObject:columnName];
            }
        }

        // 列名与数据对象比对，如果数据对象中有列名列表之外的列，则插入
        for (int i = 0; i < properties.count; i++) {
            NSDictionary *property = properties[i];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF=%@",property[@"name"]];
            NSArray *filterResult = [columnNames filteredArrayUsingPredicate:predicate];
            if (filterResult.count <= 0) {
                NSString *insertColumnSql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN '%@' %@",tableName,property[@"name"],[self columTypeStringWithClass:NSClassFromString(property[@"type"])]];
                if (![db executeUpdate:insertColumnSql]) {
                    goto completed;
                }
            }
        }
    } else {
        // 如果表不存在，新建表
        NSMutableString *columDescSql = [NSMutableString string];
        BOOL hasPrimary = NO;;
        for (int i = 0; i < properties.count; i++) {
            NSDictionary *property = properties[i];
            hasPrimary = YES;
            if ([property[@"name"] isEqualToString:primaryKey]) {
                [columDescSql appendFormat:@"'%@' %@ PRIMARY KEY,",property[@"name"],[self columTypeStringWithClass:NSClassFromString(property[@"type"])]];
            } else {
                [columDescSql appendFormat:@"'%@' %@,",property[@"name"],[self columTypeStringWithClass:NSClassFromString(property[@"type"])]];
            }
        }
        if (hasPrimary) {
            columDescSql = (NSMutableString *)[columDescSql substringToIndex:columDescSql.length-1];
        } else {
            [columDescSql appendFormat:@"'autoIncID' INTEGER PRIMARY KEY AUTOINCREMENT"];
        }
        NSString *createSql = [NSString stringWithFormat:@"CREATE  TABLE  IF NOT EXISTS '%@' (%@)",tableName,columDescSql];
        if (![db executeUpdate:createSql]) {
            goto completed;
        }
    }
    
    // 插入数据
    for (NSObject *obj in objects) {
        NSDictionary *objDic = nil;
        if ([obj respondsToSelector:@selector(DBDic)]) {
            objDic = [(id<XDBModelDelegate>)obj DBDic];
        } else {
            objDic = [obj mj_keyValues];
        }
        NSMutableString *columnNamesSql = [NSMutableString string];
        NSMutableString *columnValuesSql = [NSMutableString string];
        for (NSString *key in objDic.allKeys) {
            id value = objDic[key];
            [columnNamesSql appendFormat:@"'%@',",key];
            [columnValuesSql appendFormat:@"'%@',",value];
        }
        if (columnNamesSql.length > 0) {
            [columnNamesSql deleteCharactersInRange:NSMakeRange(columnNamesSql.length-1, 1)];
        }
        if (columnValuesSql.length > 0) {
            [columnValuesSql deleteCharactersInRange:NSMakeRange(columnValuesSql.length-1, 1)];
        }
        NSString *insertSql = [NSString stringWithFormat:@"REPLACE INTO '%@' (%@) VALUES (%@)",tableName,columnNamesSql,columnValuesSql];
        BOOL worked = [db executeUpdate:insertSql];
        if (!worked) {
            ;
        }
    }
    
completed:
    [db close];
    return;
}

+ (NSArray *)loadObjectsFromTable:(NSString *)tableName
                            class:(Class)cls
                            range:(NSRange)range {
    FMDatabase *db = [FMDatabase databaseWithPath:DB_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return nil;
    }
    
    if (![db tableExists:tableName]) {
        [db close];
        return nil;
    }
    
    NSMutableArray *tempObjects = [NSMutableArray array];
    NSString *querySql = nil;
    if (range.length > 0) {     // TODO: ORDER BY autoIncID，排序
        querySql = [NSString stringWithFormat:@"SELECT * FROM %@ LIMIT %zd,%zd",tableName,range.location,range.length];
    } else {
        querySql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    }
    FMResultSet *rs = [db executeQuery:querySql];
    while ([rs next]) {
        // 解析
        NSMutableDictionary *rs2dic = [NSMutableDictionary dictionary];
        for (int i = 0; i < rs.columnCount; i++) {
            id value = [rs objectForColumnIndex:i];
            [rs2dic setObject:value forKey:[rs columnNameForIndex:i]];
        }
        
        id<XDBModelDelegate> obj = nil;
        if ([cls respondsToSelector:@selector(modelWithDBDic:)]) {
            obj = [cls modelWithDBDic:rs2dic];
        } else {
            obj = [cls mj_objectWithKeyValues:rs2dic];
        }
        if (obj) {
            [tempObjects addObject:obj];
        }
    }
    [db close];
    return [NSArray arrayWithArray:tempObjects];
}

+ (void)removeTable:(NSString *)tableName {
    FMDatabase *db = [FMDatabase databaseWithPath:DB_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return;
    }
    
    if (![db tableExists:tableName]) {
        [db close];
        return;
    }
    
    NSString *removeSql = [NSString stringWithFormat:@"DROP TABLE '%@'",tableName];
    [db executeUpdate:removeSql];
    [db close];
}

+ (void)cleanTable:(NSString *)tableName {
    FMDatabase *db = [FMDatabase databaseWithPath:DB_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return;
    }
    
    if (![db tableExists:tableName]) {
        [db close];
        return;
    }
    
    NSString *cleanSql = [NSString stringWithFormat:@"DELETE FROM '%@'",tableName];
    [db executeUpdate:cleanSql];
    [db close];
}

// 删除整个数据库
+ (void)removeDB {
    [[NSFileManager defaultManager] removeItemAtPath:DB_PATH error:nil];
}
@end
