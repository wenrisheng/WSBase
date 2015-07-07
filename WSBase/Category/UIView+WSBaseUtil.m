//
//  UIView+WSCommonUtility.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/19.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "UIView+WSBaseUtil.h"

@implementation UIView (WSBaseUtil)

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)expandToSuperView
{
    // 清除self的约束
    [self clearSelfConstrains];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *superView = self.superview;
    UIView *view = self;
    NSDictionary *dic = NSDictionaryOfVariableBindings(view);
    NSArray *hcon=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:dic];
    NSArray *vcon=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:dic];
    [superView addConstraints:hcon];
    [superView addConstraints:vcon];
    
}

- (void)addConstraintToSuperViewWithTop:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 清除self的约束
    [self clearSelfConstrains];
    
    UIView *superView = self.superview;
    NSLayoutConstraint *topCon = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:top];
    NSLayoutConstraint *bottomCon = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:bottom];
    NSLayoutConstraint *leftCon = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:left];
    NSLayoutConstraint *rightCon = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1.0 constant:right];
    [superView addConstraints:@[topCon, bottomCon, leftCon, rightCon]];
}

- (void)updateTopConstrainToTopLayoutGuideWithViewController:(UIViewController *)viewController topMargin:(CGFloat)topMargin
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7) {
        UIView *superView = viewController.view;
        NSArray *constraints = superView.constraints;
        for (NSLayoutConstraint *layoutcon in constraints) {
            NSLayoutAttribute firstAttrible = layoutcon.firstAttribute;
            id firstItem = layoutcon.firstItem;
            if (firstItem == self) {
                switch (firstAttrible) {
                    case NSLayoutAttributeTop:
                    {
                        [superView removeConstraint:layoutcon];
                        id<UILayoutSupport> topLayoutGuide = viewController.topLayoutGuide;
                        NSLayoutConstraint *topLayoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topLayoutGuide attribute:NSLayoutAttributeTop multiplier:0.0 constant:topMargin];
                        [superView addConstraint:topLayoutConstraint];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
}

- (void)clearSelfConstrains
{
    [self clearConstrainsToSuperView];
    [self clearWidthAndHeight];
}

//清除superview的约束
- (void)clearConstrainsToSuperView
{
    NSArray *superConstraints = self.superview.constraints;
    for (NSLayoutConstraint *layoutcon in superConstraints) {
        id firstItem = layoutcon.firstItem;
        id secondItem = layoutcon.secondItem;
        if (firstItem == self || secondItem == self) {
            [self.superview removeConstraint:layoutcon];
        }
    }
}

//清除self宽高的约束
- (void)clearWidthAndHeight
{
    NSArray *selfConstraints = self.constraints;
    for (NSLayoutConstraint *layoutcon in selfConstraints) {
        id firstItem = layoutcon.firstItem;
        NSLayoutAttribute firstAttribute = layoutcon.firstAttribute;
        BOOL flag1 = (firstItem == self);
        BOOL flag2 = ((firstAttribute == NSLayoutAttributeWidth) || (firstAttribute == NSLayoutAttributeHeight));
        if (flag1 && flag2) {
            [self removeConstraint:layoutcon];
        }
    }
}


- (void)setBorderCornerWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
    [self clipsToBounds];
}

// 清空subviews
- (void)clearSubviews
{
    NSArray *array = self.subviews;
    for (UIView *subView in array) {
        [subView removeFromSuperview];
    }
}

- (void)constrainSubViewsForHorizontalAverage:(NSArray *)subViews
{
    if (subViews.count == 0) {
        return;
    }
    NSUInteger itemCount = subViews.count;
    CGFloat itemCountFloat = (float)itemCount / 1.00;
    for (int i = 0; i < itemCount; i++) {
        UIView *subview = [subViews objectAtIndex:i];
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        
        // 修复ios 8.3multiplier不能为0的bug，8.3以前的版本系统报约束有错但会帮你修复，8.3直接闪退
        NSLayoutConstraint *left;
        CGFloat multiplier = i / itemCountFloat;
        if (multiplier == 0) {
            left =  [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        } else {
            left = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:(i / itemCountFloat) constant:0];
        }

        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:(1 / itemCountFloat) constant:0];
        [self addConstraints:@[top, bottom, left, width]];
    }
}

- (void)autoresizingMaskSubViewsForHorizontalAverage:(NSArray *)subViews
{

    NSInteger itemCount = subViews.count;
    if (itemCount == 0) {
        return;
    }
    UIView *superView = [[subViews objectAtIndex:0] superview];
    CGRect rect = superView.bounds;
    CGFloat width = rect.size.width / itemCount;
    CGFloat y = 0;
    CGFloat height = rect.size.height;
    for (int i = 0; i < itemCount; i ++) {
        UIView *itemView = [subViews objectAtIndex:i];
        itemView.translatesAutoresizingMaskIntoConstraints = YES;
        CGFloat x = i * width;
        itemView.frame = CGRectMake(x, y, width, height);
        itemView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    }
}

@end
