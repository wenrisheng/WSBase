//
//  CTNavigationBarLabel.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/15.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSNavigationBarLabelButViewDelegate <NSObject>

- (void)navigationBarRightButClick:(UIButton *)but;

@end

@interface WSNavigationBarLabelButView : UIView

+ (instancetype)getView;

@property (weak, nonatomic) id<WSNavigationBarLabelButViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBut;
@property (weak, nonatomic) IBOutlet UIView *saperateView;

@end
