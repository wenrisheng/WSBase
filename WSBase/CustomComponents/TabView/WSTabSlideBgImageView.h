//
//  CTTabbarSlideBgImageView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTabSlideBgImageItemView.h"

#define TABSLIDEBGIMAGEVIEW_TITLE_COLOR_NORMAL_DEFAUTL      [UIColor colorWithWhite:0.475 alpha:1.000]
#define TABSLIDEBGIMAGEVIEW_TITLE_COLOR_SELECTED_DEFAULT    [UIColor colorWithRed:0.216 green:0.608 blue:0.863 alpha:1.000]

#define TABSLIDEBGIMAGEVIEW_NORMAL_IMAGE                   @"tabslidebgimageview_normal_image"
#define TABSLIDEBGIMAGEVIEW_SELECTED_IMAGE                 @"tabslidebgimageview_selected_image"
#define TABSLIDEBGIMAGEVIEW_TITLE                          @"tabslidebgimageview_title"

typedef void(^WSTabbarSlideBgImageViewCallBack)(int index);

@interface WSTabSlideBgImageView : UIView <WSTabSlideBgImageItemViewDelegate>

+ (instancetype)getTabSlideView;

@property (strong, nonatomic) WSTabbarSlideBgImageViewCallBack callBack;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIColor *titleNormalColor;
@property (strong, nonatomic) UIColor *titleSelectedColor;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *tabSlideBgImageItemViewArray;

@property (strong, nonatomic) IBOutlet UIImageView *curImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *contentView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *saperateView;

- (void)setTabSlideBgDataArray:(NSArray *)array;

@end
