//
//  TableToastView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/6.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTableToastView.h"
#import "WSBaseMacro.h"
#import "WSTableToastViewCell.h"
#import "WSBaseMacro.h"
#import "UIImage+WSResizable.h"

@implementation WSTableToastView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTableToastView" owner:nil options:nil];
    WSTableToastView *tableToastView = [array firstObject];
    tableToastView.tableViewTopCon.constant = 5;
    UIImage *image = [UIImage imageNamed:@"BaseStaticLibraryResource.bundle/Contents/Resources/tableToasgBg"];
    image = [image resizableImageWithModeTile];
    tableToastView.bgImageView.image = image;
    return tableToastView;
}

- (void)awakeFromNib
{
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"WSTableToastViewCell";
    WSTableToastViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [WSTableToastViewCell getCell];
    }
    NSInteger row = indexPath.row;
    cell.leftLabel.text = [_titleArray objectAtIndex:row];
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_callBack) {
        NSInteger row = indexPath.row;
        _callBack(row);
    }
    self.hidden = YES;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.bounds.size.height / _titleArray.count;
}

@end
