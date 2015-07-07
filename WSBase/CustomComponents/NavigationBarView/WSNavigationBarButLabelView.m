//
//  NavigationBarButLabelView.m
//  CTWeMedia
//
//  Created by wrs on 15/4/13.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSNavigationBarButLabelView.h"
#import "WSNavigationBarColor.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"
#import "UIButton+WSEnlargeResponseDomain.h"

@implementation WSNavigationBarButLabelView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSNavigationBarButLabelView" owner:nil options:nil];
    WSNavigationBarButLabelView *view = [array firstObject];
    view.backgroundColor = NAVIGATIONIBAR_BACKGROUND_COLOR;
    view.saperateView.backgroundColor = NAVIGATIONIBAR_SAPERATE_COLOR;
    view.label.textColor = NAVIGATIONIBAR_TITLE_COLOR;
    
    return view;
}

- (void)awakeFromNib
{
    [_leftBut setEnlargeEdge:10];
    [_leftBut addTarget:self action:@selector(leftButClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 左边按钮事件
- (void)leftButClick:(UIButton *)but
{
    if ([_delegate respondsToSelector:@selector(navigationBarLeftButClick:)]) {
        [_delegate navigationBarLeftButClick:but];
    } else {
        [self.viewController.navigationController popViewControllerAnimated:YES];
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
