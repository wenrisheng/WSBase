//
//  WSArchiveUtil.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/7/3.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSArchiveUtil.h"

@implementation WSArchiveUtil

#pragma mark - obj userDefault
+ (void)archiveToUserDefaultWithObject:(id)obj key:(NSString *)key
{
    if (!obj) {
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:data forKey:key];
    [userDefaults synchronize]; // 同步
}

+ (id)unarchiveObjectFromUserDefault:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:key];
    if (!data) {
        return nil;
    }
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return obj;
}

#pragma mark - obj file
+ (BOOL)archiverObject:(id)obj toFilePath:(NSString *)filePath
{
    BOOL flag = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    return flag;
}

+ (id)unarchiveObjectFromFilePath:(NSString *)filePath
{
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return obj;
}


@end
