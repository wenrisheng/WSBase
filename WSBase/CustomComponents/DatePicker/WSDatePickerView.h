//
//  WSDatePickerView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/5/4.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSDatePickerView;
typedef void(^CancelCallBack)(WSDatePickerView *datePickerView);
typedef void(^ConfrimCallBack)(WSDatePickerView *datePickerView);

@interface WSDatePickerView : UIView

+ (instancetype)getView;

@property (copy) CancelCallBack cancelCallBack;
@property (copy) ConfrimCallBack confirmCallBack;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *containerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *saperateView;
@property (weak, nonatomic) IBOutlet UIView *saperateViewH;

- (IBAction)cancelButAction:(id)sender;
- (IBAction)confirmButAction:(id)sender;

@end
