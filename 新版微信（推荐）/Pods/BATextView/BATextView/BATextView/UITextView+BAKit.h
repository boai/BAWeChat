
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


#import <UIKit/UIKit.h>

/*! 过期属性或方法名提醒 */
#define BAKit_TextView_Deprecated(instead) __deprecated_msg(instead)


/**
 实时监测 TextView 输入文字，并返回当前文字最大高度，以便做自适应高度

 @param current_textViewHeight 当前文字的最大高度
 */
typedef void (^BAKit_TextView_HeightDidChangedBlock)(CGFloat current_textViewHeight);

/**
 实时监测 TextView 输入文字，并返回当前文字字符

 @param current_text 当前文字的字符
 */
typedef void (^BAKit_TextView_WordDidChangedBlock)(NSString *current_text);

/**
 实时监测 TextView 输入文字，来自系统代理：shouldChangeTextInRange

 @param textView textView description
 @param range range description
 @param replacementText replacementText description
 */
typedef void (^BAKit_TextView_ShouldChangeTextInRangeBlock)(UITextView *textView, NSRange range, NSString *replacementText);


@interface UITextView (BAKit)<UITextViewDelegate>

/**
 TextView 默认 text，注意：一定要用 ba_text 设置，用系统的 self.text 设置无效，此外，如果有默认 text，一定要在 ba_placeholder 赋值之前赋值 ba_text，要不然会出现文字颜色错乱！
 */
@property(nonatomic, strong) NSString *ba_text;

/**
 placeholder：placeholder文字
 */
@property(nonatomic, strong) NSString *ba_placeholder;

/**
 placeholder：文字颜色
 */
@property(nonatomic, strong) UIColor *ba_placeholderColor;

/**
 placeholder：文字字体
 */
@property(nonatomic, strong) UIFont *ba_placeholderFont;

/**
 文字字体，注意：一定要用 ba_textFont 设置，用系统的 self.font 设置无效
 */
@property(nonatomic, strong) UIFont *ba_textFont;

/**
 文字颜色，注意：一定要用 ba_textColor 设置，用系统的 self.textColor 设置无效
 */
@property(nonatomic, strong) UIColor *ba_textColor;

/**
 最大高度，如果需要随文字改变高度的时候使用
 */
@property (nonatomic, assign) CGFloat ba_maxHeight;

/**
 最小高度，如果需要随文字改变高度的时候使用
 */
@property (nonatomic, assign) CGFloat ba_minHeight;

/**
 实时监测 TextView 输入文字，并返回当前文字，以便做自适应高度
 */
@property(nonatomic, copy) BAKit_TextView_HeightDidChangedBlock ba_textView_HeightDidChangedBlock;

/**
 最大字数限制
 */
@property (nonatomic, assign) NSInteger ba_maxWordLimitNumber;

/**
 实时监测 TextView 输入文字，并返回当前文字
 */
@property(nonatomic, copy) BAKit_TextView_WordDidChangedBlock ba_textView_WordDidChangedBlock; BAKit_TextView_Deprecated("该方法已过期,请使用最新方法：typedef void (^BAKit_TextView_WordDidChangedBlock)(NSString *current_text)");

/**
 实时监测 TextView 输入文字，来自系统代理：shouldChangeTextInRange
 */
@property(nonatomic, copy) BAKit_TextView_ShouldChangeTextInRangeBlock ba_textView_ShouldChangeTextInRangeBlock;

#pragma mark - public method
/**
 设置代理监测，如果需要监测自动高度，请务必添加这个代理，具体使用请看 demo！

 @param delegate UITextViewDelegate
 */
- (void)ba_textViewWithDelegate:(id <UITextViewDelegate>)delegate;

/**
 是否为空

 @return YES，NO
 */
- (BOOL)ba_textView_isEmpty;

/**
 快速设定自动布局

 @param maxHeight 最大高度
 @param minHeight 最小高度
 @param block BAKit_TextView_HeightDidChangedBlock
 */
- (void)ba_textView_autoLayoutWithMaxHeight:(CGFloat)maxHeight
                                  minHeight:(CGFloat)minHeight
                                      block:(BAKit_TextView_HeightDidChangedBlock)block;

/**
 快速设定最大字数限制返回当前字数

 @param limitNumber 最大字数限制
 @param block BAKit_TextView_WordDidChangedBlock
 */
- (void)ba_textView_wordLimitWithMaxWordLimitNumber:(NSInteger)limitNumber
                                              block:(BAKit_TextView_WordDidChangedBlock)block;

#pragma mark - 各版本过期方法名
#pragma mark version 1.0.2 过期方法名

@end
