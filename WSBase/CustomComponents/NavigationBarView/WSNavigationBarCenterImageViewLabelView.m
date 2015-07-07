//
//  WSNavigationBarCenterImageViewLabelView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/19.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSNavigationBarCenterImageViewLabelView.h"
#import "WSNavigationBarColor.h"
#import "WSBaseMacro.h"

@implementation WSNavigationBarCenterImageViewLabelView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSNavigationBarCenterImageViewLabelView" owner:nil options:nil];
    WSNavigationBarCenterImageViewLabelView *view = [array firstObject];
    view.backgroundColor = NAVIGATIONIBAR_BACKGROUND_COLOR;
    view.saperateView.backgroundColor = NAVIGATIONIBAR_SAPERATE_COLOR;
    view.centerLabel.textColor = NAVIGATIONIBAR_TITLE_COLOR;
    
    return view;
}

@end
