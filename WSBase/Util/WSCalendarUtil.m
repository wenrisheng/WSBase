//
//  WSCalendarUtil.m
//  CalendarProj
//
//  Created by wrs on 15/5/21.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSCalendarUtil.h"

@implementation WSCalendarUtil

+ (NSString *)getDateStrWithDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSDate *)getDateWithDateStr:(NSString *)dateStr format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

+ (NSInteger)getCurYear
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateComponents.year;
}

+ (NSInteger)getCurQuarter
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitQuarter fromDate:[NSDate date]];
    return dateComponents.quarter;
}

+ (NSInteger)getCurMonth
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitMonth fromDate:[NSDate date]];
    return dateComponents.month;
}

+ (NSInteger)getCurDay
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitDay fromDate:[NSDate date]];
    return dateComponents.day;
}

+ (NSInteger)getCurWeekDay
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    return dateComponents.weekday;
}


+ (NSUInteger)getCurDayNumForMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    return range.length;
}

+ (NSUInteger)getCurDayNumForYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:[NSDate date]];
    return range.length;
}

+ (NSUInteger)getCurWeekNumForMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    return range.length;
}

+ (NSUInteger)getCurWeekNumForYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:[NSDate date]];
    return range.length;
}

+ (NSInteger)getYearWithDate:(NSDate *)date
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear fromDate:date];
    return dateComponents.year;
}

+ (NSInteger)getQuarterWithDate:(NSDate *)date
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitQuarter fromDate:date];
    return dateComponents.year;
}

+ (NSInteger)getMonthWithDate:(NSDate *)date
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitMonth fromDate:date];
    return dateComponents.month;
}

+ (NSInteger)getWeekDayWithDate:(NSDate *)date
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitWeekday fromDate:date];
    return dateComponents.weekday;
}

+ (NSInteger)getWeekOfMonthWithDate:(NSDate *)date
{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitWeekOfMonth fromDate:date];
    return dateComponents.weekOfMonth;
}

+ (NSUInteger)getDayNumForMonthWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

+ (NSUInteger)getDayNumForYearWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:date];
    return range.length;
}

+ (NSUInteger)getWeekNumForMonthWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

+ (NSUInteger)getWeekNumForYearWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:date];
    return range.length;
}

+ (NSDate *)getDateFromCurDayWithAfterDays:(NSInteger)afterDays
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = afterDays;
    NSDate *resultDay = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    return resultDay;
}

+ (NSDate *)getDateFromDate:(NSDate *)fromdate afterDays:(NSInteger)afterDays;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = afterDays;
    NSDate *resultDay = [calendar dateByAddingComponents:dateComponents toDate:fromdate options:0];
    return resultDay;
}

@end
