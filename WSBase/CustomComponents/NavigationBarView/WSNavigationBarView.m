//
//  NavigationBarView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSNavigationBarView.h"
#import "WSBaseMacro.h"
#import "WSNavigationBarColor.h"
#import "WSNavigationBarManagerView.h"

@implementation WSNavigationBarView

+ (instancetype)getNavigationBarView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSNavigationBarView" owner:nil options:nil];
    WSNavigationBarView *resultView = [array firstObject];
    resultView.tag = WSNavigationBarManagerViewTypeBlank;
    resultView.backgroundColor = NAVIGATIONIBAR_BACKGROUND_COLOR;
    resultView.saperateView.backgroundColor = NAVIGATIONIBAR_SAPERATE_COLOR;
    
    return resultView;
}

- (void)awakeFromNib
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
