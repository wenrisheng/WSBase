//
//  WSFileUtil.h
//  WSBase
//
//  Created by wrs on 15/7/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSFileUtil : NSObject

/**
 *  获取bundle下的文件路径
 *
 *  @param name 文件名
 *  @param type 文件类型
 *
 *  @return
 */
+ (NSString *)getResourcePathInBundleWithName:(NSString *)name type:(NSString *)type;

/**
 *  创建目录（自动创建子目录）
 *
 *  @param dirPath 目录路径
 *
 *  @return 是否创建成功
 */
+ (BOOL)createDirectoryAtPath:(NSString *)dirPath;

/**
 *  创建文件（自动创建目录，覆盖原文件）
 *
 *  @param path    文件路径
 *  @param content 文件内容
 *
 *  @return 是否创建成功
 */
+ (BOOL)createFileAtPath:(NSString *)path withContent:(NSData *)content;

/**
 *  向文件新增内容
 *
 *  @param path    文件路径
 *  @param content 新增的内容
 *
 *  @return 成功标识
 */
+ (BOOL)appendToFileAtPath:(NSString *)path withContent:(NSData *)content;

/**
 *  获取文件或目录的名称
 *
 *  @param path 文件或目录路径
 *
 *  @return 文件或目录的名称
 */
+ (NSString *)getItemNameAtPath:(NSString *)path;

/**
 *  获取文件扩展名
 *
 *  @param filePath 文件路径
 *
 *  @return 扩展名
 */
+ (NSString *)getExtOfFile:(NSString *)filePath;

/**
 *  根据文件扩展名，获取对应的MIME类型
 *
 *  @param ext 扩展名
 *
 *  @return MIME类型
 */
+ (NSString *)getMIMETypeWithExt:(NSString *)ext;

@end
