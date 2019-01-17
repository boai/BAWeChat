
/*!
 *  @header BAKit.h
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright  Copyright © 2016年 博爱. All rights reserved.
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
 * 在使用 BAKit 的过程中如果出现 bug 请及时以以下任意一种方式联系我，我会及时修复 bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * BAHome : https://github.com/BAHome
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#ifndef BAKit_PickerViewConfig_h
#define BAKit_PickerViewConfig_h


/**
 选择器样式，默认为：BAKit_PickerViewTypeCity
 
 - BAKit_PickerViewTypeCity: 城市选择器
 - BAKit_PickerViewTypeArray: 普通数组自定义数据
 - BAKit_PickerViewTypeDate: 日期选择器：年月日，可以完全自定义 NSDateFormatter
 - BAKit_PickerViewTypeDateYM: 日期选择器：年月，可以完全自定义 NSDateFormatter
 - BAKit_PickerViewTypeDateWeek: 日期选择器：年周，如：2017年，第21周
 
 */
typedef NS_ENUM(NSUInteger, BAKit_PickerViewType) {
    BAKit_PickerViewTypeCity = 0,
    BAKit_PickerViewTypeArray,
    BAKit_PickerViewTypeDate,
    BAKit_PickerViewTypeDateYM,
    BAKit_PickerViewTypeDateWeek
};

/**
 日期选择器样式下返回的数据格式，默认为：BAKit_PickerViewDateTypeYMD
 
 - BAKit_PickerViewDateTypeYY: 如：2017
 - BAKit_PickerViewDateTypeYM: 如：2017-03
 - BAKit_PickerViewDateTypeYMD: 如：20172017-03-01
 - BAKit_PickerViewDateTypeYMDHMS: 如：2017-03-01 18:20:12
 - BAKit_PickerViewDateTypeYMDEHMS: 如：2017-03-01，周二, 18:20:12
 - BAKit_PickerViewDateTypeHM: 如：18:20
 - BAKit_PickerViewDateTypeHMS: 如：18:20:12
 */
typedef NS_ENUM(NSUInteger, BAKit_PickerViewDateType) {
    BAKit_PickerViewDateTypeYY = 0,
    BAKit_PickerViewDateTypeYM,
    BAKit_PickerViewDateTypeYMD,
    BAKit_PickerViewDateTypeYMDHMS,
    BAKit_PickerViewDateTypeYMDEHMS,
    BAKit_PickerViewDateTypeHM,
    BAKit_PickerViewDateTypeHMS
};

/**
 设置日期选择器的样式，具体的显示顺序取决于设备的本地化设置。默认为：BAKit_PickerViewDateModeDate
 
 - BAKit_PickerViewDateModeTime: 显示时、分、AM／PM标志(可选)
 - BAKit_PickerViewDateModeDate: 显示年、月、日
 - BAKit_PickerViewDateModeDateAndTime: 显示日期的月、日、星期，时间的时、分、AM／PM标志(可选)
 - BAKit_PickerViewDateModeCountDownTimer: 显示时、分。应用程序必须实现一个计数器（NSTimer对象），让倒计时中的时间不断减少。
 */
typedef NS_ENUM(NSInteger, BAKit_PickerViewDateMode) {
    BAKit_PickerViewDateModeTime,
    /*! 选择此样式后，dateType 默认为：BAKit_PickerViewDateTypeYMD */
    BAKit_PickerViewDateModeDate,
    /*! 选择此样式后，dateType 默认为：ba_setupDateFormatterWithYMDEHMS */
    BAKit_PickerViewDateModeDateAndTime,
    BAKit_PickerViewDateModeCountDownTimer
};

typedef NS_ENUM(NSUInteger, BAKit_PickerViewAnimationType) {
    BAKit_PickerViewAnimationTypeScale = 0,
    BAKit_PickerViewAnimationTypeTop,
    BAKit_PickerViewAnimationTypeBottom,
    BAKit_PickerViewAnimationTypeLeft,
    BAKit_PickerViewAnimationTypeRight
};

/**
 设置取消和确定按钮相对pickerView的位置
 
 - BAKit_PickerViewPositionTypeNormal: 默认PickerView在屏幕的底部
 - BAKit_PickerViewPositionTypeBottom: 设置pickerView在屏幕的中心
 
 */
typedef NS_ENUM(NSUInteger, BAKit_PickerViewPositionType) {
    BAKit_PickerViewPositionTypeNormal = 0,
    BAKit_PickerViewPositionTypeCenter,
};

/**
 设置取消和确定按钮相对pickerView的位置
 
 - BAKit_PickerViewButtonPositionTypeNormal: 默认“取消”和“确定”button在pickerView的顶部
 - BAKit_PickerViewButtonPositionTypeBottom: 设置“取消”和“确定”button在pickerView的底部
 
 */
typedef NS_ENUM(NSUInteger, BAKit_PickerViewButtonPositionType) {
    BAKit_PickerViewButtonPositionTypeNormal = 0,
    BAKit_PickerViewButtonPositionTypeBottom,
};

#pragma mark - datePicker
/**
 日期选择器样式下返回的数据格式，默认为：BAKit_CustomDatePickerDateType
 
 - BAKit_CustomDatePickerDateTypeYY: 如：2017
 - BAKit_CustomDatePickerDateTypeYM: 如：2017-03
 - BAKit_CustomDatePickerDateTypeYMD: 如：20172017-03-01
 - BAKit_CustomDatePickerDateTypeYMDHMS: 如：2017-03-01 18:20:12
 - BAKit_CustomDatePickerDateTypeYMDHM: 如：2017-03-01 18:20
 - BAKit_CustomDatePickerDateTypeMD: 如：03-06
 - BAKit_CustomDatePickerDateTypeHM: 如：18:20
 - BAKit_CustomDatePickerDateTypeHMS: 如：18:20:12
 */

typedef NS_ENUM(NSUInteger, BAKit_CustomDatePickerDateType) {
    BAKit_CustomDatePickerDateTypeYY = 0,
    BAKit_CustomDatePickerDateTypeYM,
    BAKit_CustomDatePickerDateTypeYMD,
    BAKit_CustomDatePickerDateTypeYMDHM,
    BAKit_CustomDatePickerDateTypeYMDHMS,
    BAKit_CustomDatePickerDateTypeMD,
    BAKit_CustomDatePickerDateTypeHM,
    BAKit_CustomDatePickerDateTypeHMS,
    
};

typedef void (^BAKit_PickerViewResultBlock)(NSString *resultString);

#endif /* BAKit_PickerViewConfig_h */
