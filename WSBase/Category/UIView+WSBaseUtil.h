//
//  UIView+WSCommonUtility.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/19.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WSBaseUtil)

//  获取当前uiview所在的viewController
@property (nonatomic, readonly) UIViewController *viewController;

// 扩展到supView大小
- (void)expandToSuperView;

// 相距supview 上、下、左、右
- (void)addConstraintToSuperViewWithTop:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right;

// 更新距离TopLayout顶部的距离
- (void)updateTopConstrainToTopLayoutGuideWithViewController:(UIViewController *)viewController topMargin:(CGFloat)topMargin;

//清除superview的约束
- (void)clearConstrainsToSuperView;

//清除self宽高的约束
- (void)clearWidthAndHeight;

// 设置边框线
- (void)setBorderCornerWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

// 清空subviews
- (void)clearSubviews;

- (void)constrainSubViewsForHorizontalAverage:(NSArray *)subViews;

- (void)autoresizingMaskSubViewsForHorizontalAverage:(NSArray *)subViews;

@end
