//
//  CTNavigationBarLabel.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/15.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSNavigationBarLabelButView.h"
#import "WSNavigationBarColor.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"
#import "UIButton+WSEnlargeResponseDomain.h"

@implementation WSNavigationBarLabelButView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSNavigationBarLabelButView" owner:nil options:nil];
    WSNavigationBarLabelButView *resultView = [array firstObject];
    resultView.backgroundColor = NAVIGATIONIBAR_BACKGROUND_COLOR;
    resultView.saperateView.backgroundColor = NAVIGATIONIBAR_SAPERATE_COLOR;
    resultView.middleLabel.textColor = NAVIGATIONIBAR_TITLE_COLOR;
    
    return resultView;
    
}

- (void)awakeFromNib
{
    [_rightBut setEnlargeEdge:10];
    [self.rightBut addTarget:self action:@selector(rightButAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightButAction:(UIButton *)but
{
    if ([_delegate respondsToSelector:@selector(navigationBarRightButClick:)]) {
        [_delegate navigationBarRightButClick:but];
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
