//
//  SearchManagerView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSSearchManagerView.h"
#import "UIView+WSBaseUtil.h"

@implementation WSSearchManagerView

- (void)awakeFromNib
{
    NSInteger tag = self.tag;
    switch (tag) {
        case WSSearchManagerViewTypeSearchView:
        {
            self.searchView = [WSSearchView getSearchView];
            [self addSubview:_searchView];
            [_searchView expandToSuperView];
        }
            break;
        case WSSearchManagerViewTypeSearchTypeView:
        {
            self.searchTypeView = [WSSearchTypeView getView];
            [self addSubview:_searchTypeView];
            [_searchTypeView expandToSuperView];
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
