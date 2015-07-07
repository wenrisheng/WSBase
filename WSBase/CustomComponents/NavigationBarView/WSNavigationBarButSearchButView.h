//
//  NavigationBarViewButSearchBut.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSSearchManagerView.h"

@class WSNavigationBarButSearchButView;
@protocol NavigationBarButSearchButViewDelegate <NSObject>

@optional
- (void)navigationBarLeftButClick:(UIButton *)but;
- (void)navigationBarRightButClick:(UIButton *)but;
- (BOOL)navigationBarSearchViewTextFieldShouldBeginEditing:(UITextField *)textField;
- (void)navigationBarSearchViewTextFieldDidBeginEditing:(UITextField *)textField;
- (void)navigationBarSearchViewTextFieldDidEndEditing:(UITextField *)textField;
- (BOOL)navigationBarSearchViewTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)navigationBarSearchViewTextFieldShouldReturn:(UITextField *)textField;

@end

@interface WSNavigationBarButSearchButView : UIView <WSSearchViewDelegate>

+ (instancetype)getNavigationBarViewButSearchButView;

@property (weak, nonatomic) id<NavigationBarButSearchButViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *leftview;

@property (weak, nonatomic) IBOutlet UIButton *leftBut;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet WSSearchManagerView *middleSearchManagerView;
@property (weak, nonatomic) IBOutlet UIButton *rightBut;
@property (weak, nonatomic) IBOutlet UIView *saperateView;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewTraillingCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLabelHeightCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLabelWidthCon;

@end
