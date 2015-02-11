//
//  ESDateHelper.m
//  iOS.Library
//
//  Created by Bas van Kuijck on 16-04-14.
//
//

#import "ESDateHelper.h"

#if !__has_feature(objc_arc)
#define __weakblock __block
#define autorelease(obj) [obj autorelease]
#define release(obj) [obj release]
#else
#define __weakblock __weak
#define autorelease(obj)
#define release(obj)
#endif


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
    _ESDateComponentFlagWeekDay,
    _ESDateComponentFlagEra
};

@interface ESDateHelper ()
{
    
}
NSDateComponents *_dateComponentFromDictionary(_ESDateComponentFlag flag, NSDate *date, NSInteger value);
NSDate *_dateSet(NSDate *date, _ESDateComponentFlag flag, NSInteger value);
NSDate *_dateAdd(NSDate *date, _ESDateComponentFlag flag, NSInteger value);
@end

@implementation ESDateHelper

#pragma mark - Helpers
// ____________________________________________________________________________________________________________________

+ (BOOL)is24HourNotation
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"a"];
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    if ([formatStringForHours rangeOfString:@"a"].location != NSNotFound) {
        return NO;
    }
    return YES;
}

#pragma mark - NSDateComponents
// ____________________________________________________________________________________________________________________


NSDateComponents *_dateComponent(_ESDateComponentFlag flag, NSDate *date, NSInteger value)
{
    NSDateComponents *dateComponents;
    
    if (date == nil) {
        dateComponents = [[NSDateComponents alloc] init];
        autorelease(dateComponents);
        
    } else {
        NSInteger flags = NSCalendarUnitEra | NSCalendarUnitQuarter |  NSCalendarUnitYear |  NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        if (flag == _ESDateComponentFlagWeekDay) {
            flags |= NSCalendarUnitWeekday;
        } else {
            flags |= NSCalendarUnitDay;
        }
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
        case _ESDateComponentFlagWeekDay:
            dateComponents.weekday = value;
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

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    return _dateAdd(self, _ESDateComponentFlagHour, hours);
}

- (NSDate *)dateBySettingHours:(NSInteger)hours
{
    return _dateSet(self, _ESDateComponentFlagHour, hours);
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    return _dateAdd(self, _ESDateComponentFlagMinute, minutes);
}

- (NSDate *)dateBySettingMinutes:(NSInteger)minutes
{
    return _dateSet(self, _ESDateComponentFlagMinute, minutes);
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds
{
    return _dateAdd(self, _ESDateComponentFlagSecond, seconds);
}

- (NSDate *)dateBySettingSeconds:(NSInteger)seconds
{
    return _dateSet(self, _ESDateComponentFlagSecond, seconds);
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    return _dateAdd(self, _ESDateComponentFlagDay, days);
}

- (NSDate *)dateBySettingDays:(NSInteger)days
{
    return _dateSet(self, _ESDateComponentFlagDay, days);
}

- (NSDate *)dateBySettingWeekDay:(NSInteger)weekday
{
    return _dateSet(self, _ESDateComponentFlagWeekDay, weekday);
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks
{
    return _dateAdd(self, _ESDateComponentFlagWeek, weeks);
}

- (NSDate *)dateBySettingWeeks:(NSInteger)weeks
{
    return _dateSet(self, _ESDateComponentFlagWeek, weeks);
}

- (NSDate *)dateByAddingMonths:(NSInteger)months
{
    return _dateAdd(self, _ESDateComponentFlagMonth, months);
}

- (NSDate *)dateBySettingMonths:(NSInteger)months
{
    return _dateSet(self, _ESDateComponentFlagMonth, months);
}

- (NSDate *)dateByAddingYears:(NSInteger)years
{
    return _dateAdd(self, _ESDateComponentFlagYear, years);
}

- (NSDate *)dateBySettingYears:(NSInteger)years
{
    return _dateSet(self, _ESDateComponentFlagYear, years);
}

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters
{
    return _dateAdd(self, _ESDateComponentFlagQuarter, quarters);
}

- (NSDate *)dateBySettingQuarters:(NSInteger)quarters
{
    return _dateSet(self, _ESDateComponentFlagQuarter, quarters);
}

- (NSDate *)dateByAddingEras:(NSInteger)eras
{
    return _dateAdd(self, _ESDateComponentFlagEra, eras);
}

- (NSDate *)dateBySettingEras:(NSInteger)eras
{
    return _dateSet(self, _ESDateComponentFlagEra, eras);
}

- (NSDate *)dateAtBeginningOfDay
{
    return [self dateBySettingComponents:^(NSDateComponents *comp) {
        comp.hour = 0;
        comp.second = 0;
        comp.minute = 0;
    }];
}

- (NSDate *)dateOfFirstDayOfFirstWeekForWeekDay:(NSInteger)weekday
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

- (NSInteger)secondsFromDate:(NSDate *)date
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

- (NSInteger)minutesFromDate:(NSDate *)date
{
    return [self secondsFromDate:date] / 60;
}

- (NSInteger)hoursFromDate:(NSDate *)date
{
    return [self minutesFromDate:date] / 60;
}

- (NSInteger)daysFromDate:(NSDate *)date
{
    return [self hoursFromDate:date] / 24;
}

- (NSInteger)weeksFromDate:(NSDate *)date
{
    return [self daysFromDate:date] / 7;
}

#pragma mark - Helpers
// ____________________________________________________________________________________________________________________


+ (BOOL)isLeapYear:(NSInteger)year
{
    return ((year % 100 != 0) && (year % 4 == 0)) || year % 400 == 0;
}

- (BOOL)isSameDay:(NSDate *)date
{
    NSDateComponents *otherDay = _dateComponent(_ESDateComponentFlagNone, self, 0);
    NSDateComponents *today = _dateComponent(_ESDateComponentFlagNone, date, 0);
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}

- (NSDate *)dateByAddingComponents:(NSDateComponentsBlock)block
{
    if (block == nil) {
        return [self dateByAddingDays:0];
    }
    __weakblock NSDateComponents *comp = _dateComponent(_ESDateComponentFlagNone, nil, 0);
    block(comp);
    return [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:self options:0];
}

- (NSDate *)dateBySettingComponents:(NSDateComponentsBlock)block
{
    if (block == nil) {
        return [self dateByAddingDays:0];
    }
    __weakblock NSDateComponents *comp = _dateComponent(_ESDateComponentFlagNone, self, 0);
    block(comp);
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

- (BOOL)isBetweenDates:(NSDate *)beginDate andDate:(NSDate *)endDate
{
    if ([self compare:beginDate] == NSOrderedAscending) {
        return NO;
    }
    
    if ([self compare:endDate] == NSOrderedDescending) {
        return NO;
    }
    
    return YES;
}

@end
