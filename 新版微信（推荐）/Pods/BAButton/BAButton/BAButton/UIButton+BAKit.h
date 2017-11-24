
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

/**
 UIButton：点击事件 block 返回

 @param button 当前的 button
 */
typedef void (^BAKit_UIButtonActionBlock)(UIButton * _Nonnull button);

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
 UIButton：点击事件 block 返回
 */
@property(nonatomic, copy) BAKit_UIButtonActionBlock ba_buttonActionBlock;

#pragma mark - 快速创建 button

/**
 UIButton：快速创建 button1：frame、title、titleColor、titleFont
 
 @param frame frame
 @param title title
 @param titleColor titleColor
 @param titleFont titleFont
 @return button
 */
+ (id)ba_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
              titleColor:(UIColor * __nullable)titleColor
               titleFont:(UIFont * __nullable)titleFont;

/**
 UIButton：快速创建 button2：frame、title、backgroundColor
 
 @param frame frame
 @param title title
 @param backgroundColor backgroundColor
 @return button
 */
+ (id)ba_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
         backgroundColor:(UIColor * __nullable)backgroundColor;

/**
 UIButton：快速创建 button3：frame、title、titleColor、titleFont、backgroundColor
 
 @param frame frame
 @param title title
 @param titleColor titleColor
 @param titleFont titleFont
 @param backgroundColor backgroundColor
 @return button
 */
+ (id)ba_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
              titleColor:(UIColor * __nullable)titleColor
               titleFont:(UIFont * __nullable)titleFont
         backgroundColor:(UIColor * __nullable)backgroundColor;

/**
 UIButton：快速创建 button4：frame、title、backgroundImage
 
 @param frame frame
 @param title title
 @param backgroundImage backgroundImage
 @return button
 */
+ (id)ba_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
         backgroundImage:(UIImage * __nullable)backgroundImage;

/**
 UIButton：快速创建 button5：frame、title、titleColor、titleFont、image、backgroundColor
 
 @param frame frame description
 @param title title description
 @param titleColor titleColor description
 @param titleFont titleFont description
 @param image image description
 @param backgroundColor backgroundColor description
 @return button
 */
+ (instancetype)ba_buttonWithFrame:(CGRect)frame
                             title:(NSString * __nullable)title
                        titleColor:(UIColor * __nullable)titleColor
                         titleFont:(UIFont * __nullable)titleFont
                             image:(UIImage * __nullable)image
                   backgroundColor:(UIColor * __nullable)backgroundColor;

/**
 UIButton：快速创建 button6：frame、title、titleColor、titleFont、image、backgroundImage
 
 @param frame frame description
 @param title title description
 @param titleColor titleColor description
 @param titleFont titleFont description
 @param image image description
 @param backgroundImage backgroundImage description
 @return button
 */
+ (instancetype)ba_buttonWithFrame:(CGRect)frame
                             title:(NSString * __nullable)title
                        titleColor:(UIColor * __nullable)titleColor
                         titleFont:(UIFont * __nullable)titleFont
                             image:(UIImage * __nullable)image
                   backgroundImage:(UIImage * __nullable)backgroundImage;

/**
 UIButton：快速创建 button7：大汇总-点击事件、圆角
 
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

/**
 UIButton：快速创建 button8：大汇总-所有 normal、selected、highlighted 样式都有
 
 @param frame frame
 @param title title description
 @param selectedTitle selectedTitle description
 @param highlightedTitle highlightedTitle description
 @param titleColor titleColor description
 @param selectedTitleColor selectedTitleColor description
 @param highlightedTitleColor highlightedTitleColor description
 @param titleFont titleFont description
 @param image image description
 @param selectedImage selectedImage description
 @param highlightedImage highlightedImage description
 @param backgroundImage backgroundImage description
 @param selectedBackgroundImage selectedBackgroundImage description
 @param highlightedBackgroundImage highlightedBackgroundImage description
 @param backgroundColor backgroundColor description
 @return button
 */
