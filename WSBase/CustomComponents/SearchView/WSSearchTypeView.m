//
//  WSSearchTypeView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/12.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSSearchTypeView.h"
#import "UIView+WSBaseUtil.h"
#import "WSBaseMacro.h"
#import "UIButton+WSEnlargeResponseDomain.h"

#define SEARCH_TYPE_VIEW_TEXTFIELD_PLACEPLODER_COLOR  [UIColor colorWithRed:0.929 green:0.682 blue:0.702 alpha:1.000]

@implementation WSSearchTypeView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSSearchTypeView" owner:nil options:nil];
    return [array firstObject];
    
}

- (void)awakeFromNib
{
    [_contentView setBorderCornerWithBorderWidth:0 borderColor:[UIColor clearColor] cornerRadius:_contentView.bounds.size.height / 2];
    _centerTextField.delegate = self;
    [_centerTextField setValue:SEARCH_TYPE_VIEW_TEXTFIELD_PLACEPLODER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [_searchBut setEnlargeEdgeWithTop:20 right:20 bottom:20 left:10];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_shouldBeginEditingCallback) {
        return _shouldBeginEditingCallback(self);
    } else {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_didBeginEditingCallback) {
        _didBeginEditingCallback(self);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_didEndEditingCallback) {
        _didEndEditingCallback(self);
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (_shouldReturnCallback) {
        return _shouldReturnCallback(self);
    } else {
        return YES;
    }
}

- (IBAction)typeButAction:(id)sender
{
    if (_typeButActionCallBack) {
        _typeButActionCallBack(self);
    }
}
- (IBAction)searchButAction:(id)sender {
    if (_searchButCallback) {
        _searchButCallback(self);
    }
}
@end
