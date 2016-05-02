//
//  NSDate+ESDateHelper.m
//  ESDateHelper
//
//  Created by Bas van Kuijck on 30-07-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

#import "NSDate+ESDateHelper.h"
#import "ESDateRange.h"


typedef NS_ENUM(NSInteger, _ESDateComponentFlag) {
    _ESDateComponentFlagNone = 0,
    _ESDateComponentFlagMonth,
    _ESDateComponentFlagDay,
    _ESDateComponentFlagQuarter,
    _ESDateComponentFlagWeek,
    _ESDateComponentFlagYear,
    _ESDateComponentFlagMinute,
    _ESDateComponentFlagHour,
    _ESDateComponentFlagSecond,
    _ESDateComponentFlagEra
};

@implementation NSDate (ESDateHelper)

@dynamic hour,minute,second,era,year,month,week,weekday,today,leapYear,day,weekOfMonth;

#pragma mark - NSDate Extension
// ____________________________________________________________________________________________________________________

- (BOOL)isToday
{
    return [self isSameDay:[NSDate date]];
}

- (BOOL)isInCurrentWeek
{
    NSDate *cd = [NSDate date];
    return (cd.era == self.era && cd.week == self.week && cd.year == self.year);
}

- (BOOL)isLeapYear
{
    return [self.class isLeapYear:self.year];
}

- (ES_NOTNULLABLE NSDate *)dateByAddingHours:(NSInteger)hours
{
    return _dateAdd(self, _ESDateComponentFlagHour, hours);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingHours:(NSInteger)hours
{
    return _dateSet(self, _ESDateComponentFlagHour, hours);
}

- (ES_NOTNULLABLE NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    return _dateAdd(self, _ESDateComponentFlagMinute, minutes);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingMinutes:(NSInteger)minutes
{
    return _dateSet(self, _ESDateComponentFlagMinute, minutes);
}

- (ES_NOTNULLABLE NSDate *)dateByAddingSeconds:(NSInteger)seconds
{
    return _dateAdd(self, _ESDateComponentFlagSecond, seconds);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingSeconds:(NSInteger)seconds
{
    return _dateSet(self, _ESDateComponentFlagSecond, seconds);
}

- (ES_NOTNULLABLE NSDate *)dateByAddingDays:(NSInteger)days
{
    return _dateAdd(self, _ESDateComponentFlagDay, days);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingDays:(NSInteger)days
{
    return _dateSet(self, _ESDateComponentFlagDay, days);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingWeekDay:(NSInteger)weekday
{
    return _dateSet(self, _ESDateComponentFlagDay, self.day - (self.weekday - weekday));
}

- (ES_NOTNULLABLE NSDate *)dateByAddingWeeks:(NSInteger)weeks
{
    return _dateAdd(self, _ESDateComponentFlagWeek, weeks);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingWeeks:(NSInteger)weeks
{
    return _dateSet(self, _ESDateComponentFlagWeek, weeks);
}

- (ES_NOTNULLABLE NSDate *)dateByAddingMonths:(NSInteger)months
{
    return _dateAdd(self, _ESDateComponentFlagMonth, months);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingMonths:(NSInteger)months
{
    return _dateSet(self, _ESDateComponentFlagMonth, months);
}

- (ES_NOTNULLABLE NSDate *)dateByAddingYears:(NSInteger)years
{
    return _dateAdd(self, _ESDateComponentFlagYear, years);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingYears:(NSInteger)years
{
    return _dateSet(self, _ESDateComponentFlagYear, years);
}

- (ES_NOTNULLABLE NSDate *)dateByAddingQuarters:(NSInteger)quarters
{
    return _dateAdd(self, _ESDateComponentFlagQuarter, quarters);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingQuarters:(NSInteger)quarters
{
    return _dateSet(self, _ESDateComponentFlagQuarter, quarters);
}

- (ES_NOTNULLABLE NSDate *)dateByAddingEras:(NSInteger)eras
{
    return _dateAdd(self, _ESDateComponentFlagEra, eras);
}

- (ES_NOTNULLABLE NSDate *)dateBySettingEras:(NSInteger)eras
{
    return _dateSet(self, _ESDateComponentFlagEra, eras);
}

- (ES_NOTNULLABLE NSDate *)dateAtBeginningOfDay
{
    return [self dateBySettingComponents:^(NSDateComponents *comp) {
        comp.hour = 0;
        comp.second = 0;
        comp.minute = 0;
    }];
}

- (ES_NOTNULLABLE NSDate *)dateOfFirstDayOfFirstWeekForWeekDay:(NSInteger)weekday
{
    NSDate *date = [self dateBySettingComponents:^(NSDateComponents *comp) {
        comp.hour = 0;
        comp.minute = 0;
        comp.second = 0;
        comp.day = 1;
    }];
    NSInteger dif = [date weekday] - weekday;
    if (dif < 0) {
        dif += 7;
    }
    return [date dateByAddingDays:-dif];
}

- (NSInteger)hour
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self];
    return comp.hour;
}

- (NSInteger)weekOfMonth
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self];
    return comp.weekOfMonth;
}

- (NSInteger)minute
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self];
    return comp.minute;
}

- (NSInteger)second
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self];
    return comp.second;
}

- (NSInteger)week
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self];
    return comp.weekOfYear;
}

