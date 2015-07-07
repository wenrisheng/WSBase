//
//  NavigationBarViewButSearchBut.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSNavigationBarButSearchButView.h"
#import "WSNavigationBarManagerView.h"
#import "WSNavigationBarColor.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"
#import "UIButton+WSEnlargeResponseDomain.h"

@implementation WSNavigationBarButSearchButView

+ (instancetype)getNavigationBarViewButSearchButView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSNavigationBarButSearchButView" owner:nil options:nil];
    WSNavigationBarButSearchButView *resultView = [array firstObject];
    resultView.tag = WSNavigationBarManagerViewTypeButSearchBut;
    resultView.middleSearchManagerView.searchView.delegate = resultView;
    resultView.backgroundColor = NAVIGATIONIBAR_BACKGROUND_COLOR;
    resultView.saperateView.backgroundColor = NAVIGATIONIBAR_SAPERATE_COLOR;
    resultView.leftLabel.textColor = NAVIGATIONIBAR_TITLE_COLOR;
    
    return resultView;
}

- (void)awakeFromNib
{
    [_leftBut setEnlargeEdgeWithTop:20 right:20 bottom:10 left:20];
    [_rightBut setEnlargeEdge:10];
    [_leftBut addTarget:self action:@selector(leftButClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBut addTarget:self action:@selector(rightButClick:) forControlEvents:UIControlEventTouchUpInside];
    CGRect rect = _rightLabel.bounds;
    _rightLabel.layer.cornerRadius = rect.size.width / 2;
    _rightLabel.layer.masksToBounds  = YES;
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

#pragma mark - 右边按钮事件
- (void)rightButClick:(UIButton *)but
{
    if ([_delegate respondsToSelector:@selector(navigationBarRightButClick:)]) {
        [_delegate navigationBarRightButClick:but];
    }
}

#pragma mark - SearchViewDelegate
- (BOOL)searchViewDelegateTextFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(navigationBarSearchViewTextFieldShouldBeginEditing:)]) {
        return [_delegate navigationBarSearchViewTextFieldShouldBeginEditing:textField];
    } else {
        return YES;
    }
}

- (void)searchViewDelegateTextFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(navigationBarSearchViewTextFieldDidBeginEditing:)]) {
        return [_delegate navigationBarSearchViewTextFieldDidBeginEditing:textField];
    }
}

- (void)searchViewDelegateTextFieldDidEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(navigationBarSearchViewTextFieldDidEndEditing:)]) {
        [_delegate navigationBarSearchViewTextFieldDidEndEditing:textField];
    }
}

- (BOOL)searchViewDelegateTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_delegate respondsToSelector:@selector(navigationBarSearchViewTextField:shouldChangeCharactersInRange:replacementString:)]) {
        return [_delegate navigationBarSearchViewTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    } else {
        return YES;
    }
}

- (BOOL)searchViewDelegateTextFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(navigationBarSearchViewTextFieldShouldReturn:)]) {
        return [_delegate navigationBarSearchViewTextFieldShouldReturn:textField];
    } else {
        return YES;
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
