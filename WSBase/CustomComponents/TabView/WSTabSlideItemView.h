//
//  CTTabSlideItemView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/16.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSTabSlideItemView;
@protocol WSTabSlideItemViewDelegate <NSObject>

- (void)tabSlideItemClick:(WSTabSlideItemView *)tabSlideItemView;

@end

@interface WSTabSlideItemView : UIView

+ (instancetype)getView;

@property (strong, nonatomic) UIImageView *curImageView;;
@property (weak, nonatomic) id<WSTabSlideItemViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)butAction:(id)sender;


@end