+ (instancetype)ba_buttonWithFrame:(CGRect)frame
                             title:(NSString * __nullable)title
                     selectedTitle:(NSString * __nullable)selectedTitle
                  highlightedTitle:(NSString * __nullable)highlightedTitle
                        titleColor:(UIColor * __nullable)titleColor
                selectedTitleColor:(UIColor * __nullable)selectedTitleColor
             highlightedTitleColor:(UIColor * __nullable)highlightedTitleColor
                         titleFont:(UIFont * __nullable)titleFont
                             image:(UIImage * __nullable)image
                     selectedImage:(UIImage * __nullable)selectedImage
                  highlightedImage:(UIImage * __nullable)highlightedImage
                   backgroundImage:(UIImage * __nullable)backgroundImage
           selectedBackgroundImage:(UIImage * __nullable)selectedBackgroundImage
        highlightedBackgroundImage:(UIImage * __nullable)highlightedBackgroundImage
                   backgroundColor:(UIColor * __nullable)backgroundColor;

/**
 UIButton：快速创建一个纯文字 button
 
 @param frame frame description
 @param title title description
 @param font font description
 @param horizontalAlignment horizontalAlignment description
 @param verticalAlignment verticalAlignment description
 @param contentEdgeInsets contentEdgeInsets description
 @param target target description
 @param action action description
 @param normalStateColor normalStateColor description
 @param highlightedStateColor highlightedStateColor description
 @param disabledStateColor disabledStateColor description
 @return UIButton
 */
+ (UIButton *)ba_buttonLabelButtonWithFrame:(CGRect)frame
                                      title:(NSString *)title
                                       font:(UIFont *)font
                        horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                          verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                          contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                                     target:(id)target
                                     action:(SEL)action
                           normalTitleColor:(UIColor *)normalStateColor
                      highlightedTitleColor:(UIColor *)highlightedStateColor
                         disabledTitleColor:(UIColor *)disabledStateColor;

/**
 UIButton：快速创建一个纯图片 button
 
 @param frame frame description
 @param horizontalAlignment horizontalAlignment description
 @param verticalAlignment verticalAlignment description
 @param contentEdgeInsets contentEdgeInsets description
 @param normalImage normalImage description
 @param highlightImage highlightImage description
 @param disabledImage disabledImage description
 @param target target description
 @param action action description
 @return UIButton
 */
+ (UIButton *)ba_buttonImageButtonWithFrame:(CGRect)frame
                        horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                          verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                          contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                                normalImage:(UIImage *)normalImage
                             highlightImage:(UIImage *)highlightImage
                              disabledImage:(UIImage *)disabledImage
                                     target:(id)target
                                     action:(SEL)action;

#pragma mark - 自定义：button 颜色
/**
 UIButton：自定义 button backgroundColor
 
 @param backgroundColor backgroundColor
 */
- (void)ba_buttonSetBackgroundColor:(UIColor * __nullable)backgroundColor;

/**
 UIButton：backgroundColor、normalStateColor、highlightedStateColor、disabledStateColor
 
 @param normalStateColor normalStateColor description
 @param highlightedStateColor highlightedStateColor description
 @param disabledStateColor disabledStateColor description
 */
- (void)ba_buttonBackgroundColorWithNormalStateColor:(UIColor *)normalStateColor
                               highlightedStateColor:(UIColor *)highlightedStateColor
                                  disabledStateColor:(UIColor *)disabledStateColor;

#pragma mark - 自定义 button backgroundImage
/**
 UIButton：自定义 button backgroundImage、selectedBackgroundImage、highlightedBackgroundImage
 
 @param backgroundImage backgroundImage
 @param selectedBackgroundImage selectedBackgroundImage
 @param highlightedBackgroundImage highlightedBackgroundImage
 */
- (void)ba_buttonSetBackgroundImage:(UIImage * __nullable)backgroundImage
            selectedBackgroundImage:(UIImage * __nullable)selectedBackgroundImage
         highlightedBackgroundImage:(UIImage * __nullable)highlightedBackgroundImage;

#pragma mark - 自定义 button image
/**
 UIButton：自定义 button image、selectedImage、highlightedImage、disabledImage
 
 @param image image
 @param selectedImage selectedImage
 @param highlightedImage highlightedImage
 @param disabledImage disabledImage
 */
- (void)ba_buttonSetImage:(UIImage * __nullable)image
            selectedImage:(UIImage * __nullable)selectedImage
         highlightedImage:(UIImage * __nullable)highlightedImage
            disabledImage:(UIImage * __nullable)disabledImage;

