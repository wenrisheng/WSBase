//
//  BaseUtility.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSBaseUtil : NSObject

/**
 *  对象转json字符串
 *
 *  @param obj 对象
 *
 *  @return 转后的字符串
 */
+ (NSString *)objToJson:(id)obj;

/**
 *  json字符串转字典
 *
 *  @param jsonString json字符串
 *
 *  @return 转后的字典
 */
+ (NSDictionary *)jsonToDic:(NSString *)jsonString;

/**
 *  获取from到to的随机数，包含from与to
 *
 *  @param from
 *  @param to
 *
 *  @return
 */
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 *  日期转换格式化字符串
 *
 *  @param date   日期
 *  @param format  日期格式   如：yyyy-MM-dd HH:mm:ss
 *
 *  @return
 */
+ (NSString *)getDateStrWithDate:(NSDate *)date format:(NSString *)format;

/**
 *  将字典里的Number转换成字符串 如：服务器返回的json数据中的1，2……等整形数据没有加""时对应的是NSNumber类型，需要转换成NSString类型
 *
 *  @param dic
 *
 *  @return
 */
+ (NSMutableDictionary *)changNumberToStringForDictionary:(NSDictionary *)dic;



@end
