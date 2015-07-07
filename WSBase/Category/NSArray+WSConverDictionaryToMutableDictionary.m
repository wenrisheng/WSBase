//
//  NSArray+WSConverDictionaryToMutableDictionary.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/23.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "NSArray+WSConverDictionaryToMutableDictionary.h"

@implementation NSArray (WSConverDictionaryToMutableDictionary)

- (NSMutableArray *)converDictionaryToMutableDictionary
{
    NSMutableArray *tempArray = [NSMutableArray array];
    NSInteger count = self.count;
    for (int i = 0; i < count; i ++) {
        id obj = [self objectAtIndex:i];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
            [resultDic setValuesForKeysWithDictionary:obj];
            [tempArray addObject:resultDic];
        }
    }
    return tempArray;
}

- (NSMutableArray *)converDictionaryNumToStr
{
    NSMutableArray *tempArray = [NSMutableArray array];
    NSInteger count = self.count;
    for (int i = 0; i < count; i ++) {
        NSDictionary *dic = [self objectAtIndex:i];
        NSArray *allKey = dic.allKeys;
        NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
        for (id key in allKey) {
            id value = [dic objectForKey:key];
            
            // 将数字转为字符串
            if ([value isKindOfClass:[NSNumber class]]) {
                NSNumber *numValue = value;
                [resultDic setValue:[numValue stringValue] forKey:key];
                
            // 将java的null转为@“”
            } else if ([value isKindOfClass:[NSNull class]]) {
                [resultDic setValue:@"" forKey:key];
            } else {
                [resultDic setValue:value forKey:key];
            }
        }
        [tempArray addObject:resultDic];
    }
    return tempArray;
}

@end
