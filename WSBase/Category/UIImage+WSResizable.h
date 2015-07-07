//
//  UIImage+WSResizable.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/15.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WSResizable)

/**
*  平铺中间一个像素，四周不变 NS_AVAILABLE_IOS(IOS6)
*
*  @return
*/
- (UIImage *)resizableImageWithModeTile;

/**
 *  拉伸中间一个像素，四周不变 NS_AVAILABLE_IOS(IOS6)
 *
 *  @return
 */
- (UIImage *)resizableImageWithModeStretch;

@end
