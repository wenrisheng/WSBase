//
//  CTTabbarSlideBgImageItemView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabSlideBgImageItemView.h"
#import "WSBaseMacro.h"

@implementation WSTabSlideBgImageItemView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTabSlideBgImageItemView" owner:nil options:nil];
    WSTabSlideBgImageItemView *view = [array firstObject];
    return view;
}

- (IBAction)butAction:(id)sender
{
    if ([_delegate respondsToSelector:@selector(tabSlideBgImageItemDidClick:)]) {
        [_delegate tabSlideBgImageItemDidClick:self];
    }
}
@end
