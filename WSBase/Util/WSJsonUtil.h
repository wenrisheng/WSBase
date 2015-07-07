//
//  WSJsonUtil.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/7/3.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSJsonUtil : NSObject

/**
 *  对象转json字符串
 *
 *  @param obj 对象
 *
 *  @return 转后的字符串
 */
+ (NSString *)convertObjToJson:(id)obj;

/**
 *  json字符串转字典
 *
 *  @param jsonStr json字符串
 *
 *  @return 转后的字典
 */
+ (NSDictionary *)convertJsonToDic:(NSString *)jsonStr;

@end