#pragma mark - 自定义 button title
/**
 UIButton：自定义 button title、selectedTitle、highlightedTitle
 
 @param title title
 @param selectedTitle selectedTitle
 @param highlightedTitle highlightedTitle
 */
- (void)ba_buttonSetTitle:(NSString * __nullable)title
            selectedTitle:(NSString * __nullable)selectedTitle
         highlightedTitle:(NSString * __nullable)highlightedTitle;

/**
 UIButton：自定义 button titleColor、selectedTitleColor、highlightedTitleColor、disabledTitleColor
 
 @param titleColor titleColor
 @param selectedTitleColor selectedTitleColor
 @param highlightedTitleColor highlightedTitleColor
 @param disabledTitleColor disabledTitleColor
 */
- (void)ba_buttonSetTitleColor:(UIColor * __nullable)titleColor
            selectedTitleColor:(UIColor * __nullable)selectedTitleColor
         highlightedTitleColor:(UIColor * __nullable)highlightedTitleColor
            disabledTitleColor:(UIColor * __nullable)disabledTitleColor;

/**
 UIButton：自定义 button 字体、大小
 
 @param fontName fontName
 @param size size
 */
- (void)ba_buttonSetTitleFontName:(NSString *)fontName
                             size:(CGFloat)size;

#pragma mark - 点击事件
/**
 UIButton：自定义 button 点击事件，默认：UIControlEventTouchUpInside
 
 @param target target
 @param tag tag
 @param action action
 */
- (void)ba_buttonAddTarget:(nullable id)target
                       tag:(NSInteger)tag
                    action:(SEL)action;

#pragma mark - 布局样式 和 间距
/**
 UIButton：快速设置 button 的布局样式 和 间距
 
 @param type button 的布局样式
 @param padding 文字与图片之间的间距
 */
- (void)ba_button_setButtonLayoutType:(BAKit_ButtonLayoutType)type padding:(CGFloat)padding;

#pragma mark - 快速切圆角
/**
 UIButton：快速切圆角，注意：文字、字体大小、图片等设置一定要在设置 ba_button_setButtonLayoutType 之前设置，要不然计算会以默认字体大小计算，导致位置偏移，如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 */
- (void)ba_button_setViewRectCornerType:(BAKit_ViewRectCornerType)type viewCornerRadius:(CGFloat)viewCornerRadius;

/**
 UIButton：快速切圆角，带边框、边框颜色，如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 @param borderWidth 边线宽度
 @param borderColor 边线颜色
 */
- (void)ba_button_setViewRectCornerType:(BAKit_ViewRectCornerType)type
                       viewCornerRadius:(CGFloat)viewCornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor;

#pragma mark - title 位置
/**
 UIButton：title 位置
 
 @param horizontalAlignment horizontalAlignment description
 @param verticalAlignment verticalAlignment description
 @param contentEdgeInsets contentEdgeInsets description
 */
- (void)ba_buttonTitleLabelHorizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                             verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                             contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets;

#pragma mark - 给 View 添加点击音效
/**
 UIButton：给 button 添加点击音效（一般用于 button 按钮的点击音效），注意，此方法不带播放结束回调，如果需要播放结束回调，请将 .m 文件中的 C 函数（soundCompleteCallBack）回调复制到播放按钮的.m 里，在里面做相关处理即可
 
 @param filename 音乐文件名称
 @param isNeedShock 是否播放音效并震动
 */
- (void)ba_buttonPlaySoundEffectWithFileName:(NSString *)filename
                                 isNeedShock:(BOOL)isNeedShock;

@end

@interface UIImage (BAButton)

/**
 UIImage：创建一个 纯颜色 图片【全部铺满】
 
 @param color color
 @return 纯颜色 图片
 */
+ (UIImage *)ba_image_Color:(UIColor *)color;

/**
 UIImage：创建一个 纯颜色 图片【可以设置 size】
 
 @param color color
 @param size size
 @return 纯颜色 图片
 */
+ (UIImage *)ba_image_Color:(UIColor *)color size:(CGSize)size;

/**
 UIImage：根据宽比例去缩放图片
 
 @param width width description
 @return UIImage
 */
- (UIImage *)ba_imageScaleToWidth:(CGFloat)width;

@end


NS_ASSUME_NONNULL_END


