//
//  NSMutableDictionary+HTTP.h
//  eather
//
//  Created by hjpraul on 14-6-12.
//  Copyright (c) 2014年 com.cdzlxt.iw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (XHTTP)

//当对象为空时，自动设置为NULL对象
- (void)x_setObject:(id)anObject forOBField:(id <NSCopying>)aKey;

//当对象为空时，不设置值
- (void)x_setObject:(id)anObject forOPField:(id <NSCopying>)aKey;

@end
