//
//  SlideSwitchView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/10.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SLIDESWITCHVIEW_INTERVAL      4

@protocol WSSlideSwitchViewDelegate <NSObject>

- (void)slideSwitchViewDidSelectedIndex:(int)index;

@end

@interface WSSlideSwitchView : UIView <UIScrollViewDelegate>
{
    int curIndex;
    NSInteger itemCount;
}

+ (instancetype)getSlideSwitchView;

- (void)setImageViewArray:(NSArray *)imagewArray;

@property (weak, nonatomic) id<WSSlideSwitchViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;

@end
