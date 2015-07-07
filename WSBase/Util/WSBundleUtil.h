//
//  WSBundleUtil.h
//  WSBase
//
//  Created by wrs on 15/7/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSBundleUtil : NSObject

/**
 *  获取主bundle里的bundle对象
 *
 *  @param bundleName bundle名称
 *
 *  @return bundle对象
 */
+ (NSBundle *)getBundleWithName:(NSString *)bundleName;

/**
 *  获取指定bundle里的bundle对象
 *
 *  @param bundleName   bundle名称
 *  @param parentBundle 父bundle对象
 *
 *  @return bundle对象
 */
+ (NSBundle *)getBundleWithName:(NSString *)bundleName inBundle:(NSBundle *)parentBundle;

@end
