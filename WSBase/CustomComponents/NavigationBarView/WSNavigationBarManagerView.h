//
//  NavigationBarManagerView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSNavigationBarView.h"
#import "WSNavigationBarButSearchButView.h"
#import "WSNavigationBarButLabelView.h"
#import "WSNavigationBarLabelButView.h"
#import "WSNavigationBarCenterLabelView.h"
#import "WSNavigationBarButLabelButView.h"
#import "WSNavigationBarCenterImageViewLabelView.h"

typedef NS_ENUM(NSInteger, WSNavigationBarManagerViewType) {
    WSNavigationBarManagerViewTypeBlank = 100,
    WSNavigationBarManagerViewTypeButSearchBut = 101,
    WSNavigationBarManagerViewTypeButLabel = 102,
    WSNavigationBarManagerViewTypeLabelBut = 103,
    WSNavigationBarManagerViewTypeCenterLabel = 104,
    WSNavigationBarManagerViewTypeButLabelBut = 105,
    wsnavigationbarManagerViewTypeCenterImageViewLabel = 106
};

@interface WSNavigationBarManagerView : UIView

@property (strong, nonatomic) WSNavigationBarView *navigationBarView;
@property (strong, nonatomic) WSNavigationBarButSearchButView *navigationBarButSearchButView;
@property (strong, nonatomic) WSNavigationBarButLabelView *navigationBarButLabelView;
@property (strong, nonatomic) WSNavigationBarLabelButView *navigationBarLabelButView;
@property (strong, nonatomic) WSNavigationBarCenterLabelView *navigationBarCenterLabelView;
@property (strong, nonatomic) WSNavigationBarButLabelButView *navigationBarButLabelButView;
@property (strong, nonatomic) WSNavigationBarCenterImageViewLabelView *navigationBarCenterImageViewLabelView;

@end
