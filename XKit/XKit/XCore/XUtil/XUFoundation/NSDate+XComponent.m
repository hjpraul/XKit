//
//  NSDate+XComponent.m
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "NSDate+XComponent.h"

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

#define CALENDAR [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]
#define CALENDAR_UNIT (\
NSCalendarUnitYear|\
NSCalendarUnitMonth |\
NSCalendarUnitWeekOfYear |\
NSCalendarUnitWeekOfMonth |\
NSCalendarUnitWeekdayOrdinal |\
NSCalendarUnitWeekday |\
NSCalendarUnitDay |\
NSCalendarUnitHour |\
NSCalendarUnitMinute)

#define COMPONENTS(date) [CALENDAR components:CALENDAR_UNIT fromDate:date]

@implementation NSDate (XComponent)
#pragma mark - decomponent
- (NSInteger)x_year{
    NSDateComponents *components = COMPONENTS(self);
    return components.year;
}

- (NSInteger)x_month{
    NSDateComponents *components = COMPONENTS(self);
    return components.month;
}

- (NSInteger)x_weekday{
    NSDateComponents *components = COMPONENTS(self);
    return components.weekday;
}

- (NSInteger)x_day{
    NSDateComponents *components = COMPONENTS(self);
    return components.day;
}

- (NSInteger)x_hour{
    NSDateComponents *components = COMPONENTS(self);
    return components.hour;
}

- (NSInteger)x_minute{
    NSDateComponents *components = COMPONENTS(self);
    return components.minute;
}

- (NSInteger)x_seconds{
    NSDateComponents *components = COMPONENTS(self);
    return components.second;
}

#pragma mark - reset component
- (NSDate *)x_dateWithResetYear:(NSInteger)year {
    if ((year < 1970) || (year > 10000)) {
        return self;
    }

    NSDateComponents *comps = COMPONENTS(self);
    [comps setYear:year];

    return [CALENDAR dateFromComponents:comps];
}

- (NSDate *)x_dateWithResetMonth:(NSInteger)month {
    if ((month < 1) || (month > 12)) {
        return self;
    }

    NSDateComponents *comps = COMPONENTS(self);
    [comps setMonth:month];

    return [CALENDAR dateFromComponents:comps];
}

- (NSDate *)x_dateWithResetWeekday:(NSInteger)weekday {
    if ((weekday < 1) || (weekday > 7)) {
        return self;
    }

    NSDateComponents *comps = COMPONENTS(self);
    [comps setWeekday:weekday];

    return [CALENDAR dateFromComponents:comps];
}

- (NSDate *)x_dateWithResetDay:(NSInteger)day {
    if ((day < 1) || (day > 31)) {
        return self;
    }

    NSDateComponents *comps = COMPONENTS(self);
    [comps setDay:day];

    return [CALENDAR dateFromComponents:comps];
}

- (NSDate *)x_dateWithResetHour:(NSInteger)hour {
    if ((hour < 0) || (hour > 23)) {
        return self;
    }

    NSDateComponents *comps = COMPONENTS(self);
    [comps setHour:hour];

    return [CALENDAR dateFromComponents:comps];
}

- (NSDate *)x_dateWithResetMinute:(NSInteger)minute {
    if ((minute < 0) || (minute > 59)) {
        return self;
    }

    NSDateComponents *comps = COMPONENTS(self);
    [comps setMinute:minute];

    return [CALENDAR dateFromComponents:comps];
}

- (NSDate *)x_dateWithResetSeconds:(NSInteger)seconds {
    if ((seconds < 0) || (seconds > 59)) {
        return self;
    }

    NSDateComponents *comps = COMPONENTS(self);
    [comps setSecond:seconds];

    return [CALENDAR dateFromComponents:comps];
}

#pragma mark - date with componet offset
- (NSDate *)x_dateWithOffsetYears:(NSInteger)offset{
    if ((self.x_year+offset < 1970) || (self.x_year+offset > 10000)) {
        return self;
    }

    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:offset];
    return [CALENDAR dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)x_dateWithOffsetMonths:(NSInteger)offset{
    if ((self.x_month+offset < 1) || (self.x_month+offset > 12)) {
        return self;
    }

    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setMonth:offset];
    return [CALENDAR dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)x_dateWithOffsetDays:(NSInteger)offset{
    if ((self.x_day+offset < 1) || (self.x_day+offset > 31)) {
        return self;
    }

    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setDay:offset];
    return [CALENDAR dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)x_dateWithOffsetHours:(NSInteger)offset{
    if ((self.x_hour+offset < 0) || (self.x_hour+offset > 23)) {
        return self;
    }

    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setHour:offset];
    return [CALENDAR dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)x_dateWithOffsetMinutes:(NSInteger)offset{
    if ((self.x_minute+offset < 0) || (self.x_minute+offset > 59)) {
        return self;
    }

    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setMinute:offset];
    return [CALENDAR dateByAddingComponents:adcomps toDate:self options:0];
}

- (NSDate *)x_dateWithOffsetSeconds:(NSInteger)offset{
    if ((self.x_seconds+offset < 0) || (self.x_seconds+offset > 59)) {
        return self;
    }

    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setSecond:offset];
    return [CALENDAR dateByAddingComponents:adcomps toDate:self options:0];
}

#pragma mark - componet offset
- (NSInteger)x_offsetYearsToDate:(NSDate *)date {
    NSDateComponents *comps = [CALENDAR components:CALENDAR_UNIT fromDate:self toDate:date options:0];
    return comps.year;
}

- (NSInteger)x_offsetMonthsToDate:(NSDate *)date {
    NSDateComponents *comps = [CALENDAR components:CALENDAR_UNIT fromDate:self toDate:date options:0];
    return comps.month;
}

- (NSInteger)x_offsetWeeksToDate:(NSDate *)date {
    NSDateComponents *comps = [CALENDAR components:CALENDAR_UNIT fromDate:self toDate:date options:0];
    return comps.weekOfMonth;
}
- (NSInteger)x_offsetDaysToDate:(NSDate *)date {
    NSDateComponents *comps = [CALENDAR components:CALENDAR_UNIT fromDate:self toDate:date options:0];
    return comps.day;
}

- (NSInteger)x_offsetHoursToDate:(NSDate *)date {
    NSDateComponents *comps = [CALENDAR components:CALENDAR_UNIT fromDate:self toDate:date options:0];
    return comps.hour;
}

- (NSInteger)x_offsetMinutesToDate:(NSDate *)date {
    NSDateComponents *comps = [CALENDAR components:CALENDAR_UNIT fromDate:self toDate:date options:0];
    return comps.minute;
}

- (NSInteger)x_offsetSecondsToDate:(NSDate *)date {
    NSDateComponents *comps = [CALENDAR components:CALENDAR_UNIT fromDate:self toDate:date options:0];
    return comps.second;
}
@end