- (NSInteger)weekday
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    return comp.weekday;
}

- (NSInteger)year
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return comp.year;
}

- (NSInteger)quarter
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self];
    return comp.quarter;
}

- (NSInteger)day
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return comp.day;
}

- (NSInteger)era
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitEra fromDate:self];
    return comp.era;
}

- (NSInteger)month
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return comp.month;
}

- (NSInteger)secondsFromDate:(ES_NOTNULLABLE NSDate *)date
{
    NSInteger dif = [self timeIntervalSinceDate:date];
    NSTimeZone *timezone = [NSTimeZone defaultTimeZone];
    NSTimeInterval intervalSelf = [timezone daylightSavingTimeOffsetForDate:self];
    NSTimeInterval intervalDate = [timezone daylightSavingTimeOffsetForDate:date];
    if (intervalDate != intervalSelf) {
        dif -= (intervalDate - intervalSelf);
    }
    return dif;
}

- (NSInteger)minutesFromDate:(ES_NOTNULLABLE NSDate *)date
{
    return [self secondsFromDate:date] / 60;
}

- (NSInteger)hoursFromDate:(ES_NOTNULLABLE NSDate *)date
{
    return [self minutesFromDate:date] / 60;
}

- (NSInteger)daysFromDate:(ES_NOTNULLABLE NSDate *)date
{
    return [self hoursFromDate:date] / 24;
}

- (NSInteger)weeksFromDate:(ES_NOTNULLABLE NSDate *)date
{
    return [self daysFromDate:date] / 7;
}

#pragma mark - Helpers
// ____________________________________________________________________________________________________________________


+ (BOOL)isLeapYear:(NSInteger)year
{
    return ((year % 100 != 0) && (year % 4 == 0)) || year % 400 == 0;
}

- (BOOL)isSameDay:(ES_NOTNULLABLE NSDate *)date
{
    NSDateComponents *otherDay = _dateComponent(_ESDateComponentFlagNone, self, 0);
    NSDateComponents *today = _dateComponent(_ESDateComponentFlagNone, date, 0);
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}

- (ES_NOTNULLABLE NSDate *)dateByAddingComponents:(ES_NOTNULLABLE NSDateComponentsBlock)block
{
    if (block == nil) {
        return [self dateByAddingDays:0];
    }
    NSDateComponents *comp = _dateComponent(_ESDateComponentFlagNone, nil, 0);
    block(comp);
    return [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:self options:0];
}

- (ES_NOTNULLABLE NSDate *)dateBySettingComponents:(ES_NOTNULLABLE NSDateComponentsBlock)block
{
    if (block == nil) {
        return [self dateByAddingDays:0];
    }
    
    NSDateComponents *comp = _dateComponent(_ESDateComponentFlagNone, self, 0);
    block(comp);
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

- (BOOL)isBetweenDates:(ES_NULLABLE NSDate *)beginDate andDate:(ES_NULLABLE NSDate *)endDate
{
    ESDateRange *range = [ESDateRange rangeFromDate:beginDate toDate:endDate];
    return [range containsDate:self];
}

#pragma mark - Private functions
// ____________________________________________________________________________________________________________________


NSDateComponents *_dateComponent(_ESDateComponentFlag flag, NSDate *date, NSInteger value)
{
    NSDateComponents *dateComponents;
    
    if (date == nil) {
        dateComponents = [[NSDateComponents alloc] init];
        
    } else {
        NSInteger flags = NSCalendarUnitEra | NSCalendarUnitQuarter |  NSCalendarUnitYear |  NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay;
        dateComponents = [[NSCalendar currentCalendar] components:flags fromDate:date];
    }
    
    // Dates
    switch (flag) {
        case _ESDateComponentFlagNone:
            break;
        case _ESDateComponentFlagMonth:
            dateComponents.month = value;
            break;
        case _ESDateComponentFlagEra:
            dateComponents.era = value;
            break;
        case _ESDateComponentFlagYear:
            dateComponents.year = value;
            break;
        case _ESDateComponentFlagDay:
            dateComponents.day = value;
            break;
        case _ESDateComponentFlagSecond:
            dateComponents.second = value;
            break;
        case _ESDateComponentFlagMinute:
            dateComponents.minute = value;
            break;
        case _ESDateComponentFlagHour:
            dateComponents.hour = value;
            break;
        case _ESDateComponentFlagWeek:
            dateComponents.weekOfYear = value;
            break;
        case _ESDateComponentFlagQuarter:
            dateComponents.quarter = value;
            break;
    }
    
    return dateComponents;
}


NSDate *_dateSet(NSDate *date, _ESDateComponentFlag flag, NSInteger value)
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateComponents *dateComponents = _dateComponent(flag, date, value);
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

NSDate *_dateAdd(NSDate *date, _ESDateComponentFlag flag, NSInteger value)
{
    if (date == nil) {
        date = [NSDate date];
    }
    
    NSDateComponents *dateComponents = _dateComponent(flag, nil, value);
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
}


@end