//
//  ESDateRange.h
//  ESDateHelper
//
//  Created by Bas van Kuijck on 30-07-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+ESDatehelper.h"
#import "ESDateHelper-Include.h"

@interface ESDateRange : NSObject

/**
 * ============================================================================================================
 *
 * @name Properties
 *
 * ============================================================================================================
 */
/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	The fromDate of the dateRange
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
@property (ES_NULLABLE_PROPERTY nonatomic, strong) NSDate *fromDate;
@property (ES_NULLABLE_PROPERTY nonatomic, strong) NSDate *toDate;

/**
 * ============================================================================================================
 *
 * @name Constructors
 *
 * ============================================================================================================
 */

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Class constructor that creates a `ESDateRange` instance with infinite from and to date
 *  @discussion `infinite` means `nil`
 *  @see [ESDateRange initWithFromDate:toDate:]
 *
 *	@return ESDateRange
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
+ (ES_NOTNULLABLE instancetype)infiniteRange;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Class constructor that creates a `ESDateRange` instance with a specific from and to date
 *  @discussion The `toDate` cannot preceed the `fromDate`
 *  @see [ESDateRange initWithFromDate:toDate:]
 *
 *	@return ESDateRange
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
+ (ES_NOTNULLABLE instancetype)rangeFromDate:(ES_NULLABLE NSDate *)from toDate:(ES_NULLABLE NSDate *)to;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Class constructor that creates a `ESDateRange` instance with to date
 *  @discussion `infinite` means `nil`
 *  @see [ESDateRange initWithFromDate:toDate:]
 *
 *	@return ESDateRange
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
+ (ES_NOTNULLABLE instancetype)rangeFromDate:(ES_NULLABLE NSDate *)date;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Class constructor that creates a `ESDateRange` instance with from date
 *  @discussion `infinite` means `nil`
 *  @see [ESDateRange initWithFromDate:toDate:]
 *
 *	@return ESDateRange
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
+ (ES_NOTNULLABLE instancetype)rangeToDate:(ES_NULLABLE NSDate *)date;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Instance constructor that creates a `ESDateRange` instance with a specific from and to date
 *  @discussion The `toDate` cannot preceed the `fromDate`
 *
 *	@return ESDateRange
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
- (ES_NOTNULLABLE instancetype)initWithFromDate:(ES_NULLABLE NSDate *)fromDate toDate:(ES_NULLABLE NSDate *)toDate NS_DESIGNATED_INITIALIZER;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Instance constructor that creates a `ESDateRange` instance with a specific from and infinite `toDate`
 *  @discussion `infinite` means `nil`
 *  @see [ESDateRange initWithFromDate:toDate:]
 *
 *	@return ESDateRange
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
- (ES_NOTNULLABLE instancetype)initWithFromDate:(ES_NULLABLE NSDate *)fromDate;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Instance constructor that creates a `ESDateRange` instance with a specific toDate and infinite `fromDate`
 *  @discussion `infinite` means `nil`
 *  @see [ESDateRange initWithFromDate:toDate:]
 *
 *	@return ESDateRange
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
- (ES_NOTNULLABLE instancetype)initWithToDate:(ES_NULLABLE NSDate *)toDate;

/**
 * ============================================================================================================
 *
 * @name Contains
 *
 * ============================================================================================================
 */

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Checks if a specific date is between the from and to date
 *
 *	@param date	NSDate
 *
 *	@return BOOL Indicating if the date is in the range
 *
 *	@since 1.0
 *	@date 30/07/2015
 */
- (BOOL)containsDate:(ES_NOTNULLABLE NSDate *)date;

/**
 * ============================================================================================================
 *
 * @name Shifting
 *
 * ============================================================================================================
 */
- (void)shiftWithSeconds:(NSInteger)seconds;
- (void)shiftWithMinutes:(NSInteger)minutes;
- (void)shiftWithHours:(NSInteger)hours;
- (void)shiftWithDays:(NSInteger)days;
- (void)shiftWithWeeks:(NSInteger)weeks;
- (void)shiftWithMonths:(NSInteger)months;
- (void)shiftWithYears:(NSInteger)years;
- (void)shiftWithQuarters:(NSInteger)quarters;
- (void)shiftWithComponents:(ES_NOTNULLABLE NSDateComponentsBlock)componentsBlock;
@end
