//
//  NSString+WSCommon.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (WSBaseUtil)

//md5 32位 加密
// 小写
- (NSString *)encodeMD5_32_lowercase;
// 大写
- (NSString *)encodeMD5_32_uppercase;

//md5 16位加密 （大写）
- (NSString *)encodeMD5_16;

- (CGSize)boundingRectWithString:(NSString *)string size:(CGSize)size font:(UIFont *)font;

- (BOOL)isValidEmail;

- (BOOL)isValidNumber;

- (BOOL)isValidPhone;



//- (BOOL) isValidZipcode:(NSString*)value;
//- (BOOL) isValidateEmail:(NSString *)candidate;
//- (BOOL) isValidNumber:(NSString*)value;
//- (BOOL) isValidPhone:(NSString*)value;
//- (BOOL) isValidString:(NSString*)value;
//- (BOOL) isValidIdentifier:(NSString*)value;
//- (BOOL) isValidPassport:(NSString*)value;
////+ (BOOL) isValidCreditNumber:(NSString*)value;
//- (BOOL) isValidBirthday:(NSString*)birthday; // yyyyMMdd
//- (BOOL) isChinaUnicomPhoneNumber:(NSString*) phonenumber;

@end
