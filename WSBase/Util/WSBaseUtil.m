//
//  BaseUtility.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSBaseUtil.h"

@implementation WSBaseUtil

+ (NSString *)objToJson:(id)obj
{
    if (!obj) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error) {
        NSLog(@"对象转Json解析失败：%@",error);
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)jsonToDic:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        NSLog(@"json转NSDictionary解析失败：%@",error);
        return nil;
    }
    return dic;
}

+(int)getRandomNumber:(int)from to:(int)to
{
  return (int)(from + (arc4random() % (to - from + 1)));
}

+ (NSString *)getDateStrWithDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

+ (NSMutableDictionary *)changNumberToStringForDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    NSArray *allKeys = dic.allKeys;
    for (id key in allKeys) {
        id value = [dic objectForKey:key];
        if ([value isKindOfClass:[NSNumber class]]) {
            [tempDic setObject:[value stringValue] forKey:key];
        } else if ([value isKindOfClass:[NSNull class]]){
            [tempDic setObject:@"" forKey:key];
        } else {
            [tempDic setValue:value forKey:key];
        }
    }
    return tempDic;
}



@end
