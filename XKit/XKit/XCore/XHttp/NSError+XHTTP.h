//
//  NSError+HTTP.h
//  Unionpay
//
//  Created by hjpraul on 14-6-18.
//  Copyright (c) 2016年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const RequestErrorDoman = @"RequestErrorDoman";
static NSString *const ResponseErrorDoman = @"ResponseErrorDoman";
static NSString *const BussinessErrorDoman = @"BussinessErrorDoman";

@interface NSError (XHTTP)

+ (NSError *)x_reqeustError:(NSInteger)code message:(NSString *)message;
+ (NSError *)x_responseError:(NSInteger)code message:(NSString *)message;
+ (NSError *)x_bussinessError:(NSInteger)code message:(NSString *)message;

// 这里直接重写description
- (NSString *)x_errorMessage;

@end
