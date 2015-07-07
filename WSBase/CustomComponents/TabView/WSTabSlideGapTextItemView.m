//
//  CTTabSlideGapTextItemView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/22.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabSlideGapTextItemView.h"
#import "WSBaseMacro.h"

@implementation WSTabSlideGapTextItemView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTabSlideGapTextItemView" owner:nil options:nil];
    WSTabSlideGapTextItemView *view = [array firstObject];
    view.selected = NO;
    return view;
}

- (IBAction)butClick:(id)sender
{
    if (_callBack) {
        _callBack(self);
    }
}

@end
