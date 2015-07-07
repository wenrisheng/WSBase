//
//  WSDatePickerUtil.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/4.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSPickerViewUtil.h"
#import "UIView+WSBaseUtil.h"

@implementation WSPickerViewUtil

+ (void)showDatePickerWithConfrimCallBack:(ConfrimCallBack)confrimCallBack cancelCallBack:(CancelCallBack)cancelCallBack
{
    WSDatePickerView *datePickerView = [WSDatePickerView getView];
    datePickerView.cancelCallBack = cancelCallBack;
    datePickerView.confirmCallBack = confrimCallBack;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:datePickerView];
    [datePickerView expandToSuperView];
}

+ (void)showChinaAreaPickerWithConfrimCallBack:(AreaConfrimCallBack)confrimCallBack cancelCallBack:(AreaCancelCallBack)cancelCallBack
{
    WSChinaAreaPickerView *areaPickerView = [WSChinaAreaPickerView getView];
    areaPickerView.cancelCallBack = cancelCallBack;
    areaPickerView.confirmCallBack = confrimCallBack;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:areaPickerView];
    [areaPickerView expandToSuperView];
}

@end
