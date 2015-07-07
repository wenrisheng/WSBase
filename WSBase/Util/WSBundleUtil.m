//
//  WSBundleUtil.m
//  WSBase
//
//  Created by wrs on 15/7/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSBundleUtil.h"

@implementation WSBundleUtil

+ (NSBundle *)getBundleWithName:(NSString *)bundleName{
    return [WSBundleUtil getBundleWithName:bundleName inBundle:[NSBundle mainBundle]];
}

+ (NSBundle *)getBundleWithName:(NSString *)bundleName inBundle:(NSBundle *)parentBundle{
    if (parentBundle) {
        NSURL *url = [parentBundle URLForResource:bundleName withExtension:@"bundle"];
        if (url) {
            return [NSBundle bundleWithURL:url];
        }
    }
    
    return nil;
}

@end
