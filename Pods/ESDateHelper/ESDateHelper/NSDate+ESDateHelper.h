//
//  NSDate+ESDateHelper.h
//  ESDateHelper
//
//  Created by Bas van Kuijck on 30-07-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESDateHelper-Include.h"

@interface NSDate (ESDateHelper)

@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger week;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger era;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger quarter;
@property (nonatomic, readonly, getter=isToday) BOOL today;
@property (nonatomic, readonly, getter=isInCurrentWeek) BOOL inCurrentWeek;
@property (nonatomic, readonly, getter=isLeapYear) BOOL leapYear;

+ (BOOL)isLeapYear:(NSInteger)year;

typedef void (^NSDateComponentsBlock)(NSDateComponents *ES_NOTNULLABLE_PARAMETER comp);

- (BOOL)isSameDay:(ES_NOTNULLABLE NSDate *)date;

- (ES_NOTNULLABLE NSDate *)dateByAddingComponents:(ES_NOTNULLABLE NSDateComponentsBlock)block;
- (ES_NOTNULLABLE NSDate *)dateBySettingComponents:(ES_NOTNULLABLE NSDateComponentsBlock)block;

- (ES_NOTNULLABLE NSDate *)dateByAddingHours:(NSInteger)hours;
- (ES_NOTNULLABLE NSDate *)dateBySettingHours:(NSInteger)hours;

- (ES_NOTNULLABLE NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (ES_NOTNULLABLE NSDate *)dateBySettingMinutes:(NSInteger)minutes;

- (ES_NOTNULLABLE NSDate *)dateByAddingSeconds:(NSInteger)seconds;
- (ES_NOTNULLABLE NSDate *)dateBySettingSeconds:(NSInteger)seconds;

- (ES_NOTNULLABLE NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (ES_NOTNULLABLE NSDate *)dateBySettingWeeks:(NSInteger)weeks;

- (ES_NOTNULLABLE NSDate *)dateByAddingDays:(NSInteger)days;
- (ES_NOTNULLABLE NSDate *)dateBySettingDays:(NSInteger)days;

- (ES_NOTNULLABLE NSDate *)dateBySettingWeekDay:(NSInteger)weekday;

- (ES_NOTNULLABLE NSDate *)dateByAddingMonths:(NSInteger)months;
- (ES_NOTNULLABLE NSDate *)dateBySettingMonths:(NSInteger)months;

- (ES_NOTNULLABLE NSDate *)dateByAddingYears:(NSInteger)years;
- (ES_NOTNULLABLE NSDate *)dateBySettingYears:(NSInteger)years;

- (ES_NOTNULLABLE NSDate *)dateByAddingQuarters:(NSInteger)quarters;
- (ES_NOTNULLABLE NSDate *)dateBySettingQuarters:(NSInteger)quarters;

- (ES_NOTNULLABLE NSDate *)dateByAddingEras:(NSInteger)eras;
- (ES_NOTNULLABLE NSDate *)dateBySettingEras:(NSInteger)eras;

- (ES_NOTNULLABLE NSDate *)dateAtBeginningOfDay;

- (ES_NOTNULLABLE NSDate *)dateOfFirstDayOfFirstWeekForWeekDay:(NSInteger)weekday;

- (NSInteger)secondsFromDate:(ES_NOTNULLABLE NSDate *)date;
- (NSInteger)minutesFromDate:(ES_NOTNULLABLE NSDate *)date;
- (NSInteger)hoursFromDate:(ES_NOTNULLABLE NSDate *)date;
- (NSInteger)daysFromDate:(ES_NOTNULLABLE NSDate *)date;
- (NSInteger)weeksFromDate:(ES_NOTNULLABLE NSDate *)date;

- (BOOL)isBetweenDates:(ES_NULLABLE NSDate *)beginDate andDate:(ES_NULLABLE NSDate *)endDate;

@end