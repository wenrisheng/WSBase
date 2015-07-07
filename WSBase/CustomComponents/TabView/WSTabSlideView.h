//
//  CTTabSlideView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/16.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTabSlideItemView.h"

#define TAbSlideView_TITLE_COLOR_NORMAL_DEFAUTL      [UIColor colorWithWhite:0.427 alpha:1.000]
#define TAbSlideView_TITLE_COLOR_SELECTED_DEFAULT    [UIColor redColor]

@class WSTabSlideView;
@protocol WSTabSlideViewDelegate <NSObject>

- (void)tabSlideViewDidClick:(WSTabSlideView *)tabSlideView index:(NSInteger)index;

@end

@interface WSTabSlideView : UIView <WSTabSlideItemViewDelegate>

@property (strong, nonatomic) NSMutableArray *tabSlideItemViewArray;

@property (weak, nonatomic) id<WSTabSlideViewDelegate> delegate;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIColor *titleNormalColor;
@property (strong, nonatomic) UIColor *titleSelectedColor;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *currentIndexView;
@property (weak, nonatomic) IBOutlet UIView *saperateView;

+ (instancetype)getTabSlideView;

- (void)setTitleDataArray:(NSArray *)titleArray;
- (void)setSelectedTabItem:(NSInteger)index;

@end
