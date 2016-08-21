//
//  NSObject+HTTP.m
//  eather
//
//  Created by hjpraul on 14-6-10.
//  Copyright (c) 2014年 com.cdzlxt.iw. All rights reserved.
//

#import "NSObject+XHTTP.h"
#import "NSString+XCoder.h"
#import "NSObject+XJSON.h"

static NSString *const serverUrl = @"http://app.hotapi.cn/android/";    //服务器地址

@implementation NSObject (XHTTP)

#pragma mark - Private Methods
+ (AFHTTPSessionManager *)sharedManager {
    static AFHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/octet-stream",@"text/html",@"application/x-www-form-urlencoded",@"text/plain",nil];
        sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return sessionManager;
}

- (NSMutableDictionary *)finalParamsWithParams:(NSDictionary *)params {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:params];
    // TODO:
    [dic x_setObject:@"" forOBField:@"Timestamp"];
    [dic x_setObject:@"" forOBField:@"Sign"];
    [dic x_setObject:@"" forOBField:@"IMEI"];
    return dic;
}

#pragma mark - runtime
- (NSMutableArray *)tasks {
    return objc_getAssociatedObject(self, "core.network.httpTasks");
}

- (void)addTask:(NSURLSessionDataTask *)task {
    NSMutableArray *tempTasks = self.tasks;
    if (!tempTasks) {
        tempTasks = [[NSMutableArray alloc] init];
    }
    [tempTasks addObject:task];
    objc_setAssociatedObject(self, "core.network.httpTasks", tempTasks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeTask:(NSURLSessionDataTask *)task {
    NSMutableArray *tempTasks = [NSMutableArray arrayWithArray:self.tasks];
    if ([tempTasks containsObject:task]) {
        [tempTasks removeObject:task];
        objc_setAssociatedObject(self, "core.network.httpTasks", tempTasks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - Public Methods
//GET请求
- (NSURLSessionDataTask *)X_GET:(NSString *)action
                            tag:(NSInteger)tag
                         params:(NSDictionary *)params
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSMutableDictionary *finalParams = [self finalParamsWithParams:params];
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@/%@",serverUrl,action];
    NSURLSessionDataTask *task = [[[self class] sharedManager] GET:url parameters:finalParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *respDic = [NSObject x_objectFromJSONData:responseObject];
        NSInteger code = [respDic[@"code"] integerValue];
        if (code == 0) {
            NSDictionary *dataDic = respDic[@"data"];
            BLOCK_SAFE(success)(task,dataDic);
        } else {
            NSString *msg = respDic[@"msg"];
            NSError *error = [NSError x_bussinessError:code message:msg];
            BLOCK_SAFE(failure)(task,error);
        }

        [self removeTask:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_SAFE(failure)(task,error);
        [self removeTask:task];
    }];
    task.taskDescription = [NSString stringWithFormat:@"%zd",tag];
    [self addTask:task];

    return task;
}

//POST请求
- (NSURLSessionDataTask *)X_POST:(NSString *)action tag:(NSInteger)tag
                          params:(NSDictionary *)params
                        bodyPart:(void (^)(id <AFMultipartFormData> formData))bodyPart
                         success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    NSMutableDictionary *finalParams = [self finalParamsWithParams:params];
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@/%@",serverUrl,action];
    NSURLSessionDataTask *task = [[[self class] sharedManager] POST:url parameters:finalParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self removeTask:task];

        NSDictionary *respDic = [NSObject x_objectFromJSONData:responseObject];
        NSInteger code = [respDic[@"code"] integerValue];
        if (code == 0) {
            NSDictionary *dataDic = respDic[@"data"];
            BLOCK_SAFE(success)(task,dataDic);
        } else {
            NSString *msg = respDic[@"msg"];
            NSError *error = [NSError x_bussinessError:code message:msg];
            BLOCK_SAFE(failure)(task,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_SAFE(failure)(task,error);
        [self removeTask:task];
    }];
    task.taskDescription = [NSString stringWithFormat:@"%zd",tag];
    [self addTask:task];
    
    return task;
}

//取消当前对象的所有网络请求
- (void)x_cancelAllHttpReqeust {
    for (NSURLSessionDataTask *task in self.tasks) {
        if ([[[self class] sharedManager].tasks containsObject:task]) {
            [task cancel];
        }
    }
}

// 取消所有网络请求
+ (void)x_cancelAllHttpReqeust {
    [[[self class] sharedManager] invalidateSessionCancelingTasks:YES];
}
@end