//
//  WSPathUtil.m
//  NotificationProj
//
//  Created by wrs on 15/6/30.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSPathUtil.h"

@implementation WSPathUtil

+ (NSString *)getHomePath
{
    NSString *homePath = NSHomeDirectory();
    return homePath;
}

+ (NSString *)getDocumentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return docDir;
}

+ (NSString *)getCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}

+ (NSString *)getTempPath
{
    NSString *tempPath = NSTemporaryDirectory();
    return tempPath;
}

+ (NSString *)getBundlePath
{
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    return bundlePath;
}

@end
