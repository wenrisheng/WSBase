//
//  SearchManagerView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSSearchView.h"
#import "WSSearchTypeView.h"

typedef NS_ENUM(NSInteger, WSSearchManagerViewType) {
    WSSearchManagerViewTypeSearchView = 100,
    WSSearchManagerViewTypeSearchTypeView = 101
};

@interface WSSearchManagerView : UIView

@property (strong, nonatomic) WSSearchView *searchView;
@property (strong, nonatomic) WSSearchTypeView *searchTypeView;

@end
