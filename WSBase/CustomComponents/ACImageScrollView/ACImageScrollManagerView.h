//
//  AcImageScrollManagerView.h
//  广告循环滚动效果
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 Qzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACImageScrollView.h"

typedef NS_ENUM(NSInteger, ACImageScrollManagerViewType) {
    ACImageScrollManagerViewTypeDefault = 100,

};


@interface ACImageScrollManagerView : UIView

@property (strong, nonatomic) ACImageScrollView *acImageScrollView;

@end
