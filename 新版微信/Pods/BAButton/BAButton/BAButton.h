
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
 
 */     // UIButton 类封装

#import <UIKit/UIKit.h>




/*! 过期属性或方法名提醒 */
#define BAButtonDeprecated(instead) __deprecated_msg(instead)

/*!
 *  设置 buttonPosition 样式
 *  注意：【xib 、storyboard、纯代码均适配】xib 、storyboard 只需在 - (void)awakeFromNib{} 内部设置 buttonPositionStyle 即可，其他代码均可通过 xib、storyboard 设置，
 例如：
 - (void)awakeFromNib
 {
    button.buttonPositionStyle = BAButtonPositionStyleLeft;
 }
 */
typedef NS_ENUM(NSInteger, BAButtonPositionStyle) {
    /*!
     *  系统默认
     */
    BAButtonPositionStyleNormal = 0,
    /*!
     *  左对齐
     */
    BAButtonPositionStyleLeft,
    /*!
     *  居中对齐
     */
    BAButtonPositionStyleCenter,
    /*!
     *  右对齐
     */
    BAButtonPositionStyleRight,
    /*!
     *  图标在上，文本在下(居中)
     */
    BAButtonPositionStyleTop,
    /*!
     *  图标在下，文本在上(居中)
     */
    BAButtonPositionStyleBottom
};

/*!
 *  设置 buttonRectCorner 样式，
 *  注意：buttonRectCornerStyle 必须要先设置 buttonCornerRadii，才能有效，否则 button 不显示，
 *  举个🌰：
 btn.buttonCornerRadii = CGSizeMake(10, 10);
 btn.buttonRectCornerStyle = BAButtonRectCornerStyleBottomRightAndTopRightAndBottomLeft;
 或者直接使用：
 [btn setButtonCornerRadii:CGSizeMake(10, 10) buttonRectCornerStyle:BAButtonRectCornerStyleTopLeft];
 */
typedef NS_ENUM(NSInteger, BAButtonRectCornerStyle) {
    /*!
     *  设置下左角 圆角半径
     */
    BAButtonRectCornerStyleBottomLeft = 0,
    /*!
     *  设置下右角 圆角半径
     */
    BAButtonRectCornerStyleBottomRight,
    /*!
     *  设置上左角 圆角半径
     */
    BAButtonRectCornerStyleTopLeft,
    /*!
     *  设置下右角 圆角半径
     */
    BAButtonRectCornerStyleTopRight,
    /*!
     *  设置下左、下右角 圆角半径
     */
    BAButtonRectCornerStyleBottomLeftAndBottomRight,
    /*!
     *  设置上左、上右角 圆角半径
     */
    BAButtonRectCornerStyleTopLeftAndTopRight,
    /*!
     *  设置下左、上左角 圆角半径
     */
    BAButtonRectCornerStyleBottomLeftAndTopLeft,
    /*!
     *  设置下右、上右角 圆角半径
     */
    BAButtonRectCornerStyleBottomRightAndTopRight,
    /*!
     *  设置上左、上右、下右角 圆角半径
     */
    BAButtonRectCornerStyleBottomRightAndTopRightAndTopLeft,
    /*!
     *  设置下右、上右、下左角 圆角半径
     */
    BAButtonRectCornerStyleBottomRightAndTopRightAndBottomLeft,
    /*!
     *  设置全部四个角 圆角半径
     */
    BAButtonRectCornerStyleAllCorners
};

@interface BAButton : UIButton


/*!
 *  设置 buttonPosition 样式
 */
@property (nonatomic, assign) BAButtonPositionStyle buttonPositionStyle;

/*!
 *  设置 buttonRectCorner 样式，
 *  注意：buttonRectCornerStyle 必须要先设置 buttonCornerRadii，才能有效，否则 button 不显示，
 *  举个🌰：
     btn.buttonCornerRadii = CGSizeMake(10, 10);
     btn.buttonRectCornerStyle = BAButtonRectCornerStyleBottomRightAndTopRightAndBottomLeft;
    或者直接使用：
 [btn setButtonCornerRadii:CGSizeMake(10, 10) buttonRectCornerStyle:BAButtonRectCornerStyleTopLeft];
 */
