//
//  WSChinaAreaPickerView.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/6/17.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSChinaAreaPickerView;
typedef void(^AreaCancelCallBack)(WSChinaAreaPickerView *datePickerView);
typedef void(^AreaConfrimCallBack)(WSChinaAreaPickerView *datePickerView);

@interface WSChinaAreaPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
}

+ (instancetype)getView;

@property (readonly) NSString *address;
@property (copy) AreaCancelCallBack cancelCallBack;
@property (copy) AreaConfrimCallBack confirmCallBack;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *saperateView;
@property (weak, nonatomic) IBOutlet UIView *saperateViewH;

- (IBAction)cancelButAction:(id)sender;
- (IBAction)confirmButAction:(id)sender;

@end
