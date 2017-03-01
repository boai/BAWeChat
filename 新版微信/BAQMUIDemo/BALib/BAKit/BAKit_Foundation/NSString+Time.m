//
//  NSString+Time.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/12.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "NSString+Time.h"
#import "NSDate+BAKit.h"

@implementation NSString (Time)

#pragma mark - 处理时间是今天、昨天...

//+ (NSString *)ba_stringTimeWithTime:(NSString *)time
//{
//    /*! 请求下来的时间数据是字符串，将字符串转为这种样式yyyy-MM-dd hh:mm:ss的时间 【如果是时间戳请自行转换】*/
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    
//    /*! 将字符串按照设定的样式转成日期 */
//    NSDate *createDate = [formatter dateFromString:time];
//    
//    /*! 获取发帖时间与当前时间在小时和分钟的差值 */
//    NSDateComponents *createDateComponents = [createDate ba_dateCompareWithNow];
//    
//    NSString *timeString = @"";
//    /*! 判断今年（今天（>1小时内，>1分钟；<1分钟），昨天，昨天前；），非今年； */
//    /*! 今年 */
//    if ([createDate ba_dateIsCurrentYear])
//    {
//        /*! 今天 */
//        if ([createDate ba_dateIsToday])
//        {
//            if (createDateComponents.hour > 1)
//            {
//                timeString = [NSString stringWithFormat:@"%zd小时前", createDateComponents.hour];
//            }
//            else if (createDateComponents.minute > 1)
//            {
//                timeString = [NSString stringWithFormat:@"%zd分钟前", createDateComponents.minute];
//            }
//            else
//            {
//                timeString = @"刚刚";
//            }
//        }
//        /*! 昨天 */
//        else if ([createDate ba_dateIsYestoday])
//        {
//            formatter.dateFormat = @"昨天 HH:mm" ;
//            timeString = [formatter stringFromDate:createDate] ;
//        }
//        /*! 昨天前 */
//        else
//        {
//            formatter.dateFormat = @"MM-dd HH:mm:ss" ;
//            timeString = [formatter stringFromDate:createDate] ;
//        }
//    }
//    /*! 非今年 */
//    else
//    {
//        formatter.dateFormat = @"MM-dd HH:mm:ss" ;
//        timeString = [formatter stringFromDate:createDate] ;
//    }
//    
//    return timeString;
//}


/*
 今年
 今天
 >1 小时
 2小时前
 
 >= 1 分钟
 1分钟前
 
 < 1分钟
 刚刚
 
 昨天
 昨天 14:30
 
 昨天之前
 10-23 14:37:20
 
 非今年
 2015-10-26 14:37:20
 */


@end
