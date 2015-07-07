//
//  SlideSwitchManagerView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSSlideSwitchManagerView.h"

@implementation WSSlideSwitchManagerView

- (void)awakeFromNib
{
    _slideSwitchView = [WSSlideSwitchView getSlideSwitchView];
    [self addSubview:_slideSwitchView];
    _slideSwitchView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *dic = NSDictionaryOfVariableBindings(_slideSwitchView);
    NSArray *hcon=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_slideSwitchView]|" options:0 metrics:nil views:dic];
    NSArray *vcon=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_slideSwitchView]|" options:0 metrics:nil views:dic];
    [self addConstraints:hcon];
    [self addConstraints:vcon];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
