//
//  WSCalendarUtil.h
//  CalendarProj
//
//  Created by wrs on 15/5/21.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSCalendarUtil : NSObject

/**
 *  获取格式化日期
 *
 *  @param date   日期
 *  @param format 日期格式，如：yyyy-MM-dd HH:ss:mm
 *
 *  @return return value description
 */
+ (NSString *)getDateStrWithDate:(NSDate *)date format:(NSString *)format;

/**
 *  获取日期
 *
 *  @param dateStr 日期字符串
 *  @param format  日期格式，如：yyyy-MM-dd HH:ss:mm
 *
 *  @return return value description
 */
+ (NSDate *)getDateWithDateStr:(NSString *)dateStr format:(NSString *)format;

/**
 *  获取当前年份
 *
 *  @return return value description
 */
+ (NSInteger)getCurYear;

/**
 *  获取当前季度
 *             春  夏  秋  冬
 *  @return return value description
 */
+ (NSInteger)getCurQuarter;

/**
 *  获取当前月份
 *
 *  @return return value description
 */
+ (NSInteger)getCurMonth;

/**
 *  获取当前日
 *
 *  @return return value description
 */
+ (NSInteger)getCurDay;

/**
 *  获取当前星期
 *
 *             周日   周一  周二  周三  周四  周五  周六
 *  @return     1      2    3    4     5    6    7
 */
+ (NSInteger)getCurWeekDay;

/**
 *  获取当前月份的天数
 *
 *  @return return value description
 */
+ (NSUInteger)getCurDayNumForMonth;

/**
 *  获取今年的天数
 *
 *  @return return value description
 */
+ (NSUInteger)getCurDayNumForYear;

/**
 *  获取当前月份的周数
 *
 *  @return return value description
 */
+ (NSUInteger)getCurWeekNumForMonth;

/**
 *  获取今年的周数
 *
 *  @return return value description
 */
+ (NSUInteger)getCurWeekNumForYear;

/**
 *  获取某天的年份
 *
 *  @param date date description
 *
 *  @return return value description
 */
+ (NSInteger)getYearWithDate:(NSDate *)date;

/**
 *  获取某天的季度
 *
 *  @param date date description
 *
 *  @return return value description
 */
+ (NSInteger)getQuarterWithDate:(NSDate *)date;

/**
 *  获取某天的月份
 *
 *  @param date date description
 *
 *  @return return value description
 */
+ (NSInteger)getMonthWithDate:(NSDate *)date;

/**
 *  获取某天的星期
 *
 *  @param date date description
 *
 *             周日   周一  周二  周三  周四  周五  周六
 *  @return     1      2    3    4     5    6    7
 */
+ (NSInteger)getWeekDayWithDate:(NSDate *)date;

/**
 *  获取某天的周数
 *
 *  @param date date description
 *
 *  @return return 从1开始
 */
+ (NSInteger)getWeekOfMonthWithDate:(NSDate *)date;

/**
 *  获取某月的天数
 *
 *  @param date date description
 *
 *  @return
 */
+ (NSUInteger)getDayNumForMonthWithDate:(NSDate *)date;

/**
 *  获取某年的天数
 *
 *  @param date date description
 *
 *  @return return value description
 */
+ (NSUInteger)getDayNumForYearWithDate:(NSDate *)date;

/**
 *  获取某月的周数
 *
 *  @param date date description
 *
 *  @return return value description
 */
+ (NSUInteger)getWeekNumForMonthWithDate:(NSDate *)date;

/**
 *  获取某年的周数
 *
 *  @param date date description
 *
 *  @return return value description
 */
+ (NSUInteger)getWeekNumForYearWithDate:(NSDate *)date;

/**
 *  获取几天后是哪一天
 *
 *  @return return value description
 */
+ (NSDate *)getDateFromCurDayWithAfterDays:(NSInteger)afterDays;

/**
 *  获取某天过了几天后的日期
 *
 *  @param fromdate 从哪天开始
 *  @param afterDay 过了几天
 *
 *  @return return value description
 */
+ (NSDate *)getDateFromDate:(NSDate *)fromdate afterDays:(NSInteger)afterDays;

@end
