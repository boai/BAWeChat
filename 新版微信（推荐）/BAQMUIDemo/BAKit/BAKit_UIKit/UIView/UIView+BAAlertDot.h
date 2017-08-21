
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
#import "UIView+BAKit.h"

@interface UIView (BAAlertDot)

@property (nonatomic, readonly) BOOL ba_isShowingAlertDot;

#pragma mark -- 扩展方法

/** 设置提示小圆点的颜色 */
@property (nonatomic, strong) UIColor *ba_alertDot_color;

/** 设置提示小圆点显示的文字 */
@property (nonatomic, strong) NSString *ba_alertDot_text;

/** 设置提示小圆点显示的文字的颜色 */
@property (nonatomic, strong) UIColor *ba_alertDot_textColor;

/** 当文字较多时 maxHeight 限制小圆点高度从而呈现椭圆式形状 */
@property (nonatomic, assign) CGFloat ba_alertDot_maxHeight;

#pragma mark -- 基本方法

/** 添加一个提示小圆点到调用此方法的view上（默认在父view右上方显示，距离父view上0右0，可以传递float类型的参数topOffset、rightOffset调整小圆点位置） */
- (void)ba_alertDot_showWithDotSize:(CGSize)size
                          topOffset:(CGFloat)topOffset
                        rightOffset:(CGFloat)rightOffset;

/** 添加一个提示小圆点到调用此方法的view上（默认在父view右上方显示，距离父view上0右0，可以传递float类型的参数topOffset、rightOffset调整小圆点位置） */
- (void)ba_alertDot_showWithText:(NSString *)text
                    textFontSize:(CGFloat)fontSize
                       topOffset:(CGFloat)topOffset
                     rightOffset:(CGFloat)rightOffset;

/** 删除view上的提示小圆点 */
- (void)ba_alertDot_hide;

/** 返回提示小圆点（UIButton类型） */
- (UIButton *)ba_alertDot_button;

@end


