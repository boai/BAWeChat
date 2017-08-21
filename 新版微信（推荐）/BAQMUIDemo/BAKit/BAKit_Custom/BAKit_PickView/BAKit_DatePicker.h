
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


#import <UIKit/UIKit.h>
#import "BAKit_PickerViewConfig.h"

@interface BAKit_DatePicker : UIView

/**
 日期选择器的最大年限，默认为：2050
 */
@property(assign, nonatomic) NSInteger ba_maxYear;

/**
 日期选择器的最小年限，默认为：1900
 */
@property(assign, nonatomic) NSInteger ba_minYear;

/**
 日期选择器默认选中的日期，默认为：日期选择器弹出时的日期
 */
@property(strong, nonatomic) NSDate *ba_defautDate;

/**
 日期选择器 添加弹出动画，默认为：如果不设置该属性将不会显示动画
 */
@property(assign, nonatomic) BAKit_PickerViewAnimationType animationType;
@property(nonatomic, assign) BAKit_PickerViewButtonPositionType buttonPositionType;
@property(nonatomic, assign) BAKit_PickerViewPositionType pickerViewPositionType;

/*! 是否开启边缘触摸隐藏 默认：YES */
@property (nonatomic, assign) BOOL isTouchEdgeHide;

/**
 toolBar 背景颜色，默认：白色
 */
@property(nonatomic, strong) UIColor *ba_backgroundColor_toolBar;

/**
 pickView 背景颜色，默认：白色
 */
@property(nonatomic, strong) UIColor *ba_backgroundColor_pickView;

/**
 cancleButton title颜色，默认：黑色
 */
@property(nonatomic, strong) UIColor *ba_buttonTitleColor_cancle;

/**
 sureButton title颜色，默认：黑色
 */
@property(nonatomic, strong) UIColor *ba_buttonTitleColor_sure;

/**
 pickView 字体，默认：非选中状态 [UIFont systemFontOfSize:10]，选中状态比非选中状态大5，即 15
 */
@property(nonatomic, strong) UIFont *ba_pickViewFont;

/**
 pickView 字体颜色，默认：[UIColor blackColor]，注意：日期选择器暂时不能修改字体，有可能被苹果审核不通过，如有特殊需求，可通过 runtime 修改
 */
@property(nonatomic, strong) UIColor *ba_pickViewTextColor;


/**
 快速创建 BAKit_DatePicker

 @param pickerViewType pickerViewType
 @param configuration configuration
 @param block block
 */
+ (void)ba_creatPickerViewWithType:(BAKit_CustomDatePickerDateType)pickerViewType
                     configuration:(void (^)(BAKit_DatePicker *tempView))configuration
                             block:(BAKit_PickerViewResultBlock)block;

/**
 显示 pick
 */
- (void)ba_pickViewShow;

/**
 隐藏 pick
 */
- (void)ba_pickViewHidden;

@end

