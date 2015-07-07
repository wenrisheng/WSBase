//
//  UIImage+WSResizable.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/15.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "UIImage+WSResizable.h"

@implementation UIImage (WSResizable)

- (UIImage *)resizableImageWithModeTile
{
    CGSize size = self.size;
    float leftEdge = (size.width - 1) * 0.5;
    float topEdge = (size.height - 1) * 0.5;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(topEdge, leftEdge, topEdge, leftEdge);
    UIImage *resultImage = [self resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeTile];
    return resultImage;
}

- (UIImage *)resizableImageWithModeStretch
{
    CGSize size = self.size;
    float leftEdge = (size.width - 1) * 0.5;
    float topEdge = (size.height - 1) * 0.5;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(topEdge, leftEdge, topEdge, leftEdge);
    UIImage *resultImage = [self resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
    return resultImage;
}


@end
