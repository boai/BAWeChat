
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
 
 */ //  BAKit 自定义封装

#ifndef BAKit_Custom_h
#define BAKit_Custom_h

#pragma mark - 简单工具类 封装
#import "BAKit_Helper.h"

#pragma mark - 动画类 封装
#import "BAKit_Animation.h"

#pragma mark - 按首字母或者汉字拼音首字母分组排序索引工具类
#import "BAKit_ChineseString.h"
#import "BAKit_localizedIndexedCollation.h"

#pragma mark - 正则表达式 封装
#import "BAKit_RegularExpression.h"

#pragma mark - 七彩渐变进度条 类封装
#import "BAGradualProgressView.h"

#pragma mark - 宫格 类封装
#import "BAKit_BAGridView.h"

#pragma mark - Color 类封装
#import "BAKit_Color.h"

#pragma mark - PickerView 类封装
#import "BAPickView_OC.h"

#pragma mark - PhotoKit 简单封装
#import "BAKit_PhotoKitManager.h"

#pragma mark - 清理缓存 类封装
#import "BAKit_ClearCacheManager.h"

/*! model 解析类 */
//#import "BAKit_Model.h"
//#import "BAKit_ModelCodingCopying.h"

#pragma mark - 获取当前定位信息 封装
#import "BAKit_Location.h"

/*! 自定义提示框 */
//#import "BAKit_HudManager.h"
//#import "NSObject+BAProgressHUD.h"
//#import "MBProgressHUD+ADD.h"

#pragma mark - GCD 封装
#import "GCD.h"

#import "BAKit_KeyboardView.h"
#import "BAKit_EmotionTextAttachment.h"
#import "BAKit_EmotionString.h"

#endif /* BAKit_Custom_h */
