//
//  TabbarItemView.h
//  CustomTabbarViewController
//
//  Created by wrs on 15/4/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSTabbarItemView;
@protocol WSTabbarItemViewDelegate <NSObject>

- (void)clickTabbarItemView:(WSTabbarItemView *)tabbarItemView;

@end

@interface WSTabbarItemView : UIView

+ (instancetype)getTabbarItemView;

@property (weak, nonatomic) id<WSTabbarItemViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
