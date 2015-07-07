//
//  UILabel+WSCommonUtility.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/19.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "UILabel+WSBaseUtil.h"

@implementation UILabel (WSBaseUtil)

- (CGSize)boundingRectWithSize:(CGSize)size
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version <= 5) {
        [self.text sizeWithFont:self.font constrainedToSize:size];
    } else if (version == 6) {
        CGSize retSize = [self.text sizeWithFont:self.font
                     constrainedToSize:size
                         lineBreakMode:NSLineBreakByCharWrapping];
        return retSize;
    } else {
        NSDictionary *attribute = @{NSFontAttributeName: self.font};
        CGSize retSize = [self.text boundingRectWithSize:size
                                                 options:
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                              attributes:attribute
                                                 context:nil].size;
        return retSize;
    }
    return CGSizeZero;
}

@end
