//
//  WSNavigationBarButLabelButView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/17.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSNavigationBarButLabelButViewDelegate <NSObject>

@optional
- (void)navigationBarLeftButClick:(UIButton *)but;
- (void)navigationBarRightButClick:(UIButton *)but;

@end

@interface WSNavigationBarButLabelButView : UIView

+ (instancetype)getView;

@property (weak, nonatomic) id<WSNavigationBarButLabelButViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *leftBut;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBut;

- (IBAction)leftButAction:(id)sender;
- (IBAction)rightButAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *saperateView;

@end
