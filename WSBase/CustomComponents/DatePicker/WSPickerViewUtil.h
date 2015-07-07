//
//  WSDatePickerUtil.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/4.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDatePickerView.h"
#import "WSChinaAreaPickerView.h"

@interface WSPickerViewUtil : NSObject

+ (void)showDatePickerWithConfrimCallBack:(ConfrimCallBack)confrimCallBack cancelCallBack:(CancelCallBack)cancelCallBack;

+ (void)showChinaAreaPickerWithConfrimCallBack:(AreaConfrimCallBack)confrimCallBack cancelCallBack:(AreaCancelCallBack)cancelCallBack;


@end
