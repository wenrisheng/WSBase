//
//  CTTabManagerView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/16.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabSlideManagerView.h"
#import "UIView+WSBaseUtil.h"

@implementation WSTabSlideManagerView

- (void)awakeFromNib
{
    NSInteger tag = self.tag;
    switch (tag) {
        case CTTabManagerViewTypeSlide:
        {
            _tabSlideView = [WSTabSlideView getTabSlideView];
            [self addSubview:_tabSlideView];
            [_tabSlideView expandToSuperView];
        }
            break;
        case CTTabManagerViewTypeBgImageSlide:
        {
            _tabSlideBgImageView = [WSTabSlideBgImageView getTabSlideView];
            [self addSubview:_tabSlideBgImageView];
            [_tabSlideBgImageView expandToSuperView];
        }
            break;
        case CTTabSlideViewTypeGapText:
        {
            _tabSlideGapTextView = [WSTabSlideGapTextView getTabSlideView];
            [self addSubview:_tabSlideGapTextView];
            [_tabSlideGapTextView expandToSuperView];
        }
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
