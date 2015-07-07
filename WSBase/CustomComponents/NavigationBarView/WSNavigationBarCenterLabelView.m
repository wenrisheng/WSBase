//
//  WSNavigationBarCenterLabelView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/16.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSNavigationBarCenterLabelView.h"
#import "WSNavigationBarColor.h"
#import "WSBaseMacro.h"

@implementation WSNavigationBarCenterLabelView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSNavigationBarCenterLabelView" owner:nil options:nil];
    WSNavigationBarCenterLabelView *resultView = [array firstObject];
    resultView.backgroundColor = NAVIGATIONIBAR_BACKGROUND_COLOR;
    resultView.saperateView.backgroundColor = NAVIGATIONIBAR_SAPERATE_COLOR;
    resultView.label.textColor = NAVIGATIONIBAR_TITLE_COLOR;
    
    return resultView;
}

@end
