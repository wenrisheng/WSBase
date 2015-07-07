//
//  WSNavigationBarButLabelButView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/17.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSNavigationBarButLabelButView.h"
#import "WSNavigationBarColor.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"
#import "UIButton+WSEnlargeResponseDomain.h"

@implementation WSNavigationBarButLabelButView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSNavigationBarButLabelButView" owner:nil options:nil];
    WSNavigationBarButLabelButView *view = [array firstObject];
    view.backgroundColor = NAVIGATIONIBAR_BACKGROUND_COLOR;
    view.saperateView.backgroundColor = NAVIGATIONIBAR_SAPERATE_COLOR;
    view.centerLabel.textColor = NAVIGATIONIBAR_TITLE_COLOR;
    
    return view;
}

- (void)awakeFromNib
{
    [_leftBut setEnlargeEdge:10];
    [_rightBut setEnlargeEdge:10];
}

- (IBAction)leftButAction:(id)sender
{
    if ([_delegate respondsToSelector:@selector(navigationBarLeftButClick:)]) {
        [_delegate navigationBarLeftButClick:sender];
    } else {
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }

}
- (IBAction)rightButAction:(id)sender
{
    if ([_delegate respondsToSelector:@selector(navigationBarRightButClick:)]) {
        [_delegate navigationBarRightButClick:sender];
    }
}

@end
