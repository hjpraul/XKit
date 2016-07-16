//
//  NSObject+XJSON.h
//  XKit
//
//  Created by hjpraul on 16/5/1.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XJSON)
- (NSData *)x_jsonData;
- (NSString *)x_jsonString;
+ (id)x_objectFromJSONData:(NSData *)jsonData;
+ (id)x_objectFromJSONString:(NSString *)jsonString;
@end
