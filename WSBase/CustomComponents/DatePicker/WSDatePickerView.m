//
//  WSDatePickerView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/4.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSDatePickerView.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"

@implementation WSDatePickerView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSDatePickerView" owner:nil options:nil];
    return [array firstObject];
}

- (void)awakeFromNib
{
    UIColor *borderColor = [UIColor colorWithRed:0.770 green:0.778 blue:0.778 alpha:1.000];
    [_containerView setBorderCornerWithBorderWidth:1 borderColor:borderColor cornerRadius:5];
    _saperateView.backgroundColor = borderColor;
    _saperateViewH.backgroundColor = borderColor;
}

- (IBAction)cancelButAction:(id)sender
{
    [self removeFromSuperview];
    if (_cancelCallBack) {
        _cancelCallBack(self);
    }
}

- (IBAction)confirmButAction:(id)sender
{
    [self removeFromSuperview];
    if (_confirmCallBack) {
        _confirmCallBack(self);
    }
}
    
@end
