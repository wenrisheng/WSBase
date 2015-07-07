//
//  NSString+WSCommon.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "NSString+WSBaseUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (WSCommonUtility)

- (NSString *)encodeMD5_32_lowercase
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)encodeMD5_32_uppercase
{
    return [self encodeMD5_32_lowercase].uppercaseString;
}

- (NSString *)encodeMD5_16
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

- (CGSize)boundingRectWithString:(NSString *)string size:(CGSize)size font:(UIFont *)font
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version <= 5) {
        [string sizeWithFont:font constrainedToSize:size];
    } else if (version == 6) {
        CGSize retSize = [string sizeWithFont:font
                            constrainedToSize:size
                                lineBreakMode:NSLineBreakByCharWrapping];
        return retSize;
    } else {
        NSDictionary *attribute = @{NSFontAttributeName:font};
        CGSize retSize = [string boundingRectWithSize:size
                                              options:
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                           attributes:attribute
                                              context:nil].size;
        return retSize;
    }
    return CGSizeZero;
    
}

- (BOOL)isValidEmail
{
    NSArray *array = [self componentsSeparatedByString:@"."];
    if ([array count] >= 4) {
        return FALSE;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//- (BOOL)isValidNumber
//{
//    
//}

- (BOOL)isValidPhone
{
    const char *cvalue = [self UTF8String];
    int len = (int)strlen(cvalue);
    if (len != 11) {
        return FALSE;
    }
//    if (![self isValidNumber:self])
//    {
//        return FALSE;
//    }
    NSString *preString = [[NSString stringWithFormat:@"%@",self] substringToIndex:2];
    if ([preString isEqualToString:@"13"] ||
        [preString isEqualToString: @"15"] ||
        [preString isEqualToString: @"18"])
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
    return TRUE;
}

//- (BOOL) isValidZipcode:(NSString*)value
//{
//    const char *cvalue = [value UTF8String];
//    int len = (int)strlen(cvalue);
//    if (len != 6) {
//        return FALSE;
//    }
//    for (int i = 0; i < len; i++)
//    {
//        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
//        {
//            return FALSE;
//        }
//    }
//    return TRUE;
//}
//
//- (BOOL) isValidateEmail:(NSString *)candidate
//{

//}
//
//- (BOOL) isValidNumber:(NSString*)value
//{
//    const char *cvalue = [value UTF8String];
//    int len = (int)strlen(cvalue);
//    for (int i = 0; i < len; i++) {
//        if(!isNumber(cvalue[i])){
//            return FALSE;
//        }
//    }
//    return TRUE;
//}
//
//- (BOOL) isValidPhone:(NSString*)value {
//    const char *cvalue = [value UTF8String];
//    int len = (int)strlen(cvalue);
//    if (len != 11) {
//        return FALSE;
//    }
//    if (![self isValidNumber:value])
//    {
//        return FALSE;
//    }
//    NSString *preString = [[NSString stringWithFormat:@"%@",value] substringToIndex:2];
//    if ([preString isEqualToString:@"13"] ||
//        [preString isEqualToString: @"15"] ||
//        [preString isEqualToString: @"18"])
//    {
//        return TRUE;
//    }
//    else
//    {
//        return FALSE;
//    }
//    return TRUE;
//}
//
//- (BOOL) isValidString:(NSString*)value
//{
//    return value && [value length];
//}
//
//const int factor[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };//加权因子
//const int checktable[] = { 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 };//校验值对应表
//
//- (BOOL) isValidIdentifier:(NSString*)value
//{
//    const int LENGTH = 18;
//    const char *str = [[value lowercaseString] UTF8String];
//    NSInteger i;
//    NSInteger length = strlen(str);
//    BOOL result = TRUE;
//    /*
//     * identifier length is invalid
//     */
//    if (15 != length && LENGTH != length)
//    {
//        result = FALSE;
//    }
//    else
//    {
//        for (i = 1; i < length - 1; i++)
//        {
//            if(!(str[i] >= '0' && str[i] <= '9'))
//            {
//                result = FALSE;
//                break;
//            }
//        }
//        if (result)
//        {
//            if(LENGTH == length)
//            {
//                if (!((str[i] >= '0' && str[i] <= '9')||str[i] == 'X'||str[i] == 'x'))
//                {
//                    result = FALSE;
//                }
//            }
//        }
//        /*
//         * check sum for second generation identifier
//         */
//        if (result && length == LENGTH)
//        {
//            int i;
//            int *ids = malloc(sizeof(int)*LENGTH);
//            for (i = 0; i < LENGTH; i++)
//            {
//                ids[i] = str[i] - 48;
//            }
//            int checksum = 0;
//            for (i = 0; i < LENGTH - 1; i ++ )
//            {
//                checksum += ids[i] * factor[i];
//            }
//            if (ids[17] == checktable[checksum%11]||
//                (str[17] == 'x' && checktable[checksum % 11] == 10))
//            {
//                result  = TRUE;
//            }
//            else
//            {
//                result  = FALSE;
//            }
//            free(ids);
//            ids = NULL;
//        }
//    }
//    return result;
//}
//
//- (BOOL) isValidPassport:(NSString*)value
//{
//    const char *str = [value UTF8String];
//    char first = str[0];
//    NSInteger length = strlen(str);
//    if (!(first == 'P' || first == 'G'))
//    {
//        return FALSE;
//    }
//    if (first == 'P')
//    {
//        if (length != 8)
//        {
//            return FALSE;
//        }
//    }
//    if (first == 'G')
//    {
//        if (length != 9)
//        {
//            return FALSE;
//        }
//    }
//    BOOL result = TRUE;
//    for (NSInteger i = 1; i < length; i++)
//    {
//        if (!(str[i] >= '0' && str[i] <= '9'))
//        {
//            result = FALSE;
//            break;
//        }
//    }
//    return result;
//}
///*
// * 常用信用卡卡号规则
// * Issuer Identifier  Card Number                            Length
// * Diner's Club       300xxx-305xxx, 3095xx, 36xxxx, 38xxxx  14
// * American Express   34xxxx, 37xxxx                         15
// * VISA               4xxxxx                                 13, 16
// * MasterCard         51xxxx-55xxxx                          16
// * JCB                3528xx-358xxx                          16
// * Discover           6011xx                                 16
// * 银联                622126-622925                          16
// *
// * 信用卡号验证基本算法：
// * 偶数位卡号奇数位上数字*2，奇数位卡号偶数位上数字*2。
// * 大于10的位数减9。
// * 全部数字加起来。
// * 结果不是10的倍数的卡号非法。
// * prefrences link:http://www.truevue.org/licai/credit-card-no
// *
// */
////+ (BOOL) isValidCreditNumber:(NSString*)value
////{
////    BOOL result = TRUE;
////    NSInteger length = [value length];
////    if (length >= 13)
////    {
////        result = [WSIdentifierValidator isValidNumber:value];
////        if (result)
////        {
////            NSInteger twoDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 2)] integerValue];
////            NSInteger threeDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 3)] integerValue];
////            NSInteger fourDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 4)] integerValue];
////            //Diner's Club
////            if (((threeDigitBeginValue >= 300 && threeDigitBeginValue <= 305)||
////                 fourDigitBeginValue == 3095||twoDigitBeginValue==36||twoDigitBeginValue==38) && (14 != length))
////            {
////                result = FALSE;
////            }
////
////            //VISA
////            else if([value isStartWithString:@"4"] && !(13 == length||16 == length))
////            {
////                result = FALSE;
////            }
////            //MasterCard
////            else if((twoDigitBeginValue >= 51||twoDigitBeginValue <= 55) && (16 != length))
////            {
////                result = FALSE;
////            }
////            //American Express
////            else if(([value isStartWithString:@"34"]||[value isStartWithString:@"37"]) && (15 != length))
////            {
////                result = FALSE;
////            }
////            //Discover
////            else if([value isStartWithString:@"6011"] && (16 != length))
////            {
////                result = FALSE;
////            }
////            else
////            {
////                NSInteger begin = [[value substringWithRange:NSMakeRange(0, 6)] integerValue];
////                //CUP
////                if ((begin >= 622126 && begin <= 622925) && (16 != length))
////                {
////                    result = FALSE;
////                }
////                //other
////                else
////                {
////                    result = TRUE;
////                }
////            }
////        }
////        if (result)
////        {
////            NSInteger digitValue;
////            NSInteger checkSum = 0;
////            NSInteger index = 0;
////            NSInteger leftIndex;
////            //even length, odd index
////            if (0 == length%2)
////            {
////                index = 0;
////                leftIndex = 1;
////            }
////            //odd length, even index
////            else
////            {
////                index = 1;
////                leftIndex = 0;
////            }
////            while (index < length)
////            {
////                digitValue = [[value substringWithRange:NSMakeRange(index, 1)] integerValue];
////                digitValue = digitValue*2;
////                if (digitValue >= 10)
////                {
////                    checkSum += digitValue/10 + digitValue%10;
////                }
////                else
////                {
////                    checkSum += digitValue;
////                }
////                digitValue = [[value substringWithRange:NSMakeRange(leftIndex, 1)] integerValue];
////                checkSum += digitValue;
////                index += 2;
////                leftIndex += 2;
////            }
////            result = (0 == checkSum%10) ? TRUE:FALSE;
////        }
////    }
////    else
////    {
////        result = FALSE;
////    }
////    return result;
////}
//- (BOOL) isValidBirthday:(NSString*)birthday
//{
//    BOOL result = FALSE;
//    if (birthday && 8 == [birthday length])
//    {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyyMMdd"];
//        NSDate *date = [formatter dateFromString:birthday];
//        if (date)
//        {
//            result = TRUE;
//        }
//    }
//    return result;
//}
//
//+ (BOOL) isChinaUnicomPhoneNumber:(NSString*) phonenumber
//{
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    //    /**
//    //     15         * 中国联通：China Unicom
//    //     16         * 130,131,132,152,155,156,185,186
//    //     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    //    /**
//    //     20         * 中国电信：China Telecom
//    //     21         * 133,1349,153,180,189
//    //     22         */
//    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    //    /**
//    //     25         * 大陆地区固话及小灵通
//    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
//    //     27         * 号码：七位或八位
//    //     28         */
//    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    //    NSString * PHS1 = @"^0(10|2[0-5789]|\\d{3}-)\\d{7,8}$";
//    
//    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    //    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
//    //    NSPredicate *regextestphs1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS1];
//    
//    if (//([regextestmobile evaluateWithObject:phonenumber] == YES)||
//        //        ([regextestcm evaluateWithObject:phonenumber] == YES)||
//        //        ([regextestct evaluateWithObject:phonenumber] == YES)||
//        ([regextestcu evaluateWithObject:phonenumber] == YES)
//        //        || ([regextestphs evaluateWithObject:phonenumber] == YES)
//        //        || ([regextestphs1 evaluateWithObject:phonenumber] == YES)
//        )
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}


@end
