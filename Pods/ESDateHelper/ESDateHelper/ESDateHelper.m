//
//  ESDateHelper.m
//  iOS.Library
//
//  Created by Bas van Kuijck on 16-04-14.
//
//

#import "ESDateHelper.h"

@interface ESDateHelper ()

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

+ (BOOL)isTimeInPast:(NSString *)time
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setTimeStyle:NSDateFormatterShortStyle];
    [fm setLocale:[NSLocale localeWithLocaleIdentifier:@"nl_NL"]];
    // H:m
    NSDate *d = [fm dateFromString:time];
    if (d == nil) {
        [fm setTimeStyle:NSDateFormatterMediumStyle];
        
        // H:m:s
        d = [fm dateFromString:time];
        if (d == nil) {
            [fm setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
            
            // h:m a
            d = [fm dateFromString:time];
            if (d == nil) {
                [fm setTimeStyle:NSDateFormatterShortStyle];
                
                // h:m:s a
                d = [fm dateFromString:time];
            }
        }
    }
    NSAssert(d != nil, @"Unknown time format for '%@', should by NSDateFormatterShortStyle or NSDateFormatterMediumStyle", time);
    NSDate *now = [[NSDate date] dateBySettingComponents:^(NSDateComponents *comp) {
        comp.hour = d.hour;
        comp.second = d.second;
        comp.minute = d.minute;
    }];
    return [[NSDate date] compare:now] == NSOrderedDescending;
}

#pragma mark - NSDateComponents
// ____________________________________________________________________________________________________________________


@end
