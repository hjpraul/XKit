//
//  NSDate+XComponent.h
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XComponent)
#pragma mark - decomponent
- (NSInteger)x_year;
- (NSInteger)x_month;
- (NSInteger)x_weekday;
- (NSInteger)x_day;
- (NSInteger)x_hour;
- (NSInteger)x_minute;
- (NSInteger)x_seconds;

#pragma mark - reset component
- (NSDate *)x_dateWithResetYear:(NSInteger)year;
- (NSDate *)x_dateWithResetMonth:(NSInteger)month;
- (NSDate *)x_dateWithResetWeekday:(NSInteger)weekday;
- (NSDate *)x_dateWithResetDay:(NSInteger)day;
- (NSDate *)x_dateWithResetHour:(NSInteger)hour;
- (NSDate *)x_dateWithResetMinute:(NSInteger)minute;
- (NSDate *)x_dateWithResetSeconds:(NSInteger)seconds;

#pragma mark - componet offset
- (NSInteger)x_offsetYearsToDate:(NSDate *)date;
- (NSInteger)x_offsetMonthsToDate:(NSDate *)date;
- (NSInteger)x_offsetWeeksToDate:(NSDate *)date;
- (NSInteger)x_offsetDaysToDate:(NSDate *)date;
- (NSInteger)x_offsetHoursToDate:(NSDate *)date;
- (NSInteger)x_offsetMinutesToDate:(NSDate *)date;
- (NSInteger)x_offsetSecondsToDate:(NSDate *)date;

#pragma mark - date with componet offset
- (NSDate *)x_dateWithOffsetYears:(NSInteger)offset;
- (NSDate *)x_dateWithOffsetMonths:(NSInteger)offset;
- (NSDate *)x_dateWithOffsetDays:(NSInteger)offset;
- (NSDate *)x_dateWithOffsetHours:(NSInteger)offset;
- (NSDate *)x_dateWithOffsetMinutes:(NSInteger)offset;
- (NSDate *)x_dateWithOffsetSeconds:(NSInteger)offset;

@end
