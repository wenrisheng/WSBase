//
//  AcImageScrollView.h
//  广告循环滚动效果
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 Qzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

//[[SDImageCache sharedImageCache] clearDisk];
//
//[[SDImageCache sharedImageCache] clearMemory];


typedef void(^ACImageScrollViewCallBack)(int index);

@interface ACImageScrollView : UIView

@property (copy) void(^downloadImageFinish)(NSInteger index, UIImage *image);

+ (instancetype)getView;

- (void)setImageData:(NSArray *)imageNames;

@property (strong, nonatomic) ACImageScrollViewCallBack callback;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
