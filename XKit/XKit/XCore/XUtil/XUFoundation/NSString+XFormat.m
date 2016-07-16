//
//  NSString+XFormat.m
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "NSString+XFormat.h"

@implementation NSString (XFormat)
-(NSString *)x_toPurePhoneNum {
    NSString *telString = self;
    NSRange range;
    while ((range=[telString rangeOfString:@"mobile:" options:NSRegularExpressionSearch]).location!=NSNotFound) {
        telString=[telString stringByReplacingCharactersInRange:range withString:@""];
    }
    while ((range=[telString rangeOfString:@"home:" options:NSRegularExpressionSearch]).location!=NSNotFound) {
        telString=[telString stringByReplacingCharactersInRange:range withString:@""];
    }
    while ((range=[telString rangeOfString:@"-" options:NSRegularExpressionSearch]).location!=NSNotFound) {
        telString=[telString stringByReplacingCharactersInRange:range withString:@""];
    }
    while ((range=[telString rangeOfString:@"+86" options:NSRegularExpressionSearch]).location!=NSNotFound) {
        telString=[telString stringByReplacingCharactersInRange:range withString:@""];
    }
    return telString;
}

- (NSDate *)x_netDateToDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:self];

    return date;
}

@end
