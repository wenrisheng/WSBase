//
//  TabbarItemView.m
//  CustomTabbarViewController
//
//  Created by wrs on 15/4/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabbarItemView.h"

@implementation WSTabbarItemView

+ (instancetype)getTabbarItemView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"BaseStaticLibraryResource" withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTabbarItemView" owner:nil options:nil];
    return [array firstObject];
}

- (void)awakeFromNib
{
    [_button addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - button 点击事件
- (void)butAction:(UIButton *)but
{
    if ([_delegate respondsToSelector:@selector(clickTabbarItemView:)]) {
        [_delegate clickTabbarItemView:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
