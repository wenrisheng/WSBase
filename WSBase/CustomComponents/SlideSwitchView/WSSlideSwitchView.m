//
//  SlideSwitchView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/10.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSSlideSwitchView.h"
#import "WSBaseMacro.h"

@implementation WSSlideSwitchView

+ (instancetype)getSlideSwitchView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSSlideSwitchView" owner:nil options:nil];
    return [array firstObject];
}

- (void)setImageViewArray:(NSArray *)imageArray
{
    itemCount = imageArray.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = _scrollView.bounds.size.width;
    CGFloat h = _scrollView.bounds.size.height;
    for (int i = 0; i < itemCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [imageArray objectAtIndex:i];
        imageView.tag = i;
        imageView.frame = CGRectMake(x, y, w, h);
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
        x += w;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tapGest];
    }
    _pageView.currentPage = curIndex;
    _pageView.numberOfPages = itemCount;
    [NSTimer scheduledTimerWithTimeInterval:SLIDESWITCHVIEW_INTERVAL target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat y = 0;
    CGFloat w = _scrollView.bounds.size.width;
    CGFloat h = _scrollView.bounds.size.height;
    NSArray *subViews = _scrollView.subviews;
    for (UIView *subView in subViews) {
        NSInteger tag = subView.tag;
        subView.frame = CGRectMake(tag * w, y, w, h);
    }
    CGSize contentSize = CGSizeMake(itemCount * w, h);
    _scrollView.contentSize = contentSize;
}

- (void)awakeFromNib
{
    _scrollView.delegate = self;
    [_pageView addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 点击事件
- (void)tapAction:(UITapGestureRecognizer *)tapGest
{
    if ([_delegate respondsToSelector:@selector(slideSwitchViewDidSelectedIndex:)]) {
        UIView *view = [tapGest view];
        [_delegate slideSwitchViewDidSelectedIndex:(int)view.tag];
    }
}

#pragma mark - UIPageControl 事件
- (void)pageControlAction:(UIPageControl *)pageControl
{
    NSInteger index = pageControl.currentPage;
    CGPoint point = _scrollView.contentOffset;
    point.x = _scrollView.bounds.size.width * index;
    _scrollView.contentOffset = point;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat index = contentOffset.x / scrollView.bounds.size.width;
    int tempIndex = (int)index;
    if (index == tempIndex) {
         _pageView.currentPage = index;
        curIndex = index;
    }
}

#pragma mark - timeAction
- (void)timeAction:(NSTimer *)timer
{
    int tempIndex = curIndex + 1;
    if (tempIndex < itemCount) {
        [UIView beginAnimations:nil context:nil];
        [self selectedIndex:tempIndex];
        [UIView commitAnimations];
    } else {
        [self selectedIndex:0];
    }
  
}

- (void)selectedIndex:(int)index
{
    if (index >= 0 && index < itemCount) {
        _pageView.currentPage = index;
        CGPoint point = _scrollView.contentOffset;
        point.x = _scrollView.bounds.size.width * index;
        _scrollView.contentOffset = point;
        curIndex = index;
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
