//
//  CTTabSlideGapTextView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/22.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabSlideGapTextView.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"


@implementation WSTabSlideGapTextView

- (void)awakeFromNib
{
    _currentIndex = 0;
    _titleNormalColor = TABSLIDEGAPTEXTVIEW_TITLE_COLOR_NORMAL_DEFAUTL;
    _titleSelectedColor = TABSLIDEGAPTEXTVIEW_TITLE_COLOR_SELECTED_DEFAULT;
}


+ (instancetype)getTabSlideView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTabSlideGapTextView" owner:nil options:nil];
    WSTabSlideGapTextView *view = [array firstObject];
    return view;
}

- (void)setTabSlideDataArray:(NSArray *)dataArray
{
    [self clearSubviews];
    self.dataArray = dataArray;
    _tabSlideItemViewArray = [[NSMutableArray alloc] init];
    NSUInteger itemCount = dataArray.count;
   
    CGFloat itemCountFloat = (float)itemCount / 1.00;
    for (int i = 0; i < itemCount; i++) {
        NSDictionary *dic = [dataArray objectAtIndex:i];
        NSString *title = [dic objectForKey:TABSLIDEGAPTEXTVIEW_IMAGE_TITLE];
        WSTabSlideGapTextItemView *itemView = [WSTabSlideGapTextItemView getView];
        if (_imageheight != 0) {
            itemView.rightImageViewHeightCon.constant = _imageheight;
        }
        if (_imageWith != 0) {
            itemView.rightImageViewWidthCon.constant = _imageWith;
        }
        [itemView.label setTextColor:_titleNormalColor];
        itemView.label.text = title;
        NSString *normalImage = [dic objectForKey:TABSLIDEGAPTEXTVIEW_IMAGE_NORMAL];
        normalImage = normalImage == nil ? _normalImage : normalImage;
        
        itemView.rightImageView.image = [UIImage imageNamed:normalImage];
        itemView.callBack = ^(WSTabSlideGapTextItemView *itemView) {
            NSInteger tag = itemView.tag;
        
            [self setSelectedTabItem:tag];
 
            if (_callBack) {
                _callBack((int)tag);
            }
        };
        itemView.tag = i;
        if (i == 0) {
            itemView.leftGapView.hidden = YES;
             itemView.rightGapView.hidden = YES;
        } else {
            itemView.rightGapView.hidden = YES;
        }
        [_tabSlideItemViewArray addObject:itemView];
        [self addSubview:itemView];
//        itemView.translatesAutoresizingMaskIntoConstraints = NO;
//        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:(i / itemCountFloat) constant:0];
//        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:(1 / itemCountFloat) constant:0];
//        [self addConstraints:@[top, bottom, left, width]];
    }
    [self autoresizingMaskSubViewsForHorizontalAverage:_tabSlideItemViewArray];
    // 初始化开始状态
  // [self initCurImageView:itemCount];
  //  [self setSelectedTabItem:_currentIndex];
}

- (WSTabSlideGapTextItemView *)getItemViewWithIndex:(NSInteger)index
{
    return [_tabSlideItemViewArray objectAtIndex:index];
}

- (void)initCurImageView:(float)itemCount
{
    _curImageView = [[UIImageView alloc] init];
    _curImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_curImageView];
    WSTabSlideGapTextItemView *itemView = [_tabSlideItemViewArray objectAtIndex:0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_curImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:_curImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:itemView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:_curImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:20];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_curImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:10];
    [self addConstraints:@[height, bottom, center, width]];
}


- (void)setSelectedTabItem:(NSInteger)index
{
    if (_currentIndex == index) {
        WSTabSlideGapTextItemView *itemView = [_tabSlideItemViewArray objectAtIndex:_currentIndex];
        NSDictionary *oldDic = [_dataArray objectAtIndex:_currentIndex];
        BOOL selected = itemView.selected;
        UIColor *textColor = nil;
        NSString *imageStr = nil;
        if (selected) {
            textColor = _titleNormalColor;
            imageStr = [oldDic objectForKey:TABSLIDEGAPTEXTVIEW_IMAGE_NORMAL];
            imageStr = imageStr.length > 0 ? imageStr : _normalImage;
        } else {
            textColor = _titleSelectedColor;
            imageStr = [oldDic objectForKey:TABSLIDEGAPTEXTVIEW_IMAGE_SELECTED];
            imageStr = imageStr.length > 0 ? imageStr : _selectedImage;
        }
        [itemView.label setTextColor:textColor];
        itemView.rightImageView.image = [UIImage imageNamed:imageStr];
        itemView.selected = !itemView.selected;
    } else {
        WSTabSlideGapTextItemView *oldItemView = [_tabSlideItemViewArray objectAtIndex:_currentIndex];
        [oldItemView.label setTextColor:_titleNormalColor];
        NSDictionary *oldDic = [_dataArray objectAtIndex:_currentIndex];
        NSString *normalImage = [oldDic objectForKey:TABSLIDEGAPTEXTVIEW_IMAGE_NORMAL];
        normalImage = normalImage.length > 0 ? normalImage : _normalImage;
        oldItemView.rightImageView.image = [UIImage imageNamed:normalImage];
        oldItemView.selected = NO;
        
        WSTabSlideGapTextItemView *nweItemView = [_tabSlideItemViewArray objectAtIndex:index];
        [nweItemView.label setTextColor:_titleSelectedColor];
        NSDictionary *nweDic = [_dataArray objectAtIndex:index];
        NSString *selectedImage = [nweDic objectForKey:TABSLIDEGAPTEXTVIEW_IMAGE_SELECTED];
        selectedImage = selectedImage.length > 0 ? selectedImage : _selectedImage;
        nweItemView.rightImageView.image = [UIImage imageNamed:selectedImage];
        nweItemView.selected = YES;
        
        [UIView beginAnimations:nil context:nil];
        CGPoint center = _curImageView.center;
        center.x = nweItemView.center.x;
        _curImageView.center = center;
        [UIView commitAnimations];
    }
    _currentIndex = index;
}

- (void)resetItemViewWithIndex:(NSInteger)index
{
    WSTabSlideGapTextItemView *oldItemView = [_tabSlideItemViewArray objectAtIndex:_currentIndex];
    [oldItemView.label setTextColor:_titleNormalColor];
    NSDictionary *oldDic = [_dataArray objectAtIndex:_currentIndex];
    NSString *normalImage = [oldDic objectForKey:TABSLIDEGAPTEXTVIEW_IMAGE_NORMAL];
    normalImage = normalImage.length > 0 ? normalImage : _normalImage;
    oldItemView.rightImageView.image = [UIImage imageNamed:normalImage];
    oldItemView.selected = NO;
    _currentIndex = 0;
}

@end
