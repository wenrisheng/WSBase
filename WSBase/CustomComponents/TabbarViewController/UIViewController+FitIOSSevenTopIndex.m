//
//  UIViewController+FitIOSSevenTopIndex.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/8.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "UIViewController+FitIOSSevenTopIndex.h"

@implementation UIViewController (FitIOSSevenTopIndex)

- (void)distanceTopWindowMarginWithTopView:(UIView *)topView topMargin:(CGFloat)topMaring
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7) {
        NSArray *constraints = self.view.constraints;
        for (NSLayoutConstraint *layoutcon in constraints) {
            NSLayoutAttribute firstAttrible = layoutcon.firstAttribute;
            id firstItem = layoutcon.firstItem;
            if (firstItem == topView) {
                switch (firstAttrible) {
                    case NSLayoutAttributeTop:
                    {
                        [self.view removeConstraint:layoutcon];
                        NSLayoutConstraint *topLayoutConstraint = [NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeTop multiplier:0.0 constant:topMaring];
                        [self.view addConstraint:topLayoutConstraint];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
}

@end
