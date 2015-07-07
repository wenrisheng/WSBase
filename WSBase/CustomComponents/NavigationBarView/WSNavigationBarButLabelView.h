//
//  NavigationBarButLabelView.h
//  CTWeMedia
//
//  Created by wrs on 15/4/13.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSNavigationBarButLabelViewDelegate <NSObject>

- (void)navigationBarLeftButClick:(UIButton *)but;

@end

@interface WSNavigationBarButLabelView : UIView

+ (instancetype)getView;

@property (weak, nonatomic) id<WSNavigationBarButLabelViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *leftBut;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *saperateView;

@end
