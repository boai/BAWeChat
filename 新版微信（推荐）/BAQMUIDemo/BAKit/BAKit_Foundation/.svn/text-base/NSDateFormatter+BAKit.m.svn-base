//
//  NSDateFormatter+BAKit.m
//  BABaseProject
//
//  Created by 博爱 on 16/7/18.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "NSDateFormatter+BAKit.h"

@implementation NSDateFormatter (BAKit)

+ (id)ba_dateFormatter
{
    return [[self alloc] init];
}

+ (id)ba_dateFormatterWithFormat:(NSString *)dateFormat
{
//    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
//    timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDateFormatter *dateFormatter = [self ba_dateFormatter];
    dateFormatter.dateFormat = dateFormat;
//    [dateFormatter setTimeZone:timeZone];
    
    return dateFormatter;
}

+ (id)ba_setupDateFormatterWithYMDHMS
{
    return [self ba_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (id)ba_setupDateFormatterWithYMDEHMS
{
    return [self ba_dateFormatterWithFormat:@"yyyy-MM-dd, EEE, HH:mm:ss"];
}

+ (id)ba_setupDateFormatterWithYMD
{
    return [self ba_dateFormatterWithFormat:@"yyyy-MM-dd"];
}

+ (id)ba_setupDateFormatterWithYM
{
    return [self ba_dateFormatterWithFormat:@"yyyy-MM"];
}

+ (id)ba_setupDateFormatterWithYY
{
    return [self ba_dateFormatterWithFormat:@"yyyy"];
}

+ (id)ba_setupDateFormatterWithHM
{
    return [self ba_dateFormatterWithFormat:@"HH:mm"];
}

+ (id)ba_setupDateFormatterWithHMS
{
    return [self ba_dateFormatterWithFormat:@"HH:mm:ss"];
}


@end
