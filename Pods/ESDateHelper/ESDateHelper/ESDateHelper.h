//
//  ESDateHelper.h
//  iOS.Library
//
//  Created by Bas van Kuijck on 16-04-14.
//
//

#import <Foundation/Foundation.h>
#import "NSDate+ESDateHelper.h"
#import "ESDateRange.h"
#import "NSDateFormatter+ESDateHelper.h"

@interface ESDateHelper : NSObject
+ (BOOL)is24HourNotation;
+ (BOOL)isTimeInPast:(ES_NOTNULLABLE NSString *)time;
@end
