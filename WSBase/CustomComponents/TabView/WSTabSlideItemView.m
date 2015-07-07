//
//  CTTabSlideItemView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/16.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabSlideItemView.h"
#import "WSBaseMacro.h"

@implementation WSTabSlideItemView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTabSlideItemView" owner:nil options:nil];
    WSTabSlideItemView *view = [array firstObject];
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)butAction:(id)sender
{
    if ([_delegate respondsToSelector:@selector(tabSlideItemClick:)]) {
        [_delegate tabSlideItemClick:self];
    }
}
@end
