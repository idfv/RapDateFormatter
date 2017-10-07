//
//  RapDateFormatter.m
//
//  Created by RapKit on 2017/6/21.
//  Copyright © 2017 RapKit. All rights reserved.
//

#import "RapDateFormatter.h"

@implementation RapDateFormatter

+ (NSString *)dateFormatWithDate:(NSDate *)date
{
    NSString *resultStr = @"";
    NSDate *currDate    = [NSDate date];
    
    // Calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Components
    NSDateComponents *componentSec  = [calendar components:NSCalendarUnitSecond fromDate:date toDate:currDate options:NSCalendarWrapComponents];
    NSDateComponents *componentMin  = [calendar components:NSCalendarUnitMinute fromDate:date toDate:currDate options:NSCalendarWrapComponents];
    NSDateComponents *componentHour = [calendar components:NSCalendarUnitHour fromDate:date toDate:currDate options:NSCalendarWrapComponents];
    
    // Formatter
    NSDateFormatter *formatterHourMinute    = [[NSDateFormatter alloc] init];
    formatterHourMinute.dateFormat          = @"HH:mm";
    
    NSDateFormatter *formatterMonthDay      = [[NSDateFormatter alloc] init];
    formatterMonthDay.dateFormat            = @"M-d";
    
    NSDateFormatter *formatterYearMonthDay  = [[NSDateFormatter alloc] init];
    formatterYearMonthDay.dateFormat        = @"yyyy-M-d";
    
    // Days
    NSInteger days = [self _componentDaysWithCalendar:calendar from:date to:currDate];
    
    // Calc
    if (componentSec.second < 60) {
        resultStr = @"Just";
    }else if (componentMin.minute < 60) {
        NSInteger minute = componentMin.minute;
        resultStr = [NSString stringWithFormat:@"%@ minute%@ ago", @(minute), (minute > 1)?@"s":@""];
    }else if (componentHour.hour < 24) {
        NSInteger hour = componentHour.hour;
        resultStr = [NSString stringWithFormat:@"%@ hour%@ ago", @(hour), (hour > 1)?@"s":@""];
    }else if (days < 2) {
        resultStr = [NSString stringWithFormat:@"Yesterday %@", [formatterHourMinute stringFromDate:date]];
    }else if (days < 3) {
        resultStr = [NSString stringWithFormat:@"Before yesterday %@", [formatterHourMinute stringFromDate:date]];
    }else if (days < 10) {
        resultStr = [NSString stringWithFormat:@"%@ day%@ ago", @(days), (days > 1)?@"s":@""];
    }else if ([calendar component:NSCalendarUnitYear fromDate:date] == [calendar component:NSCalendarUnitYear fromDate:currDate]) {
        resultStr = [formatterMonthDay stringFromDate:date];
    }else{
        resultStr = [formatterYearMonthDay stringFromDate:date];
    }
    
    return resultStr;
}

+ (NSInteger)_componentDaysWithCalendar:(NSCalendar *)calendar from:(NSDate *)fromDate to:(NSDate *)toDate
{
    fromDate    = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:fromDate options:NSCalendarWrapComponents];
    toDate      = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:toDate options:NSCalendarWrapComponents];
    
    return [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:NSCalendarWrapComponents].day;
}

@end
