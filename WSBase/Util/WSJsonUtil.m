//
//  WSJsonUtil.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/7/3.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSJsonUtil.h"

@implementation WSJsonUtil

+ (NSString *)convertObjToJson:(id)obj
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

+ (NSDictionary *)convertJsonToDic:(NSString *)jsonStr
{
    if (jsonStr == nil) {
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
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

@end
