//
//  WSSearchTypeView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/12.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSSearchTypeView;

typedef void(^WSSearchTypeViewTypeButAction)(WSSearchTypeView *searchView);
typedef BOOL(^WSSearchTypeViewSearchShouldBeginEditing)(WSSearchTypeView *searchView);
typedef void(^WSSearchTypeViewSearchDidBeginEditing)(WSSearchTypeView *searchView);
typedef void(^WSSearchTypeViewSearchDidEndEditing)(WSSearchTypeView *searchView);
typedef BOOL(^WSSearchTypeViewSearchShouldReturn)(WSSearchTypeView *searchView);
typedef void(^WSSearchTypeViewSearchButAction)(WSSearchTypeView *searchView);

@interface WSSearchTypeView : UIView <UITextFieldDelegate>

+ (instancetype)getView;

@property (strong, nonatomic) WSSearchTypeViewTypeButAction typeButActionCallBack;
@property (strong, nonatomic) WSSearchTypeViewSearchShouldBeginEditing shouldBeginEditingCallback;
@property (strong, nonatomic) WSSearchTypeViewSearchDidBeginEditing didBeginEditingCallback;
@property (strong, nonatomic) WSSearchTypeViewSearchDidEndEditing didEndEditingCallback;
@property (strong, nonatomic) WSSearchTypeViewSearchShouldReturn shouldReturnCallback;
@property (strong, nonatomic) WSSearchTypeViewSearchButAction searchButCallback;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *contentView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *typeBut;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *centerTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *searchBut;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageview;

- (IBAction)typeButAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *leftView;
- (IBAction)searchButAction:(id)sender;

@end
