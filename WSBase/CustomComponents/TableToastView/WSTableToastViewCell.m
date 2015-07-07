//
//  WSTableToastViewCell.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/14.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTableToastViewCell.h"
#import "WSBaseMacro.h"

@implementation WSTableToastViewCell

+ (instancetype)getCell
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTableToastViewCell" owner:nil options:nil];

    return [array firstObject];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
