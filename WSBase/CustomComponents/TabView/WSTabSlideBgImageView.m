//
//  CTTabbarSlideBgImageView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabSlideBgImageView.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"

@implementation WSTabSlideBgImageView

- (void)awakeFromNib
{
    _currentIndex = 0;
    _titleNormalColor = TABSLIDEBGIMAGEVIEW_TITLE_COLOR_NORMAL_DEFAUTL;
    _titleSelectedColor = TABSLIDEBGIMAGEVIEW_TITLE_COLOR_SELECTED_DEFAULT;
}

+ (instancetype)getTabSlideView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTabSlideBgImageView" owner:nil options:nil];
    WSTabSlideBgImageView *view = [array firstObject];
    return view;
}


- (void)setTabSlideBgDataArray:(NSArray *)array
{
    self.dataArray = array;
    _tabSlideBgImageItemViewArray = [[NSMutableArray alloc] init];
    NSUInteger itemCount = array.count;
    // 初始化开始状态
    [self initCurImageView:itemCount];
    CGFloat itemCountFloat = (float)itemCount / 1.00;
    for (int i = 0; i < itemCount; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        WSTabSlideBgImageItemView *itemView = [WSTabSlideBgImageItemView getView];
        [itemView.label setTextColor:_titleNormalColor];
        itemView.label.text = [dic objectForKey:TABSLIDEBGIMAGEVIEW_TITLE];
        itemView.imageView.image = [UIImage imageNamed:[dic objectForKey:TABSLIDEBGIMAGEVIEW_NORMAL_IMAGE]];
        itemView.tag = i;
        itemView.delegate = self;
        [_tabSlideBgImageItemViewArray addObject:itemView];
        [_contentView addSubview:itemView];
        itemView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        // 修复ios 8.3multiplier不能为0的bug，8.3以前的版本系统报约束有错但会帮你修复，8.3直接闪退
        NSLayoutConstraint *left;
        CGFloat multiplier = i / itemCountFloat;
        if (multiplier == 0) {
            left =  [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        } else {
            left = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeRight multiplier:(i / itemCountFloat) constant:0];
        }
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:(1 / itemCountFloat) constant:0];
        [_contentView addConstraints:@[top, bottom, left, width]];
    }
    

   
    [self setSelectedTabItem:_currentIndex];
}

- (void)initCurImageView:(float)itemCount
{
    _curImageView = [[UIImageView alloc] init];
    _curImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentView addSubview:_curImageView];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_curImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_curImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0];
    // 修复ios 8.3multiplier不能为0的bug，8.3以前的版本系统报约束有错但会帮你修复，8.3直接闪退
    NSLayoutConstraint *left;
    CGFloat multiplier = _currentIndex  / itemCount;
    if (multiplier == 0) {
        left =  [NSLayoutConstraint constraintWithItem:_curImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    } else {
        left = [NSLayoutConstraint constraintWithItem:_curImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeRight multiplier:(_currentIndex  / itemCount) constant:0];
    }
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:_curImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:(1 / itemCount) constant:0];
     [_contentView addConstraints:@[top, bottom, left, width]];
}

#pragma mark - CTTabSlideBgImageItemViewDelegate
- (void)tabSlideBgImageItemDidClick:(WSTabSlideBgImageItemView *)tabItemView
{
    NSInteger tag = tabItemView.tag;
     [self setSelectedTabItem:tag];
    if (_callBack) {
        _callBack((int)tag);
    }
}

- (void)setSelectedTabItem:(NSInteger)index
{
     NSDictionary *oldDic = [_dataArray objectAtIndex:_currentIndex];
    WSTabSlideBgImageItemView *oldItemView = [_tabSlideBgImageItemViewArray objectAtIndex:_currentIndex];
    [oldItemView.label setTextColor:_titleNormalColor];
    oldItemView.imageView.image = [UIImage imageNamed:[oldDic objectForKey:TABSLIDEBGIMAGEVIEW_NORMAL_IMAGE]];
    
     NSDictionary *nweDic = [_dataArray objectAtIndex:index];
    WSTabSlideBgImageItemView *nweItemView = [_tabSlideBgImageItemViewArray objectAtIndex:index];
    [nweItemView.label setTextColor:_titleSelectedColor];
    nweItemView.imageView.image = [UIImage imageNamed:[nweDic objectForKey:TABSLIDEBGIMAGEVIEW_SELECTED_IMAGE]];
    
    [UIView beginAnimations:nil context:nil];
    CGPoint center = _curImageView.center;
    center.x = nweItemView.center.x;
    _curImageView.center = center;
    [UIView commitAnimations];
    
    _currentIndex = index;
}


@end
