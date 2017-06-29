
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

@interface UITextField (BAHistory)

/**
 textFieldID：识别 ID，要用到历史记录，请务必添加
 */
@property(nonatomic, strong) NSString *ba_textFieldID;

/**
 历史数据数组
 */
@property(nonatomic, readonly, strong) NSArray *ba_textFieldHistoryArray;

/**
 clearButton 标题，默认：清楚历史内容
 */
@property(nonatomic, strong) NSString *ba_clearButtonTitle;

/**
 clearButton 标题颜色，默认：[[UIColor blueColor] colorWithAlphaComponent:0.5f]
 */
@property(nonatomic, strong) UIColor *ba_clearButtonTitleColor;


/**
 同步输入内容到 NSUserDefaults
 */
- (void)ba_textFieldHistoryArraySynchronize;

/**
 显示 HistoryArray
 */
- (void)ba_textFieldHistoryArrayShow;

/**
 隐藏 HistoryArray
 */
- (void)ba_textFieldHistoryArrayHide;

/**
 清除 HistoryArray
 */
- (void)ba_textFieldHistoryArrayClear;

@end
