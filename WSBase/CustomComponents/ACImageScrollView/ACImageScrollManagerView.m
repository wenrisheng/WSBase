//
//  AcImageScrollManagerView.m
//  广告循环滚动效果
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 Qzy. All rights reserved.
//

#import "ACImageScrollManagerView.h"
#import "UIView+WSBaseUtil.h"

@implementation ACImageScrollManagerView


- (void)awakeFromNib
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSInteger tag = self.tag;
    switch (tag) {
        case ACImageScrollManagerViewTypeDefault:
        {
            _acImageScrollView = [ACImageScrollView getView];
            [self addSubview:_acImageScrollView];
            [_acImageScrollView expandToSuperView];
        }
            break;
            
        default:
            break;
    }
}

@end
