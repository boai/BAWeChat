//
//  NSString+Time.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/12.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (Time)


#pragma mark - *****  日期时间处理 类

/**
 *  获得系统当前日期和时间
 *
 *  @return 获得系统当前日期和时间
 */
+ (NSString *)ba_time_getCurrentDateAndTime;

/**
 *  时间戳转换【YYYY-MM-dd HH:mm:ss】
 *
 *  @param string 时间戳
 *
 *  @return 时间戳转换【YYYY-MM-dd HH:mm:ss】
 */
+ (NSString *)ba_time_getCurrentDateAndTimeWithTimeString:(NSString *)string;

/**
 *  时间戳转换【YYYY-MM-dd】
 *
 *  @param string 时间戳
 *
 *  @return 时间戳转换【YYYY-MM-dd】
 */
+ (NSString *)ba_time_getDateWithTimeString:(NSString *)string;

/**
 *  时间戳转换【HH:mm】
 *
 *  @param string 时间戳
 *
 *  @return 时间戳转换【HH:mm】
 */
+ (NSString *)ba_time_getTimeWithTimeString:(NSString *)string;

/**
 *  当前时间转换成时间戳
 *
 *  @return 当前时间转换成时间戳
 */
+ (NSString *)ba_time_getTimeStamp;

/*!
 *  日期转换星期
 *
 *  @param inputDate 日期
 *
 *  @return 返回星期几
 */
+ (NSString *)weekdayStringFromDate:(NSDate *)inputDate;

/*! 一般应用程序设置这一组的存在，比如夜间模式，如果你。从8：00-23：00。在这个当前的时间是如何推断出期间。主要的困难在于如何使用NSDate生成8：00时间和23：00时间。然后用当前时间，也许有足够的时间，以使控制。 */
/**
 * @brief 推断当前时间是否在fromHour和toHour之间。如。fromHour=8，toHour=23时。即为推断当前时间是否在8:00-23:00之间
 */
- (BOOL)ba_time_isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;

/*!
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比較）
 * @param hour 如hour为“8”。就是上午8:00（本地时间）
 */
- (NSDate *)ba_time_getCustomDateWithHour:(NSInteger)hour;

/*!
 *  计算上报时间差: 几分钟前，几天前，传入时间戳，自动解析
 *
 *  @return 计算上报时间差: 几分钟前，几天前
 */
- (NSString *)ba_time_format;

@end
NS_ASSUME_NONNULL_END
