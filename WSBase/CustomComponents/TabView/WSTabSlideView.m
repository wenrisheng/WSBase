//
//  CTTabSlideView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/16.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabSlideView.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"

@implementation WSTabSlideView

- (void)awakeFromNib
{
    _currentIndex = 0;
    _titleNormalColor = TAbSlideView_TITLE_COLOR_NORMAL_DEFAUTL;
    _titleSelectedColor = TAbSlideView_TITLE_COLOR_SELECTED_DEFAULT;
}

+ (instancetype)getTabSlideView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTabSlideView" owner:nil options:nil];
    WSTabSlideView *view = [array firstObject];
    return view;
}

- (void)setTitleDataArray:(NSArray *)titleArray
{
    _tabSlideItemViewArray = [[NSMutableArray alloc] init];
    NSUInteger itemCount = titleArray.count;
    CGFloat itemCountFloat = (float)itemCount / 1.00;
    for (int i = 0; i < itemCount; i++) {
        WSTabSlideItemView *itemView = [WSTabSlideItemView getView];
        [itemView.label setTextColor:_titleNormalColor];
        itemView.label.text = [titleArray objectAtIndex:i];
        itemView.delegate = self;
        itemView.tag = i;
        [_tabSlideItemViewArray addObject:itemView];
        [self addSubview:itemView];
        itemView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        // 修复ios 8.3multiplier不能为0的bug，8.3以前的版本系统报约束有错但会帮你修复，8.3直接闪退
        NSLayoutConstraint *left;
        CGFloat multiplier = i / itemCountFloat;
        if (multiplier == 0) {
            left =  [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        } else {
            left = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:(i / itemCountFloat) constant:0];
        }
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:(1 / itemCountFloat) constant:0];
        [self addConstraints:@[top, bottom, left, width]];
    }
    
    // 初始化开始状态
    [self initStartStatus];
    [self setSelectedTabItem:_currentIndex];
}

- (void)initStartStatus
{
    [_currentIndexView clearConstrainsToSuperView];
    _currentIndexView.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *relativeView = [_tabSlideItemViewArray objectAtIndex:_currentIndex];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_currentIndexView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:3];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_currentIndexView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:_currentIndexView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:relativeView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:_currentIndexView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:relativeView attribute:NSLayoutAttributeWidth multiplier:0.7 constant:0];
    [self addConstraints:@[height, bottom, center, width]];
}

#pragma mark - CTTabSlideItemViewDelegate
- (void)tabSlideItemClick:(WSTabSlideItemView *)tabSlideItemView
{
    NSInteger tag = tabSlideItemView.tag;
    [self setSelectedTabItem:tag];
    if ([_delegate respondsToSelector:@selector(tabSlideViewDidClick:index:)]) {
        [_delegate tabSlideViewDidClick:self index:tag];
    }
}

- (void)setSelectedTabItem:(NSInteger)index
{
    WSTabSlideItemView *oldItemView = [_tabSlideItemViewArray objectAtIndex:_currentIndex];
    [oldItemView.label setTextColor:_titleNormalColor];
    
    WSTabSlideItemView *nweItemView = [_tabSlideItemViewArray objectAtIndex:index];
    [nweItemView.label setTextColor:_titleSelectedColor];
    
    //[UIView beginAnimations:nil context:nil];
    CGPoint center = _currentIndexView.center;
    center.x = nweItemView.center.x;
    _currentIndexView.center = center;
  //  [UIView commitAnimations];
    
    _currentIndex = index;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
