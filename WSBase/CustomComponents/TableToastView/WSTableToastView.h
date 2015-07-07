//
//  TableToastView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/6.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TableToastViewDidSelectedCallBack)(NSInteger index);

@interface WSTableToastView : UIView <UITableViewDataSource, UITableViewDelegate>

+ (instancetype)getView;

@property (strong, nonatomic) TableToastViewDidSelectedCallBack callBack;
@property (strong, nonatomic) NSArray *titleArray;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *contentTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCon;

@end
