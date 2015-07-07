//
//  WSNavigationBarCenterImageViewLabelView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/19.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSNavigationBarCenterImageViewLabelView : UIView

+ (instancetype)getView;

@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;
@property (weak, nonatomic) IBOutlet UIView *saperateView;

@end
