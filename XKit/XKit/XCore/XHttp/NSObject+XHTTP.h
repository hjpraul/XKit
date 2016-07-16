//
//  NSObject+HTTP.h
//  eather
//
//  Created by hjpraul on 14-6-10.
//  Copyright (c) 2014年 com.cdzlxt.iw. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "NSError+XHTTP.h"
#import "NSMutableDictionary+XHTTP.h"

@interface NSObject (XHTTP)
// GET请求
- (NSURLSessionDataTask *)X_GET:(NSString *)action
                            tag:(NSInteger)tag
                         params:(NSDictionary *)params
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// POST请求
- (NSURLSessionDataTask *)X_POST:(NSString *)action tag:(NSInteger)tag
                          params:(NSDictionary *)params
                        bodyPart:(void (^)(id <AFMultipartFormData> formData))bodyPart
                         success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

// 取消当前对象的所有网络请求
- (void)x_cancelAllHttpReqeust;

// 取消所有网络请求
+ (void)x_cancelAllHttpReqeust;

@end