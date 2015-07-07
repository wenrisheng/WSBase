//
//  CTTabManagerView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/16.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabSlideView.h"
#import "WSTabSlideBgImageView.h"
#import "WSTabSlideGapTextView.h"

typedef NS_ENUM(NSInteger, CTTabSlideViewType) {
    CTTabManagerViewTypeSlide = 100,
    CTTabManagerViewTypeBgImageSlide = 101,
    CTTabSlideViewTypeGapText = 102
};

@interface WSTabSlideManagerView : UIView

@property (strong, nonatomic) WSTabSlideView *tabSlideView;
@property (strong, nonatomic) WSTabSlideBgImageView *tabSlideBgImageView;
@property (strong, nonatomic) WSTabSlideGapTextView *tabSlideGapTextView;

@end
