//
//  CTTabSlideGapTextItemView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/22.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSTabSlideGapTextItemView;
typedef void(^WSTabSlideGapTextItemViewCallBack)(WSTabSlideGapTextItemView *itemView);

@interface WSTabSlideGapTextItemView : UIView

+ (instancetype)getView;

@property (assign, nonatomic) BOOL selected;
@property (strong, nonatomic) WSTabSlideGapTextItemViewCallBack callBack;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewHeightCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewWidthCon;
@property (weak, nonatomic) IBOutlet UIButton *but;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *leftGapView;
@property (weak, nonatomic) IBOutlet UIView *rightGapView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
- (IBAction)butClick:(id)sender;

@end
