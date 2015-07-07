//
//  NSDictionary+WSBaseUtil.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/29.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WSBaseUtil)

- (id)stringForKey:(id)key;

/**
 *  转换成可变字典，此方法有遍历数组
 *
 *  @return
 */
- (NSMutableDictionary *)convertToMutalbeDictionary;

/**
 *  字典转成对象,只设置对象的存在的属性
 *
 *  @param _class 对象class
 *
 *  @return
 */
- (id)convertToObjWithClass:(Class)_class;

/**
 *  字典转成对象,除了设置对象的存在的属性，还包括includePropertys
 *
 *  @param _class 对象class
 *
 *  @return
 */
- (id)convertToObjWithClass:(Class)_class includeProperties:(NSArray *)modelProperties :(NSArray *)dictionaryKeys;

@end
