//
//  CTTabbarSlideBgImageItemView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSTabSlideBgImageItemView;
@protocol WSTabSlideBgImageItemViewDelegate <NSObject>

- (void)tabSlideBgImageItemDidClick:(WSTabSlideBgImageItemView *)tabItemView;

@end

@interface WSTabSlideBgImageItemView : UIView

+ (instancetype)getView;

@property (weak, nonatomic) id<WSTabSlideBgImageItemViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *but;
- (IBAction)butAction:(id)sender;

@end
