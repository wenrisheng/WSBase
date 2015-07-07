//
//  SearchView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SEARCHVIEWTEXTFIELD_PLACEPLODER_COLOR  [UIColor colorWithRed:0.929 green:0.682 blue:0.702 alpha:1.000]

@protocol WSSearchViewDelegate <NSObject>

@optional
- (BOOL)searchViewDelegateTextFieldShouldBeginEditing:(UITextField *)textField;
- (void)searchViewDelegateTextFieldDidBeginEditing:(UITextField *)textField;
- (void)searchViewDelegateTextFieldDidEndEditing:(UITextField *)textField;
- (BOOL)searchViewDelegateTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)searchViewDelegateTextFieldShouldReturn:(UITextField *)textField;

@end

@interface WSSearchView : UIView <UITextFieldDelegate>

+ (instancetype)getSearchView;

@property (weak, nonatomic) id<WSSearchViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
