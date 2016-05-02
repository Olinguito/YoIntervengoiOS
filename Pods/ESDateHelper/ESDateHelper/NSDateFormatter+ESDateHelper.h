//
//  NSDateFormatter+ESDateHelper.h
//  ESDateHelper
//
//  Created by Bas van Kuijck on 30-07-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESDateHelper-Include.h"

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *  ISO8601 is the international standard for data interchange. It defines a framework, rather than an absolute standard. As a result this provider has a number of methods that represent common uses of the framework. The most common formats are date, time, and dateTime.
 *
 *	@since 1.0
 *	@date 30/07/2015
 */

typedef NS_ENUM(NSUInteger, NSDateFormatterFormat) {
    NSDateFormatterFormatNone = 0,
    /**
     * Returns a basic formatter for a full date as four digit year, two digit month of year, and two digit day of month (yyyyMMdd).
     *  @param None: yyyyMMdd
     *  @param Time: yyyyMMdd'T'HHmmss.SSSZ
     *  @param NoMillis: yyyyMMdd'T'HHmmssZ
     */
    NSDateFormatterFormatBasic,
    /**
     *  Returns a formatter for a full ordinal date, using a four digit year and three digit dayOfYear (yyyyDDD).
     *  @param None: yyyyDDD
     *  @param Time: yyyyDDD'T'HHmmss.SSSZ
     *  @param NoMillis: yyyyDDD'T'HHmmssZ
     */
    NSDateFormatterFormatBasicOrdinalDate,
    /**
     *  Returns a basic formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit millis, and time zone offset (HHmmss.SSSZ).
     *  @param None/Time: HHmmss.SSSZ
     *  @param NoMillis: HHmmssZ
     */
    NSDateFormatterFormatBasicTime,
    /**
     * Returns a basic formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit millis, and time zone offset prefixed by 'T' ('T'HHmmss.SSSZ).
     *  @param None/Time: T'HHmmss.SSSZ
     *  @param NoMillis: T'HHmmss
     */
    NSDateFormatterFormatBasicTTime,
    /**
     * Returns a basic formatter for a full date as four digit weekyear, two digit week of weekyear, and one digit day of week (xxxx'W'wwe).
     *  @param None: xxxx'W'wwe
     *  @param Time: xxxx'W'wwe'T'HHmmss.SSSZ
     *  @param NoMillis: xxxx'W'wwe'T'HHmmssZ
     */
    NSDateFormatterFormatBasicWeekDate,
    /**
     * Returns a formatter for a full date as four digit year, two digit month of year, and two digit day of month (yyyy-MM-dd).
     *  @param None: yyyy-MM-dd
     *  @param Time: yyyy-MM-dd'T'HH:mm:ss.SSSZZ
     *  @param NoMillis: yyyy-MM-dd'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatDate,
    /**
     * Returns a formatter that combines a full date, two digit hour of day, two digit minute of hour, two digit second of minute, and three digit fraction of second (yyyy-MM-dd'T'HH:mm:ss.SSS).
     *  @param None/Time: yyyy-MM-dd'T'HH:mm:ss.SSS
     *  @param NoMillis: yyyy-MM-dd'T'HH:mm:ss
     */
    NSDateFormatterFormatDateHourMinuteSecondFraction,
    /**
     * Returns a formatter that combines a full date and time, separated by a 'T' (yyyy-MM-dd'T'HH:mm:ss.SSSZZ).
     *  @param None/Time: yyyy-MM-dd'T'HH:mm:ss.SSSZZ
     *  @param NoMillis: yyyy-MM-dd'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatDateTime,
    /**
     * Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, and three digit fraction of second (HH:mm:ss.SSS).
     *  @param None/Time: HH:mm:ss.SSS
     *  @param NoMillis: HH:mm:ss
     */
    NSDateFormatterFormatHourMinuteSecondFraction,
    /**
     * Returns a formatter for a full ordinal date, using a four digit year and three digit dayOfYear (yyyy-DDD).
     *  @param None: yyyy-MM-dd
     *  @param Time: yyyy-DDD'T'HH:mm:ss.SSSZZ
     *  @param NoMillis: yyyy-DDD'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatOrdinalDate,
    /**
     * Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit fraction of second, and time zone offset prefixed by 'T' ('T'HH:mm:ss.SSSZZ).
     *  @param None/Time: 'T'HH:mm:ss.SSSZZ
     *  @param NoMillis: 'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatTTime,
    /**
     * Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit fraction of second, and time zone offset (HH:mm:ss.SSSZZ).
     *  @param None/Time: HH:mm:ss.SSSZZ
     *  @param NoMillis: HH:mm:ssZZ
     */
    NSDateFormatterFormatTime,
    /**
     * Returns a formatter for a full date as four digit weekyear, two digit week of weekyear, and one digit day of week (xxxx-'W'ww-e).
     *  @param None: xxxx-'W'ww-e
     *  @param Time: xxxx-'W'ww-e'T'HH:mm:ss.SSSZZ
     *  @param NoMillis: xxxx-'W'ww-e'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatWeekDate
};

typedef NS_ENUM(NSUInteger, NSDateFormatterTimeStyle) {
    NSDateFormatterTimeStyleNone = 0,
    NSDateFormatterTimeStyleTime,
    NSDateFormatterTimeStyleNoMillis
};

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	@link http://joda-time.sourceforge.net/apidocs/org/joda/time/format/ISODateTimeFormat.html
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
@interface NSDateFormatter (ESDateHelper)
/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Returns a `NSDateFormatter` with the specific `NSDateFormatterFormat` and `NSDateFormatterTimeStyle`
 *
 *	@param format		NSDateFormatterFormat
 *	@param timeStyle	NSDateFormatterFormat
 *
 *	@return NSDateFormatter instance
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
+ (ES_NOTNULLABLE instancetype)dateFormatterWithDateFormat:(NSDateFormatterFormat)format timeStyle:(NSDateFormatterTimeStyle)timeStyle;


/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Returns a `NSDateFormatter` with the specific `NSDateFormatterFormat` and `NSDateFormatterTimeStyleNone` as `NSDateFormatterTimeStyle`
 *
 *	@param format		NSDateFormatterFormat
 *
 *	@return NSDateFormatter instance
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
+ (ES_NOTNULLABLE instancetype)dateFormatterWithDateFormat:(NSDateFormatterFormat)format;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Returns a string date format with the specific `NSDateFormatterFormat` and `NSDateFormatterTimeStyle`
 *
 *	@param format		NSDateFormatterFormat
 *	@param timeStyle	NSDateFormatterTimeStyle
 *
 *	@return NSString
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
+ (ES_NULLABLE NSString *)stringFormatForFormat:(NSDateFormatterFormat)format timeStyle:(NSDateFormatterTimeStyle)timeStyle;


/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Returns a string date format with the specific `NSDateFormatterFormat` and `NSDateFormatterTimeStyleNone` as `NSDateFormatterTimeStyle`
 *
 *	@param format		NSDateFormatterFormat
 *
 *	@return NSString
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
+ (ES_NULLABLE NSString *)stringFormatForFormat:(NSDateFormatterFormat)format;
@end
