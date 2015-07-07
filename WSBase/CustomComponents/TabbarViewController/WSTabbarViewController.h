//
//  TabbarViewControllerViewController.h
//  CustomTabbarViewController
//
//  Created by wrs on 15/4/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTabbarItemView.h"

#define TABBARITEM_VIEWCONTROLLER                      @"TabbarItem_viewcontroller"           // UIViewController
#define TABBARITEM_IMAGE_NORMAL                        @"TabbarItem_image_normal"            // 正常状体图片
#define TABBARITEM_IMAGE_SELECTED                      @"TabbarItem_image_selected"          // 选中状态图片
#define TABBARITEM_TITLE                               @"TabbarItem_image_title"             // 标题
#define TABBARITEM_TITLE_COLOR_NORMAL                  @"TabbarItem_title_color_normal"      // 正常状态标题颜色
#define TABBARITEM_TITLE_COLOR_SELECTED                @"TabbarItem_title_color_selected"    // 选中状态标题颜色

#define TABBARITEM_TITLE_COLOR_NORMAL_DEFAULT          [UIColor colorWithRed:0.486 green:0.486 blue:0.490 alpha:1.000]                  // 正常状态标题默认颜色
#define TABBARITEM_TITLE_COLOR_SELECTED_DEFAULT        [UIColor redColor]                    // 选中状态标题默认颜色

@protocol WSTabbarViewControllerDelegate <NSObject>

- (void)tabbarViewControllerDidSelectedIndex:(int)index;

@end

@interface WSTabbarViewController : UIViewController

@property (weak, nonatomic) id<WSTabbarViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *dataArray;  // 用NSDictionary存储TabbarItem的数据，对应的key为上面对应的宏
@property (assign, nonatomic) int initIndex;

- (void)selectedIndex:(int)index;

@end
