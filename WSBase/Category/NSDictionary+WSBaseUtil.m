//
//  NSDictionary+WSBaseUtil.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/29.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "NSDictionary+WSBaseUtil.h"
#import "NSArray+WSBaseUtil.h"
#import <objc/runtime.h>

@implementation NSDictionary (WSBaseUtil)

- (id)stringForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    if ([value isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return @"";
}

- (NSMutableDictionary *)convertToMutalbeDictionary
{
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    NSArray *keys = self.allKeys;
    for (id key in keys) {
        id value = [self valueForKey:key];
        
        // 字符串不转换
        if ([value isKindOfClass:[NSString class]]) {
            [resultDic setValue:value forKey:key];
            
        // 数字类型转为字符串类型
        } else if ([value isKindOfClass:[NSNumber class]]) {
            [resultDic setValue:[value stringValue] forKey:key];
            
        // NSNull对象转为空字符串，主要针对java的null
        } else if ([value isKindOfClass:[NSNull class]]) {
           // [resultDic setValue:@"" forKey:key];
            
        // 不可变字典转为可变字典
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *tempDic = value;
            [resultDic setValue:[tempDic convertToMutalbeDictionary] forKey:key];
            
        // 不可变数组转为可变数组
        } else if ([value isKindOfClass:[NSArray class]]) {
            NSArray *tempArray = value;
            NSMutableArray *tempResultArray = [tempArray converToMutalbeArray];
            [resultDic setValue:tempResultArray forKey:key];
        
        //其他
        } else {
            [resultDic setValue:value forKey:key];
        }
    }
    return resultDic;
}

- (id)convertToObjWithClass:(Class)_class
{
    id obj = [[_class alloc] init];
    
    //对字典本身的属性进行过滤
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0; i < propsCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [self valueForKey:propName];
        [obj setValue:value forKey:propName];
    }
    free(props);

    return obj;
}

- (id)convertToObjWithClass:(Class)_class includeProperties:(NSArray *)modelProperties :(NSArray *)dictionaryKeys
{
    id obj = [[_class alloc] init];
    
    //对字典本身拥有的属性
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0; i < propsCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [self valueForKey:propName];
        [obj setValue:value forKey:propName];
    }
    free(props);
    
    //设置额外的属性
    NSUInteger  modelPropertiesCounts = modelProperties.count;
    NSUInteger keysCount = dictionaryKeys.count;
    for (int i = 0; i < modelPropertiesCounts; i++) {
        id modelProperty = [modelProperties objectAtIndex:i];
        if (i < keysCount) {
            id key = [dictionaryKeys objectAtIndex:i];
            id value = [self objectForKey:key];
            [obj setValue:value forKey:modelProperty];
        }
    }
    
    return obj;
}

@end
