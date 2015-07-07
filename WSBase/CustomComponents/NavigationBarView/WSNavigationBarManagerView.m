//
//  NavigationBarManagerView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSNavigationBarManagerView.h"
#import "UIView+WSBaseUtil.h"

@implementation WSNavigationBarManagerView

- (void)awakeFromNib
{
    NSInteger tag = self.tag;
    switch (tag) {
        case WSNavigationBarManagerViewTypeBlank:
        {
            _navigationBarView = [WSNavigationBarView getNavigationBarView];
            [self addSubview:_navigationBarView];
            [_navigationBarView expandToSuperView];
        }
            break;
        case WSNavigationBarManagerViewTypeButSearchBut:
        {
            _navigationBarButSearchButView = [WSNavigationBarButSearchButView getNavigationBarViewButSearchButView];
            [self addSubview:_navigationBarButSearchButView];
            [_navigationBarButSearchButView expandToSuperView];
        }
            break;
        case WSNavigationBarManagerViewTypeButLabel:
        {
            _navigationBarButLabelView = [WSNavigationBarButLabelView getView];
            [self addSubview:_navigationBarButLabelView];
            [_navigationBarButLabelView expandToSuperView];
        }
            break;
        case WSNavigationBarManagerViewTypeLabelBut:
        {
            _navigationBarLabelButView = [WSNavigationBarLabelButView getView];
            [self addSubview:_navigationBarLabelButView];
            [_navigationBarLabelButView expandToSuperView];
        }
            break;
        case WSNavigationBarManagerViewTypeCenterLabel:
        {
            _navigationBarCenterLabelView = [WSNavigationBarCenterLabelView getView];
            [self addSubview:_navigationBarCenterLabelView];
            [_navigationBarCenterLabelView expandToSuperView];
        }
            break;
        case WSNavigationBarManagerViewTypeButLabelBut:
        {
            _navigationBarButLabelButView = [WSNavigationBarButLabelButView getView];
            [self addSubview:_navigationBarButLabelButView];
            [_navigationBarButLabelButView expandToSuperView];
        }
            break;
        case wsnavigationbarManagerViewTypeCenterImageViewLabel:
        {
            _navigationBarCenterImageViewLabelView = [WSNavigationBarCenterImageViewLabelView getView];
            [self addSubview:_navigationBarCenterImageViewLabelView];
            [_navigationBarCenterImageViewLabelView expandToSuperView];
        }
            break;
        default:
            break;
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
