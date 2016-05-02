# ESDateHelper

[![Build](https://travis-ci.org/e-sites/ESDateHelper.svg)](https://travis-ci.org/e-sites/ESDateHelper)
[![Coverage Status](https://coveralls.io/repos/e-sites/ESDateHelper/badge.svg?branch=master&service=github&cacheBuster=123)](https://coveralls.io/github/e-sites/ESDateHelper?branch=master)
[![Platform](https://cocoapod-badges.herokuapp.com/p/ESDateHelper/badge.png)](http://cocoadocs.org/docsets/ESDateHelper)
[![Version](https://cocoapod-badges.herokuapp.com/v/ESDateHelper/badge.png)](http://cocoadocs.org/docsets/ESDateHelper)

Helper category for making the usage of NSDates easier

## Class methods
```objective-c
+ (BOOL)is24HourNotation;
+ (BOOL)isTimeInPast:(NSString *)time;
```

# NSDate category

## Class methods
```objective-c
+ (BOOL)isLeapYear:(NSInteger)year;
```

## Properties

```objective-c
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
```

## Instance methods

```objective-c
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

- (NSInteger)secondsFromDate:(NSDate *)date;
- (NSInteger)minutesFromDate:(NSDate *)date;
- (NSInteger)hoursFromDate:(NSDate *)date;
- (NSInteger)daysFromDate:(NSDate *)date;
- (NSInteger)weeksFromDate:(NSDate *)date;

- (BOOL)isBetweenDates:(NSDate *)beginDate andDate:(NSDate *)endDate;
```

# ESDateRange class

## Class methods

```objective-c

+ (notnull instancetype)infiniteRange;
+ (notnull instancetype)rangeFromDate:(nullable NSDate *)from toDate:(nullable NSDate *)to;
+ (notnull instancetype)rangeFromDate:(nullable NSDate *)date;
+ (notnull instancetype)rangeToDate:(nullable NSDate *)date;
```

## Instance methods

```objective-c
- (notnull instancetype)initWithFromDate:(nullable NSDate *)fromDate toDate:(nullable NSDate *)toDate;
- (notnull instancetype)initWithFromDate:(nullable NSDate *)fromDate;
- (notnull instancetype)initWithToDate:(nullable NSDate *)toDate;

- (BOOL)containsDate:(notnull NSDate *)date;

- (void)shiftWithSeconds:(NSInteger)seconds;
- (void)shiftWithMinutes:(NSInteger)minutes;
- (void)shiftWithHours:(NSInteger)hours;
- (void)shiftWithDays:(NSInteger)days;
- (void)shiftWithWeeks:(NSInteger)weeks;
- (void)shiftWithMonths:(NSInteger)months;
- (void)shiftWithYears:(NSInteger)years;
- (void)shiftWithEras:(NSInteger)eras;
- (void)shiftWithComponents:(notnull NSDateComponentsBlock)componentsBlock;
```

## Properties

```objective-c
@property (nullable, nonatomic, strong) NSDate *fromDate;
@property (nullable, nonatomic, strong) NSDate *toDate;
```