//
//  ESDateRange.m
//  ESDateHelper
//
//  Created by Bas van Kuijck on 30-07-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

#import "ESDateRange.h"

#define checkDatesMacro() NSAssert(_ignorePreceedCheck || _toDate == nil || _fromDate == nil || [_fromDate compare:_toDate] != NSOrderedDescending, @"fromDate (%@) should preceed toDate (%@)", _fromDate, _toDate)
#define ignorePreceedCheck(block) [self _ignorePreceedCheck:block]

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

@implementation ESDateRange
{
    BOOL _ignorePreceedCheck;
}

@synthesize fromDate=_fromDate,toDate=_toDate;

#pragma mark - Constructor
// ____________________________________________________________________________________________________________________

+ (ES_NOTNULLABLE instancetype)infiniteRange
{
    return [self.class rangeFromDate:nil];
}

+ (ES_NOTNULLABLE instancetype)rangeFromDate:(ES_NULLABLE NSDate *)from toDate:(ES_NULLABLE NSDate *)to
{
    return [[self.class alloc] initWithFromDate:from toDate:to];
}

+ (ES_NOTNULLABLE instancetype)rangeFromDate:(ES_NULLABLE NSDate *)date
{
    return [[self.class alloc] initWithFromDate:date];
}

+ (ES_NOTNULLABLE instancetype)rangeToDate:(ES_NULLABLE NSDate *)date
{
    return [[self.class alloc] initWithToDate:date];
}

- (ES_NOTNULLABLE instancetype)initWithToDate:(ES_NULLABLE NSDate *)toDate
{
    return [self initWithFromDate:nil toDate:toDate];
}

- (ES_NOTNULLABLE instancetype)initWithFromDate:(ES_NULLABLE NSDate *)fromDate
{
    return [self initWithFromDate:fromDate toDate:nil];
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (ES_NOTNULLABLE instancetype)initWithFromDate:(ES_NULLABLE NSDate *)fromDate toDate:(ES_NULLABLE NSDate *)toDate
{
    if (self = [super init]) {
        self.fromDate = fromDate;
        self.toDate = toDate;
    }
    return self;
}

- (void)setFromDate:(ES_NULLABLE NSDate *)fromDate
{
    _fromDate = fromDate;
    checkDatesMacro();
}

- (void)setToDate:(ES_NULLABLE NSDate *)toDate
{
    _toDate = toDate;
    checkDatesMacro();
}

#pragma mark - Private helpers
// ____________________________________________________________________________________________________________________

- (void)_ignorePreceedCheck:(ES_NOTNULLABLE void (^)())block
{
    _ignorePreceedCheck = YES;
    block();
    _ignorePreceedCheck = NO;
}

#pragma mark - Helpers
// ____________________________________________________________________________________________________________________

- (ES_NOTNULLABLE NSString *)description
{
    return [NSString stringWithFormat:
            @"<%@: %p> %@ - %@",
            NSStringFromClass(self.class),
            self,
            self.fromDate == nil ? @"infinite" : self.fromDate.description,
            self.toDate == nil ? @"infinite" : self.toDate.description];
}

#pragma mark - Shifting
// ____________________________________________________________________________________________________________________

- (void)shiftWithSeconds:(NSInteger)seconds
{
    ignorePreceedCheck(^{
        self.fromDate = [self.fromDate dateByAddingSeconds:seconds];
        self.toDate = [self.toDate dateByAddingSeconds:seconds];
    });
}

- (void)shiftWithMinutes:(NSInteger)minutes
{
    ignorePreceedCheck(^{
        self.fromDate = [self.fromDate dateByAddingMinutes:minutes];
        self.toDate = [self.toDate dateByAddingMinutes:minutes];
    });
}

- (void)shiftWithHours:(NSInteger)hours
{
    ignorePreceedCheck(^{
        self.fromDate = [self.fromDate dateByAddingHours:hours];
        self.toDate = [self.toDate dateByAddingHours:hours];
    });
}

- (void)shiftWithDays:(NSInteger)days
{
    ignorePreceedCheck(^{
        self.fromDate = [self.fromDate dateByAddingDays:days];
        self.toDate = [self.toDate dateByAddingDays:days];
    });
}

- (void)shiftWithWeeks:(NSInteger)weeks
{
    ignorePreceedCheck(^{
        self.fromDate = [self.fromDate dateByAddingWeeks:weeks];
        self.toDate = [self.toDate dateByAddingWeeks:weeks];
    });
}

- (void)shiftWithMonths:(NSInteger)months
{
    ignorePreceedCheck(^{
        self.fromDate = [self.fromDate dateByAddingMonths:months];
        self.toDate = [self.toDate dateByAddingMonths:months];
    });
}

- (void)shiftWithYears:(NSInteger)years
{
    ignorePreceedCheck(^{
        self.fromDate = [self.fromDate dateByAddingYears:years];
        self.toDate = [self.toDate dateByAddingYears:years];
    });
}

- (void)shiftWithQuarters:(NSInteger)quarters
{
    ignorePreceedCheck(^{
        self.fromDate = [self.fromDate dateByAddingQuarters:quarters];
        self.toDate = [self.toDate dateByAddingQuarters:quarters];
    });
}

- (void)shiftWithComponents:(ES_NOTNULLABLE NSDateComponentsBlock)componentsBlock
{
    ignorePreceedCheck(^{
        self.fromDate = [self.fromDate dateByAddingComponents:componentsBlock];
        self.toDate = [self.toDate dateByAddingComponents:componentsBlock];
    });
}

#pragma mark - Contains
// ____________________________________________________________________________________________________________________

- (BOOL)containsDate:(ES_NOTNULLABLE NSDate *)date
{
    BOOL beforeTo = YES;
    if (self.toDate != nil) {
        beforeTo = ([date compare:self.toDate] != NSOrderedDescending);
    }
    
    BOOL afterFor = YES;
    if (self.fromDate != nil) {
        afterFor = ([date compare:self.fromDate] != NSOrderedAscending);
    }
    
    return afterFor && beforeTo;
}

@end

#pragma clang diagnostic pop