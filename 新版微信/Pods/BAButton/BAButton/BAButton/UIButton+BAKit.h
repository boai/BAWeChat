
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
#import "UIView+BARectCorner.h"

NS_ASSUME_NONNULL_BEGIN
/**
 button 的样式，以图片为基准

 - BAKit_ButtonLayoutTypeNormal: button 默认样式：内容居中-图左文右
 - BAKit_ButtonLayoutTypeCenterImageRight: 内容居中-图右文左
 - BAKit_ButtonLayoutTypeCenterImageTop: 内容居中-图上文下
 - BAKit_ButtonLayoutTypeCenterImageBottom: 内容居中-图下文上
 - BAKit_ButtonLayoutTypeLeftImageLeft: 内容居左-图左文右
 - BAKit_ButtonLayoutTypeLeftImageRight: 内容居左-图右文左
 - BAKit_ButtonLayoutTypeRightImageLeft: 内容居右-图左文右
 - BAKit_ButtonLayoutTypeRightImageRight: 内容居右-图右文左
 */
typedef NS_ENUM(NSInteger, BAKit_ButtonLayoutType) {
    BAKit_ButtonLayoutTypeNormal = 0,
    BAKit_ButtonLayoutTypeCenterImageRight,
    BAKit_ButtonLayoutTypeCenterImageTop,
    BAKit_ButtonLayoutTypeCenterImageBottom,
    BAKit_ButtonLayoutTypeLeftImageLeft,
    BAKit_ButtonLayoutTypeLeftImageRight,
    BAKit_ButtonLayoutTypeRightImageLeft,
    BAKit_ButtonLayoutTypeRightImageRight,
};

@interface UIButton (BAKit)

/**
 button 的布局样式，默认为：BAKit_ButtonLayoutTypeNormal，注意：文字、字体大小、图片等设置一定要在设置 ba_button_setBAKit_ButtonLayoutType 之前设置，要不然计算会以默认字体大小计算，导致位置偏移
 */
@property(nonatomic, assign) BAKit_ButtonLayoutType ba_buttonLayoutType;

/*!
 *  文字与图片之间的间距，默认为：0
 */
@property (nonatomic, assign) CGFloat ba_padding;

/*!
 *  文字或图片距离 button 左右边界的最小距离，默认为：5
 */
@property (nonatomic, assign) CGFloat ba_padding_inset;

/**
 快速设置 button 的布局样式 和 间距，注意：文字、字体大小、图片等设置一定要在设置 ba_button_setButtonLayoutType 之前设置，要不然计算会以默认字体大小计算，导致位置偏移

 @param type button 的布局样式
 @param padding 文字与图片之间的间距
 */
- (void)ba_button_setButtonLayoutType:(BAKit_ButtonLayoutType)type
                              padding:(CGFloat)padding;

/**
 快速切圆角，注意：文字、字体大小、图片等设置一定要在设置 ba_button_setButtonLayoutType 之前设置，要不然计算会以默认字体大小计算，导致位置偏移，如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效

 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 */
- (void)ba_button_setViewRectCornerType:(BAKit_ViewRectCornerType)type
                       viewCornerRadius:(CGFloat)viewCornerRadius;

/**
 快速切圆角，带边框、边框颜色，如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 @param borderWidth 边线宽度
 @param borderColor 边线颜色
 */
- (void)ba_button_setViewRectCornerType:(BAKit_ViewRectCornerType)type
                       viewCornerRadius:(CGFloat)viewCornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor;


/**
 *  给定框架创建一个UIButton对象
 */
+ (id)initWithFrame:(CGRect)frame;

/**
 *  给定框架和字符串(字符串字体颜色默认是白色)创建一个UIButton对象
 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title;

/**
 *  给定框架、字符串和背景图片创建一个UIButton对象
 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
    backgroundImage:(UIImage *)backgroundImage;

/**
 *  给定框架、字符串、背景图片和高亮背景图片创建一个UIButton对象
 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
    backgroundImage:(UIImage *)backgroundImage
highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage;

/**
 *  给定框架、字符串、颜色创建一个UIButton对象
 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
              color:(UIColor *)color;

/**
 *  给定框架、字符串、背景颜色和高亮背景颜色创建一个UIButton对象
 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
              color:(UIColor *)color
   highlightedColor:(UIColor *)highlightedColor;

/**
 *  给定框架、颜色创建一个UIButton对象
 */
+ (id)initWithFrame:(CGRect)frame
              color:(UIColor *)color;

/**
 *  给定框架、背景颜色和高亮背景颜色创建一个UIButton对象
 */
+ (id)initWithFrame:(CGRect)frame
              color:(UIColor *)color
   highlightedColor:(UIColor *)highlightedColor;

/**
 *  给定框架和图片创建一个UIButton对象
 */
+ (id)initWithFrame:(CGRect)frame
              image:(UIImage *)image;

/**
 *  给定框架、背景图片和高亮背景图片创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              image:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage;

/**
 *  设置字符字体和大小
 */
- (void)setTitleFont:(NSString *)fontName
                size:(CGFloat)size;

/**
 *  设置字符颜色和高亮颜色
 */
- (void)setTitleColor:(UIColor *)color
     highlightedColor:(UIColor *)highlightedColor;

#pragma mark - 快速创建 button
/**
 创建 button
 
 @param frame frame
 @param title title
 @param selTitle selTitle
 @param titleColor titleColor，默认：黑色
 @param titleFont titleFont默认：15
 @param image image description
 @param selImage selImage
 @param padding padding 文字图片间距
 @param buttonLayoutType buttonLayoutType 文字图片布局样式
 @param viewRectCornerType viewRectCornerType 圆角样式
 @param viewCornerRadius viewCornerRadius 圆角角度
 @param target target
 @param sel sel
 @return button
 */
+ (instancetype __nonnull)ba_creatButtonWithFrame:(CGRect)frame
                                            title:(NSString * __nullable)title
                                         selTitle:(NSString * __nullable)selTitle
                                       titleColor:(UIColor * __nullable)titleColor
                                        titleFont:(UIFont * __nullable)titleFont
                                            image:(UIImage * __nullable)image
                                         selImage:(UIImage * __nullable)selImage
                                          padding:(CGFloat)padding
                              buttonPositionStyle:(BAKit_ButtonLayoutType)buttonLayoutType
                               viewRectCornerType:(BAKit_ViewRectCornerType)viewRectCornerType
                                 viewCornerRadius:(CGFloat)viewCornerRadius
                                           target:(id __nullable)target
                                         selector:(SEL __nullable)sel;

@end

@interface UIImage (BAKit)

+ (UIImage *)imageWithColor:(UIColor *)color;

/*!
 *  根据宽比例去缩放图片，注意：如果button 的图片 太宽，需要调用此方法去等比压缩图片，具体看示例demo
 *
 *  @param width width description
 *
 *  @return return value description
 */
- (UIImage *)ba_imageScaleToWidth:(CGFloat)width;

@end
NS_ASSUME_NONNULL_END


