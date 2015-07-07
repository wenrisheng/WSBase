//
//  NSArray+WSBaseUtil.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/7/3.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "NSArray+WSBaseUtil.h"
#import "NSDictionary+WSBaseUtil.h"

@implementation NSArray (WSBaseUtil)

- (NSMutableArray *)converToMutalbeArray
{
    NSMutableArray *resultArray = [NSMutableArray array];
    NSInteger count = self.count;
    for (int i = 0; i < count; i++) {
        id arrayValue = [self objectAtIndex:i];
        
        // 字符串不转换
        if ([arrayValue isKindOfClass:[NSString class]]) {
            [resultArray addObject:arrayValue];
            
            // 数字类型转为字符串类型
        } else if ([arrayValue isKindOfClass:[NSNumber class]]) {
            [resultArray addObject:[arrayValue stringValue]];
            
            // NSNull对象转为空字符串，主要针对java的null
        } else if ([arrayValue isKindOfClass:[NSNull class]]) {
           // [resultArray addObject:@""];
            
            // 不可变字典转为可变字典
        } else if ([arrayValue isKindOfClass:[NSDictionary class]]) {
            NSDictionary *tempDic = arrayValue;
            NSMutableDictionary *resultDic = [tempDic convertToMutalbeDictionary];
            [resultArray addObject:resultDic];
            
            // 不可变数组转为可变数组
        } else if ([arrayValue isKindOfClass:[NSArray class]]) {
            NSArray *tempArray = arrayValue;
            NSMutableArray *tempResultArray = [tempArray converToMutalbeArray];
            [resultArray addObject:tempResultArray];
        }
    }
    return resultArray;

}

@end
