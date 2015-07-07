//
//  WSNavigationBarCenterLabelView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/16.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSNavigationBarCenterLabelView : UIView

+ (instancetype)getView;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *saperateView;

@end
