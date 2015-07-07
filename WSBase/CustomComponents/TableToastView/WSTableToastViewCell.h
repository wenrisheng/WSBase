//
//  WSTableToastViewCell.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/14.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WSTABLE_TOAST_VIEW_CELL_HEIGHT    44

@interface WSTableToastViewCell : UITableViewCell

+ (instancetype)getCell;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@end