@property (nonatomic, assign) BAButtonRectCornerStyle buttonRectCornerStyle;

/*!
 *  button 的 角半径，默认 CGSizeMake(20, 20)
 */
@property (nonatomic, assign) CGSize buttonCornerRadii;

/*!
 *  设置 button 圆角，如果要全部设置四个角的圆角，可以直接用这个方法，必须要在设置 frame 之后
 */
@property (nonatomic, assign) CGFloat buttonCornerRadius;

/*!
 *  文字与图片之间的间距，默认为：0
 */
@property (nonatomic, assign) CGFloat padding;

#pragma mark - set 方法
- (void)setButtonPositionStyle:(BAButtonPositionStyle)buttonPositionStyle;
- (void)setButtonCornerRadii:(CGSize)buttonCornerRadii buttonRectCornerStyle:(BAButtonRectCornerStyle)buttonRectCornerStyle;
- (void)setButtonCornerRadius:(CGFloat)buttonCornerRadius;

#pragma mark - 初始化方法
NS_ASSUME_NONNULL_BEGIN
- (instancetype __nonnull)init;
- (instancetype __nonnull)initWithFrame:(CGRect)frame;
- (instancetype __nonnull)initWithCoder:(NSCoder * __nonnull)aDecoder;
NS_ASSUME_NONNULL_END

#pragma mark - 快速创建 button
/*!
 *  创建 button
 *
 *  @param frame               frame
 *  @param title               title
 *  @param selTitle            selTitle
 *  @param titleColor          标题颜色，默认：黑色
 *  @param titleFont           标题字体，默认：16
 *  @param image               image
 *  @param selImage            selImage
 *  @param buttonPositionStyle buttonPositionStyle
 *  @param target              target
 *  @param sel                 sel
 *
 *  @return button
 */
- (instancetype __nonnull)creatButtonWithFrame:(CGRect)frame
                               title:(NSString * __nullable)title
                            selTitle:(NSString * __nullable)selTitle
                          titleColor:(UIColor * __nullable)titleColor
                           titleFont:(UIFont * __nullable)titleFont
                               image:(UIImage * __nullable)image
                            selImage:(UIImage * __nullable)selImage
                 buttonPositionStyle:(BAButtonPositionStyle)buttonPositionStyle
                              target:(id __nullable)target
                            selector:(SEL __nullable)sel;


#pragma mark - 过期方法
@property (nonatomic, assign) BAButtonPositionStyle buttonStatus BAButtonDeprecated("方法已过期，请使用最新属性名：buttonPositionStyle");
+ (instancetype _Nonnull)BA_ShareButton BAButtonDeprecated("方法已过期，请使用最新方法名：BAButton *btn1 = [[BAButton alloc] init]");
- (instancetype _Nonnull)initWitButtonStatus:(BAButtonPositionStyle)status BAButtonDeprecated("方法已过期，请使用最新方法名：BAButton *btn1 = [[BAButton alloc] init]");

@end


/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAButton ！BAButton特点如下：
 
 最新更新时间：2017-03-02 【倒叙】
 最新Version：【Version：2.2.0】
 更新内容：
 2.2.1、修复 buttonCornerRadii 只能在添加frame 后设置才能有效的问题，现在可以随意设置
 2.2.2、新增设置文字或和图片间距，举个🌰：self.padding = 10;

 
 最新更新时间：2017-02-28 【倒叙】
 最新Version：【Version：2.1.0】
 更新内容：
 2.1.1、继承自 UIButton 可以像 UIButton 一样随便添加系统属性
 2.1.2、可以单独设置文字和图片的位置
 2.1.3、还可以设置文字或者图片间距
 2.1.4、可以设置按钮的任意一个角的圆角度数
 2.1.4、全面适配纯代码、xib、storyboard
 
 最新更新时间：2016-11-24 【倒叙】
 最新Version：【Version：2.0.1】
 更新内容：
 2.0.1、优化方法名命名规范
 2.0.2、删除多余代码，简化方法名和属性名，详见 demo
 2.0.3、新增旧方法更新提示
 2.0.4、优化各种注释
 
 */
