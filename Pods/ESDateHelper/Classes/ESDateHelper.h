//
//  ESDateHelper.h
//  iOS.Library
//
//  Created by Bas van Kuijck on 16-04-14.
//
//

#import <Foundation/Foundation.h>

@interface ESDateHelper : NSObject
+ (BOOL)is24HourNotation;
@end

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

typedef void (^NSDateComponentsBlock)(NSDateComponents *comp);

- (BOOL)isSameDay:(NSDate *)date;

- (NSDate *)dateByAddingComponents:(NSDateComponentsBlock)block;
- (NSDate *)dateBySettingComponents:(NSDateComponentsBlock)block;

- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateBySettingHours:(NSInteger)hours;

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateBySettingMinutes:(NSInteger)minutes;

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;
- (NSDate *)dateBySettingSeconds:(NSInteger)seconds;

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)dateBySettingWeeks:(NSInteger)weeks;

- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateBySettingDays:(NSInteger)days;

- (NSDate *)dateBySettingWeekDay:(NSInteger)weekday;

- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateBySettingMonths:(NSInteger)months;

- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateBySettingYears:(NSInteger)years;

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters;
- (NSDate *)dateBySettingQuarters:(NSInteger)quarters;

- (NSDate *)dateByAddingEras:(NSInteger)eras;
- (NSDate *)dateBySettingEras:(NSInteger)eras;

- (NSDate *)dateAtBeginningOfDay;

- (NSDate *)dateOfFirstDayOfFirstWeekForWeekDay:(NSInteger)weekday;

- (NSInteger)secondsFromDate:(NSDate *)date;
- (NSInteger)minutesFromDate:(NSDate *)date;
- (NSInteger)hoursFromDate:(NSDate *)date;
- (NSInteger)daysFromDate:(NSDate *)date;
- (NSInteger)weeksFromDate:(NSDate *)date;

- (BOOL)isBetweenDates:(NSDate *)beginDate andDate:(NSDate *)endDate;

@end