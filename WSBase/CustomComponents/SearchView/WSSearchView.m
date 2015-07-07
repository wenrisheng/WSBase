//
//  SearchView.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSSearchView.h"
#import "WSBaseMacro.h"

@implementation WSSearchView

+ (instancetype)getSearchView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSSearchView" owner:nil options:nil];
    return [array firstObject];
    
}

- (void)awakeFromNib
{
    _textField.delegate = self;
    [_textField setValue:SEARCHVIEWTEXTFIELD_PLACEPLODER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentView.layer.cornerRadius = _contentView.bounds.size.height * 0.5;
    _contentView.layer.masksToBounds = YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchViewDelegateTextFieldShouldBeginEditing:)]) {
        return [_delegate searchViewDelegateTextFieldShouldBeginEditing:textField];
    } else {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchViewDelegateTextFieldDidBeginEditing:)]) {
        return [_delegate searchViewDelegateTextFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchViewDelegateTextFieldDidEndEditing:)]) {
        [_delegate searchViewDelegateTextFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_delegate respondsToSelector:@selector(searchViewDelegateTextField:shouldChangeCharactersInRange:replacementString:)]) {
        return [_delegate searchViewDelegateTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([_delegate respondsToSelector:@selector(searchViewDelegateTextFieldShouldReturn:)]) {
        return [_delegate searchViewDelegateTextFieldShouldReturn:textField];
    } else {
        return YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
