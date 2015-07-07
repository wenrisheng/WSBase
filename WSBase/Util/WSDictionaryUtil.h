//
//  WSDictionaryUtil.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/7/6.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSDictionaryUtil : NSObject

/**
 *  对象转字典
 *
 *  @param obj
 *
 *  @return
 */
+ (NSMutableDictionary *)convertObjToDictionaryWithObj:(id)obj;

+ (id)getObjectInternal:(id)obj;

@end
