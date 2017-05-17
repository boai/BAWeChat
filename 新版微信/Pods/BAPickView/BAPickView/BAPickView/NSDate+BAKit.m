
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#import "NSDate+BAKit.h"
#import "NSDateFormatter+BAKit.h"

#define k_MINUTE	60
#define k_HOUR		3600
#define k_DAY		86400
#define k_WEEK		604800
#define k_YEAR		31556926

#define BAKi_DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)

@implementation NSDate (BAKit)

- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + k_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [BAKit_Current_Calendar components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)hour
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear
{
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday
{
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (BOOL)isYesterday
{
    NSDate *added = [self dateByAddingDays:1];
    return [added isToday];
}

- (BOOL)isTomorrow
{
    return [self ba_dateIsEqualToDateIgnoringTime:BAKit_Current_Date];
}

- (BOOL)isThisWeek
{
    return [self ba_dateIsSameWeekAsDate:BAKit_Current_Date];
}

- (BOOL)isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + k_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ba_dateIsSameWeekAsDate:newDate];
}

- (BOOL)isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - k_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ba_dateIsSameWeekAsDate:newDate];
}

- (BOOL)isThisMonth
{
    return [self ba_dateIsSameMonthAsDate:BAKit_Current_Date];
}

- (BOOL)isThisYear
{
    return [self ba_dateIsSameYearAsDate:BAKit_Current_Date];
}

- (BOOL)isNextYear
{
    NSDateComponents *components1 = [BAKit_Current_Calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [BAKit_Current_Calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear
{
    NSDateComponents *components1 = [BAKit_Current_Calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [BAKit_Current_Calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)isInFuture
{
    return [self ba_dateIsLaterThanDate:BAKit_Current_Date];
}

- (BOOL)isInPast
{
    return [self ba_dateIsEarlierThanDate:BAKit_Current_Date];
}

- (BOOL)isTypicallyWorkday
{
    NSDateComponents *components = [BAKit_Current_Calendar components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
    {
        return YES;
    }
    return NO;
}

- (BOOL)isTypicallyWeekend
{
    return !self.isTypicallyWorkday;
}

#pragma mark - 格式化日期描述
- (NSString *)ba_dateFormattedWithDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:BAKit_Current_Date];//当前年月日
    
    //    NSLog(@"当前时间3： %@", self);
    
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    
    //    NSLog(@"当前时间4： %ld", (long)timeInterval);
    
    if (timeInterval < 60)
    {
        return @"刚刚";
    }
    else if
        (timeInterval < 3600)
    {
        // 1小时内
        return [NSString stringWithFormat:@"%zd分钟前", timeInterval / 60];
    }
    else if (timeInterval < 21600)
    {
        // 6小时内
        return [NSString stringWithFormat:@"%zd小时内", timeInterval / 3600];
    }
    else if ([theDay isEqualToString:currentDay])
    {
        // 当天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self]];
    }
    else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400)
    {
        // 昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    }
    else
    {
        // 以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

+ (NSString *)ba_dateCreated_at:(NSString *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    if (date.length == 16 )
    {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // 获得发布的具体时间
    NSDate *createDate = [formatter dateFromString:date];
    
    // 判断是否为今年
    if (createDate)
    {
        if (createDate.isThisYear)
        {
            // 今天
            NSDateComponents *cmps = [createDate ba_dateDeltaWithNow];
            if (cmps.hour >= 1)
            {
                // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            }
            else if (cmps.minute >= 1)
            {
                // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            }
            else
            {
                // 1分钟内发的
                return @"刚刚";
            }
        }
        else if (createDate.isYesterday)
        {
            // 昨天
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:createDate];
        }
        else
        {
            // 至少是前天
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:createDate];
        }
    }
    else
    {
        // 非今年
        formatter.dateFormat = @"yyyy-MM-dd";
        return [formatter stringFromDate:createDate];
    }
}

+ (NSString *)ba_dateAfterYears:(NSInteger)count
{
    NSDate *date = BAKit_Current_Date;
    NSTimeInterval time = count * 365 * 24 * 60 * 60;
    date = [date dateByAddingTimeInterval:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"China"];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [formatter stringFromDate:date];
    return selfStr;
}

- (NSDate *)ba_dateWithYMD
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [formatter stringFromDate:self];
    return [formatter dateFromString:selfStr];
}

- (NSDate *)ba_dateWithYM
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    NSString *selfStr = [formatter stringFromDate:self];
    return [formatter dateFromString:selfStr];
}

- (NSDateComponents *)ba_dateDeltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    return [calendar components:unit fromDate:self toDate:BAKit_Current_Date options:0];
}

/**
 距离当前的时间间隔描述
 
 @return 时间间隔描述
 */
- (NSString *)ba_dateTimeIntervalDescription
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return NSLocalizedString(@"NSDateCategory.text1", @"");
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2", @""), timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3", @""), timeInterval / 3600];
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text4", @""), timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text5", @"")];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text6", @""), timeInterval / 31536000];
    }
}

/**
 精确到分钟的日期描述
 
 @return 日期描述
 */
