//
//  CTTabSlideGapTextView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/22.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTabSlideGapTextItemView.h"

#define TABSLIDEGAPTEXTVIEW_TITLE_COLOR_NORMAL_DEFAUTL      [UIColor colorWithRed:0.216 green:0.216 blue:0.220 alpha:1.000]
#define TABSLIDEGAPTEXTVIEW_TITLE_COLOR_SELECTED_DEFAULT    [UIColor colorWithRed:0.871 green:0.357 blue:0.110 alpha:1.000]
#define  TABSLIDEGAPTEXTVIEW_IMAGE_NORMAL                    @"TabSlideGapTextView_image_normal"
#define  TABSLIDEGAPTEXTVIEW_IMAGE_SELECTED                  @"TabSlideGapTextView_image_selected"
#define  TABSLIDEGAPTEXTVIEW_IMAGE_TITLE                     @"TabSlideGapTextView_image_normal_title"

typedef void(^WSTabSlideGapTextViewCallBack)(int index);

@interface WSTabSlideGapTextView : UIView


@property (assign, nonatomic) float imageWith;
@property (assign, nonatomic) float imageheight;
@property (strong, nonatomic) WSTabSlideGapTextViewCallBack callBack;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIColor *titleNormalColor;
@property (strong, nonatomic) UIColor *titleSelectedColor;
@property (strong, nonatomic) NSMutableArray *tabSlideItemViewArray;
@property (strong, nonatomic) NSString *normalImage;
@property (strong, nonatomic) NSString *selectedImage;
@property (strong, nonatomic) UIImageView *curImageView;
@property (strong, nonatomic) NSArray *dataArray;

+ (instancetype)getTabSlideView;

- (void)setTabSlideDataArray:(NSArray *)dataArray;

- (WSTabSlideGapTextItemView *)getItemViewWithIndex:(NSInteger)index;

- (void)resetItemViewWithIndex:(NSInteger)index;

@end
