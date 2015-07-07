//
//  WSDictionaryUtil.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/7/6.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSDictionaryUtil.h"
#import <objc/runtime.h>

@implementation WSDictionaryUtil

+ (NSMutableDictionary *)convertObjToDictionaryWithObj:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0; i < propsCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            value = [NSNull null];
        } else {
            value = [WSDictionaryUtil getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    free(props);
    
    return dic;
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++) {
            [arr setObject:[WSDictionaryUtil getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
        
    }
    return [WSDictionaryUtil convertObjToDictionaryWithObj:obj];
}

@end
