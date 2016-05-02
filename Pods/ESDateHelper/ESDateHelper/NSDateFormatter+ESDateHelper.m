//
//  NSDateFormatter+ESDateHelper.m
//  ESDateHelper
//
//  Created by Bas van Kuijck on 30-07-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

#import "NSDateFormatter+ESDateHelper.h"

@implementation NSDateFormatter (ESDateHelper)

+ (ES_NULLABLE NSString *)stringFormatForFormat:(NSDateFormatterFormat)format
{
    return [self.class stringFormatForFormat:format timeStyle:NSDateFormatterTimeStyleNone];
}

+ (ES_NULLABLE NSString *)stringFormatForFormat:(NSDateFormatterFormat)format timeStyle:(NSDateFormatterTimeStyle)timeStyle
{
    switch (format) {
        case NSDateFormatterFormatNone:
        default:
            return nil;
        case NSDateFormatterFormatBasic:
            if (timeStyle == NSDateFormatterTimeStyleTime) {
                return @"yyyyMMdd'T'HHmmss.SSSZ";
            } else if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"yyyyMMdd'T'HHmmssZ";
            }
            return @"yyyyMMdd";
            
        case NSDateFormatterFormatBasicOrdinalDate:
            if (timeStyle == NSDateFormatterTimeStyleTime) {
                return @"yyyyDDD'T'HHmmss.SSSZ";
            } else if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"yyyyDDD'T'HHmmssZ";
            }

            return @"yyyyDDD";
            
        case NSDateFormatterFormatBasicTime:
            if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"HHmmssZ";
            }
            return @"HHmmss.SSSZ";
           
        case NSDateFormatterFormatBasicTTime:
            if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"T'HHmmssZ";
            }
            return @"'T'HHmmss.SSSZ";
            
        
        case NSDateFormatterFormatBasicWeekDate:
            if (timeStyle == NSDateFormatterTimeStyleTime) {
                return @"xxxx'W'wwe'T'HHmmss.SSSZ";
            } else if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"xxxx'W'wwe'T'HHmmssZ";
            }
            return @"xxxx'W'wwe";
            
        case NSDateFormatterFormatDate:
            if (timeStyle == NSDateFormatterTimeStyleTime) {
                return @"yyyy-MM-dd'T'HH:mm:ss.SSS";
            } else if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"yyyy-MM-dd'T'HH:mm:ss";
            }
            return @"yyyy-MM-dd";
            
        case NSDateFormatterFormatDateTime:
            if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"yyyy-MM-dd'T'HH:mm:ssZZ";
            }
            return @"yyyy-MM-dd'T'HH:mm:ss.SSSZZ";
            
        case NSDateFormatterFormatHourMinuteSecondFraction:
            if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"HH:mm:ss";
            }
            return @"HH:mm:ss.SSS";
            
        case NSDateFormatterFormatTime:
            if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"HH:mm:ssZZ";
            }
            return @"HH:mm:ss.SSSZZ";
            
        case NSDateFormatterFormatOrdinalDate:
            if (timeStyle == NSDateFormatterTimeStyleTime) {
                return @"yyyy-DDD'T'HH:mm:ss.SSSZZ";
            } else if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"yyyy-DDD'T'HH:mm:ssZZ";
            }
            return @"yyyy-DDD";
            
            
        case NSDateFormatterFormatTTime:
            if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"'T'HH:mm:ssZZ";
            }
            return @"'T'HH:mm:ss.SSSZZ";
            
        case NSDateFormatterFormatDateHourMinuteSecondFraction:
            if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"yyyy-MM-dd'T'HH:mm:ss";
            }
            return @"yyyy-MM-dd'T'HH:mm:ss.SSS";
        
        case NSDateFormatterFormatWeekDate:
            if (timeStyle == NSDateFormatterTimeStyleTime) {
                return @"xxxx-'W'ww-e'T'HH:mm:ss.SSSZZ";
            } else if (timeStyle == NSDateFormatterTimeStyleNoMillis) {
                return @"xxxx-'W'ww-e'T'HH:mm:ssZZ";
            }
            return @"xxxx-'W'ww-e";
    }
    return nil;
}

+ (ES_NOTNULLABLE instancetype)dateFormatterWithDateFormat:(NSDateFormatterFormat)format
{
    return [self.class dateFormatterWithDateFormat:format timeStyle:NSDateFormatterTimeStyleNone];
}

+ (ES_NOTNULLABLE instancetype)dateFormatterWithDateFormat:(NSDateFormatterFormat)format timeStyle:(NSDateFormatterTimeStyle)timeStyle
{
    NSString *stringFormat = [self.class stringFormatForFormat:format timeStyle:timeStyle];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (stringFormat != nil) {
        [formatter setDateFormat:stringFormat];
    }
    return formatter;
}

@end