- (NSString *)ba_dateMinuteDescription
{
    NSDateFormatter *dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:@"yyyy-MM-dd"];
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:BAKit_Current_Date];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @'"'), [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

/**
 标准时间日期描述
 
 @return 标准时间日期描述
 */
- (NSString *)ba_dateFormattedTime
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:BAKit_Current_Date];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    NSInteger hour = [self ba_dateHoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text8", @"")];
        }else {
            dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text9", @"")];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text10", @"")];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text11", @"")];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text12", @"")];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text13", @"")];
        }else  {
            dateFormatter = [NSDateFormatter ba_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
        }
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

/**
 当前日期 距离 1970 时间间隔毫秒
 
 @return 当前日期 距离 1970 时间间隔毫秒
 */
- (double)ba_dateTimeIntervalSince1970InMilliSecond
{
    double ret;
    ret = [self timeIntervalSince1970] * 1000;
    
    return ret;
}

/**
 距离 时间间隔毫秒 后的日期
 
 @param timeIntervalInMilliSecond 时间间隔毫秒
 @return 距离 时间间隔毫秒 后的日期
 */
+ (NSDate *)ba_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond
{
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000)
    {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

/**
 时间间隔格式化
 
 @param time 时间间隔
 @return 时间格式化
 */
+ (NSString *)ba_dateFormattedTimeFromTimeInterval:(long long)time
{
    return [[NSDate ba_dateWithTimeIntervalInMilliSecondSince1970:time] ba_dateFormattedTime];
}

#pragma mark - 距离当前日期最近的日期
+ (NSDate *)ba_dateTomorrow
{
    return [NSDate ba_dateWithDaysFromNow:1];
}

+ (NSDate *)ba_dateYesterday
{
    return [NSDate ba_dateWithDaysBeforeNow:1];
}

+ (NSDate *)ba_dateWithDaysFromNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [BAKit_Current_Date dateByAddingDays:days];
}

+ (NSDate *)ba_dateWithDaysBeforeNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [BAKit_Current_Date ba_dateBySubtractingDays:days];
}

+ (NSDate *)ba_dateWithHoursFromNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [BAKit_Current_Date timeIntervalSinceReferenceDate] + k_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)ba_dateWithHoursBeforeNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [BAKit_Current_Date timeIntervalSinceReferenceDate] - k_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)ba_dateWithMinutesFromNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [BAKit_Current_Date timeIntervalSinceReferenceDate] + k_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)ba_dateWithMinutesBeforeNow:(NSInteger)dMinutes;
{
    NSTimeInterval aTimeInterval = [BAKit_Current_Date timeIntervalSinceReferenceDate] - k_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - 比较日期
- (BOOL)ba_dateIsEqualToDateIgnoringTime:(NSDate *)aDate
{
    NSDateComponents *components1 = [BAKit_Current_Calendar components:BAKi_DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [BAKit_Current_Calendar components:BAKi_DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

// This hard codes the assumption that a week is 7 days
- (BOOL)ba_dateIsSameWeekAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [BAKit_Current_Calendar components:BAKi_DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [BAKit_Current_Calendar components:BAKi_DATE_COMPONENTS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < k_WEEK);
}

- (BOOL)ba_dateIsSameMonthAsDate :(NSDate *)aDate
{
    NSDateComponents *components1 = [BAKit_Current_Calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [BAKit_Current_Calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)ba_dateIsSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [BAKit_Current_Calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [BAKit_Current_Calendar components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)ba_dateIsEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)ba_dateIsLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

#pragma mark - 调整日期
- (NSDate *)ba_dateByAddingDays:(NSInteger)dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + k_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)ba_dateBySubtractingDays:(NSInteger)dDays
{
    return [self ba_dateByAddingDays:(dDays * -1)];
}

- (NSDate *)ba_dateByAddingHours:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + k_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)ba_dateBySubtractingHours:(NSInteger)dHours
{
    return [self ba_dateByAddingHours:(dHours * -1)];
}

- (NSDate *)ba_dateByAddingMinutes:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + k_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)ba_dateBySubtractingMinutes:(NSInteger)dMinutes
{
    return [self ba_dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *)ba_dateAtStartOfDay
{
    NSDateComponents *components = [BAKit_Current_Calendar components:BAKi_DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [BAKit_Current_Calendar dateFromComponents:components];
}

- (NSDateComponents *)ba_dateComponentsWithOffsetFromDate:(NSDate *)aDate
{
    NSDateComponents *dTime = [BAKit_Current_Calendar components:BAKi_DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - 时间间隔
- (NSInteger)ba_dateMinutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / k_MINUTE);
}

- (NSInteger)ba_dateMinutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / k_MINUTE);
}

- (NSInteger)ba_dateHoursAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / k_HOUR);
}

- (NSInteger)ba_dateHoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / k_HOUR);
}

- (NSInteger)ba_dateDaysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / k_DAY);
}

- (NSInteger)ba_dateDaysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / k_DAY);
}

- (NSInteger)ba_dateDistanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}





@end
