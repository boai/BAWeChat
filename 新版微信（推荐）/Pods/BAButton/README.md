# BAButton
[![BAHome Team Name](https://img.shields.io/badge/Team-BAHome-brightgreen.svg?style=flat)](https://github.com/BAHome "BAHome Team")
![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/cocoapods/v/BAButton.svg?style=flat) ![](https://img.shields.io/cocoapods/dt/BAButton.svg
)  [![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123)

## 1、功能及简介
* 1、UIButton 图片、文字自定义布局 <br>
* 2、UIButton 自定义切圆角，可以设置任意一个角的角半径
* 3、用 UIButton 的分类处理，处理更简单，一行代码轻松搞定所有 UIButton 自定义
* 4、新增 UIButton 各种状态下背景颜色、字体、border、font、动画等的监测及改变
* 5、新增 UIButton 倒计时的封装，两行代码搞定倒计时！
* 6、注意：文字、字体大小、图片等设置一定要在设置 ba_button_setBAButtonLayoutType 之前设置，要不然计算会以默认字体大小计算，导致位置偏移
* 7、优化命名规范，更换了全局统一属性命名和方法命名，如果更新有报错的地方，大家别急，看 .h 文件更换过来即可，后期推出的 BAKit 系列产品，命名都将统一规范，在此给大家带来的不便之处，向大家道歉！希望大家谅解！多谢体谅！
* 8、新增 view 的 border 的创建，可以自定义圆角、边框、边框颜色等(感谢群里 @北京-大腿 同学提出的 需求！)
* 9、修复 xib 下圆角右边无效的bug，注意：如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效(感谢群里 @北京-小黑 同学提出的 bug！)
* 10、新增 大图片 button 的 layout 布局，如果你的图片宽高大于 自身的宽高，则需要压缩后再配置布局，具体看 demo
* 11、重构 <UIButton+BAKit.h>类，新增多种快速创建 button 的方法
* 12、新增 两种快速创建 button 的方法：1、快速创建纯文字 button，2、快速创建纯图片 button <br>
* 13、新增 单独配置文字位置的封装 <br>
* 14、新增 字体颜色、背景颜色、image 等的 disabled 状态下的配置 <br>
* 15、新增 按钮点击音效和震动效果封装
* 16、新增 倒计时按钮纯图片更换，详情请看 倒计时 demo <br>
* 17、新增 连续点击按钮时停止播放上一音乐 <br>
* 18、新增 button 点击事件 blcok，具体使用详见 demo！ <br>
* 19、新增 button 不同状态下的阴影设置，具体使用详见 demo！ <br>

## 2、图片示例
![BAButton1](https://github.com/BAHome/BAButton/blob/master/Images/BAButton1.png)
![BAButton2](https://github.com/BAHome/BAButton/blob/master/Images/BAButton2.png)
![BAButton3](https://github.com/BAHome/BAButton/blob/master/Images/BAButton3.png)

## 3、安装、导入示例和源码地址
* 1、pod 导入【最新版本：![](https://img.shields.io/cocoapods/v/BAButton.svg?style=flat)】： <br>
 `pod 'BAButton'` <br>
如果发现 `pod search BAButton` 搜索出来的不是最新版本，需要在终端执行 cd 转换文件路径命令退回到 desktop，然后执行 `pod setup` 命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了。<br>
具体步骤：
  - pod setup : 初始化
  - pod repo update : 更新仓库
  - pod search BAButton
* 2、文件夹拖入：下载demo，把 BAButton 文件夹拖入项目即可，<br>
* 3、导入头文件：<br>
`  #import "BAButton.h" `<br>
* 4、项目源码地址：<br>
 OC 版 ：[https://github.com/BAHome/BAButton](https://github.com/BAHome/BAButton)<br>

## 4、BAButton 的类结构及 demo 示例
![BAButton](https://github.com/BAHome/BAButton/blob/master/Images/BAButton.png)

### BAButton.h
```
#ifndef BAButton_h
#define BAButton_h


#import "UIButton+BAKit.h"
#import "UIButton+BAState.h"
#import "UIButton+BACountDown.h"
#import "UIView+BARectCorner.h"
#import "BAKit_ConfigurationDefine.h"


/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BAButton
 
 最新更新时间：2017-09-15【倒叙】<br>
 最新 Version：【Version：2.6.5】<br>
 更新内容：<br>
 2.6.5.1、优化内部代码，修复隐形崩溃 bug！ <br>
 
 最新更新时间：2017-09-12 【倒叙】<br>
 最新 Version：【Version：2.6.4】<br>
 更新内容：<br>
 2.6.4.1、新增 button 点击事件 blcok，具体使用详见 demo！ <br>
 2.6.4.2、新增 button 不同状态下的阴影设置，具体使用详见 demo！ <br>
 2.6.4.3、原 方法 【ba_viewPlaySoundEffectWithFileName】替换为：【ba_buttonPlaySoundEffectWithFileName】，具体使用详见 demo！ <br>
 
 最新更新时间：2017-08-17 【倒叙】<br>
 最新 Version：【Version：2.6.3】<br>
 更新内容：<br>
 2.6.3.1、优化细节处理，新增 连续点击按钮时停止播放上一音乐 <br>
 
 最新更新时间：2017-08-15 【倒叙】<br>
 最新 Version：【Version：2.6.2】<br>
 更新内容：<br>
 2.6.2.1、优化倒计时封装，线程处理优化 <br>
  
 最新更新时间：2017-08-14 【倒叙】<br>
 最新 Version：【Version：2.6.1】<br>
 更新内容：<br>
 2.6.1.1、新增 倒计时按钮纯图片更换，详情请看 倒计时 demo <br>
 
 最新更新时间：2017-08-12 【倒叙】<br>
 最新Version：【Version：2.6.0】<br>
 更新内容：<br>
 2.6.0.1、新增 按钮点击音效和震动效果封装 <br>
 
 最新更新时间：2017-08-03 【倒叙】<br>
 最新Version：【Version：2.5.9】<br>
 更新内容：<br>
 2.5.9.1、修复 UIButton：快速创建 button4：frame、title、backgroundImage 方法死循环bug(感谢群里 [@杭州-秦小强  11:52:23](https://github.com/wqforeverhell) 同学提出的 bug！) <br>
 
 最新更新时间：2017-07-19 【倒叙】<br>
 最新Version：【Version：2.5.8】<br>
 更新内容：<br>
 2.5.8.1、新增 两种快速创建 button 的方法：1、快速创建纯文字 button，2、快速创建纯图片 button <br>
 2.5.8.2、新增 单独配置文字位置的封装 <br>
 2.5.8.3、新增 字体颜色、背景颜色、image 等的 disabled 状态下的配置 <br>

 最新更新时间：2017-07-08 【倒叙】<br>
 最新Version：【Version：2.5.6】<br>
 更新内容：<br>
 2.5.6.1、删除 高亮、选中 背景颜色，以免默认情况下回自动加高亮颜色 <br>
 
 最新更新时间：2017-07-07 【倒叙】<br>
 最新Version：【Version：2.5.5】<br>
 更新内容：<br>
 2.5.5.1、重构 <UIButton+BAKit.h>类，新增多种快速创建 button 的方法 <br>
 2.5.5.2、新增多种快速创建 自定义 button 的方法 <br>
 
 最新更新时间：2017-06-27 【倒叙】<br>
 最新Version：【Version：2.5.4】<br>
 更新内容：<br>
 2.5.4.1、新增 大图片 button 的 layout 布局，如果你的图片宽高大于 自身的宽高，则需要压缩后再配置布局，具体看 demo test2<br>
 
 最新更新时间：2017-06-23 【倒叙】
 最新Version：【Version：2.5.3】
 更新内容：
 2.5.3.1、优化部分宏定义
 
 最新更新时间：2017-06-23 【倒叙】
 最新Version：【Version：2.5.2】
 更新内容：
 2.5.2.1、优化部分宏定义
 
 最新更新时间：2017-06-20 【倒叙】
 最新Version：【Version：2.5.1】
 更新内容：
 2.5.1.1、新增 view 的 border 的创建，可以自定义圆角、边框、边框颜色等(感谢群里 @北京-大腿 同学提出的 需求！)
 2.5.1.2、修复 xib 下圆角右边无效的bug，注意：如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效(感谢群里 @北京-小黑 同学提出的 bug！)
 
 最新更新时间：2017-06-19 【倒叙】
 最新Version：【Version：2.5.0】
 更新内容：
 2.5.0.1、优化命名规范，更换了全局统一属性命名和方法命名，如果更新有报错的地方，大家别急，看 .h 文件更换过来即可，后期推出的 BAKit 系列产品，命名都将统一规范，在此给大家带来的不便之处，向大家道歉！希望大家谅解！多谢体谅！
 
 最新更新时间：2017-06-01 【倒叙】
 最新Version：【Version：2.4.3】
 更新内容：
 2.4.3.1、快速创建 button 方法改为类方法，可直接调用！
 
 最新更新时间：2017-06-01 【倒叙】
 最新Version：【Version：2.4.2】
 更新内容：
 2.4.2.1、优化注释
 
 最新更新时间：2017-06-01 【倒叙】
 最新Version：【Version：2.4.1】
 更新内容：
 2.4.1.1、优化注释，注意：文字、字体大小、图片等设置一定要在设置 ba_button_setBAButtonLayoutType 之前设置，要不然计算会以默认字体大小计算，导致位置偏移
 
 最新更新时间：2017-05-27 【倒叙】
 最新Version：【Version：2.4.0】
 更新内容：
 2.4.0.1、此版本由 [子丰大神](https://github.com/renzifeng) 亲自改版，再次感谢 [子丰大神](https://github.com/renzifeng)
 2.4.0.2、新增 UIButton 各种状态下背景颜色、字体、border、font、动画等的监测及改变
 2.4.0.3、新增 UIButton 倒计时的封装，两行代码搞定倒计时！
 2.4.0.4、优化整体代码结构，代码规范！
 
 最新更新时间：2017-05-26 【倒叙】
 最新Version：【Version：2.3.2】
 更新内容：
 2.3.2.1、优化代码结构，修复 frame 改变后 padding 无法更改的问题！
 
 最新更新时间：2017-05-24 【倒叙】
 最新Version：【Version：2.3.1】
 更新内容：
 2.3.1.1、新增：padding_inset，文字或图片距离 button 左右边界的最小距离，默认为：5
 
 最新更新时间：2017-05-20 【倒叙】
 最新Version：【Version：2.3.0】
 更新内容：
 2.3.0.1、用分类全新重构 BAButton，代码配置更灵活
 2.3.0.2、可以自由设置 button 的文字和图片的布局、间距、每个角的切圆角
 2.3.0.3、全面适配 纯代码、xib、storyboard
 2.3.0.4、版本改动较大，希望大家谅解，如果用老版本的 BAButton，可以参考demo 更换新版本，后期改动不大

*/

#endif /* BAButton_h */
```

### UIButton+BAKit.h
```
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

```

### UIView+BARectCorner.h
```
#import <UIKit/UIKit.h>

/*!
 *  设置 viewRectCornerType 样式，
 *  注意：BAKit_ViewRectCornerType 必须要先设置 viewCornerRadius，才能有效，否则设置无效，
 */
typedef NS_ENUM(NSInteger, BAKit_ViewRectCornerType) {
    /*!
     *  设置下左角 圆角半径
     */
    BAKit_ViewRectCornerTypeBottomLeft = 0,
    /*!
     *  设置下右角 圆角半径
     */
    BAKit_ViewRectCornerTypeBottomRight,
    /*!
     *  设置上左角 圆角半径
     */
    BAKit_ViewRectCornerTypeTopLeft,
    /*!
     *  设置下右角 圆角半径
     */
    BAKit_ViewRectCornerTypeTopRight,
    /*!
     *  设置下左、下右角 圆角半径
     */
    BAKit_ViewRectCornerTypeBottomLeftAndBottomRight,
    /*!
     *  设置上左、上右角 圆角半径
     */
    BAKit_ViewRectCornerTypeTopLeftAndTopRight,
    /*!
     *  设置下左、上左角 圆角半径
     */
    BAKit_ViewRectCornerTypeBottomLeftAndTopLeft,
    /*!
     *  设置下右、上右角 圆角半径
     */
    BAKit_ViewRectCornerTypeBottomRightAndTopRight,
    /*!
     *  设置上左、上右、下右角 圆角半径
     */
    BAKit_ViewRectCornerTypeBottomRightAndTopRightAndTopLeft,
    /*!
     *  设置下右、上右、下左角 圆角半径
     */
    BAKit_ViewRectCornerTypeBottomRightAndTopRightAndBottomLeft,
    /*!
     *  设置全部四个角 圆角半径
     */
    BAKit_ViewRectCornerTypeAllCorners
};

@interface UIView (BARectCorner)

/**
 设置 viewRectCornerType 样式，注意：BAKit_ViewRectCornerType 必须要先设置 viewCornerRadius，才能有效，否则设置无效，如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效
 */
@property (nonatomic, assign) BAKit_ViewRectCornerType ba_viewRectCornerType;

/**
 设置 view ：圆角，如果要全部设置四个角的圆角，可以直接用这个方法，必须要在设置 frame 之后，注意：如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效
 */
@property (nonatomic, assign) CGFloat ba_viewCornerRadius;

/**
  设置 view ：边框边线宽度
 */
@property(nonatomic, assign) CGFloat ba_viewBorderWidth;

/**
 设置 view ：边框边线颜色
 */
@property(nonatomic, strong) UIColor *ba_viewBorderColor;


/**
 快速切圆角
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 */
- (void)ba_view_setViewRectCornerType:(BAKit_ViewRectCornerType)type
                     viewCornerRadius:(CGFloat)viewCornerRadius;

/**
 快速切圆角，带边框、边框颜色

 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 @param borderWidth 边线宽度
 @param borderColor 边线颜色
 */
- (void)ba_view_setViewRectCornerType:(BAKit_ViewRectCornerType)type
                     viewCornerRadius:(CGFloat)viewCornerRadius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;


@end

```
### UIButton+BAState.h
```
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (BAState)
/**
 * 获取当前borderColor
 */
@property(nonatomic, readonly, strong) UIColor *ba_currentBorderColor;

/**
 * 获取当前backgroundColor
 */
@property(nonatomic, readonly, strong) UIColor *ba_currentBackgroundColor;

/**
 * 获取当前titleLabelFont
 */
@property(nonatomic, readonly, strong) UIFont *ba_currentTitleLabelFont;

/**
 * 切换按钮状态时,执行动画的时间,默认0.25s(只有动画执行完毕后,才能会执行下一个点击事件)
 */
@property (nonatomic, assign) NSTimeInterval ba_animatedDuration;

/** 
 * 设置不同状态下的borderColor(支持动画效果) 
 */
- (void)ba_buttonSetborderColor:(UIColor *)borderColor forState:(UIControlState)state animated:(BOOL)animated;

/** 
 * 设置不同状态下的backgroundColor(支持动画效果)
 */
- (void)ba_buttonSetBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state animated:(BOOL)animated;

/** 
 * 设置不同状态下的titleLabelFont 
 */
- (void)ba_buttonSetTitleLabelFont:(UIFont *)titleLabelFont forState:(UIControlState)state;

/** 
 * 获取某个状态的borderColor 
 */
- (UIColor *)ba_buttonBorderColorForState:(UIControlState)state;

/** 
 * 获取某个状态的backgroundColor 
 */
- (UIColor *)ba_buttonBackgroundColorForState:(UIControlState)state;

/** 
 * 获取某个状态的titleLabelFont 
 */
- (UIFont *)ba_buttonTitleLabelFontForState:(UIControlState)state;

/**
 BAButton：创建圆角半径阴影，带半径、阴影颜色
 
 @param cornerRadius 半径
 @param shadowColor 阴影颜色
 @param offset 偏移量
 @param opacity 透明度
 @param shadowRadius 模糊程度
 @param state 状态
 */
- (void)ba_buttonSetRoundShadowWithCornerRadius:(CGFloat)cornerRadius
                                    shadowColor:(UIColor *)shadowColor
                                         offset:(CGSize)offset
                                        opacity:(CGFloat)opacity
                                   shadowRadius:(CGFloat)shadowRadius
                                       forState:(UIControlState)state;

#pragma mark - 使用key-value方式设置

/** 
 * key:@(UIControlState枚举)
 * 注：此方式无动画
 */
- (void)ba_buttonConfigBorderColors:(NSDictionary <NSNumber *,UIColor *>*)borderColors;

/** 
 * key:@(UIControlState枚举)
 * 注：此方式无动画
 */
- (void)ba_buttonConfigBackgroundColors:(NSDictionary <NSNumber *,UIColor *>*)backgroundColors;

/** 
 * key:@(UIControlState枚举)
 */
- (void)ba_buttonConfigTitleLabelFont:(NSDictionary <NSNumber *,UIFont *>*)titleLabelFonts;

@end

NS_ASSUME_NONNULL_END
```

### UIButton+BACountDown.h
```
#import <UIKit/UIKit.h>

typedef void (^BAKit_BAButtonCountDownBlock)(NSInteger currentTime);

@interface UIButton (BACountDown)

@property (nonatomic, copy) void(^timeStoppedCallback)();

/**
 倒计时：带 title，返回时间，title，具体使用看 demo

 @param duration 倒计时时间
 @param format 可选，传nil默认为 @"%zd秒"
 */
- (void)ba_countDownWithTimeInterval:(NSTimeInterval)duration
                     countDownFormat:(NSString *)format;

/**
 倒计时：返回当前时间，可以自定义 title 和 image，具体使用看 demo
 
 @param duration 倒计时时间
 @param block 返回当前时间
 */
- (void)ba_countDownCustomWithTimeInterval:(NSTimeInterval)duration
                                     block:(BAKit_BAButtonCountDownBlock)block;

/** 
 * 倒计时：结束，取消倒计时
 */
- (void)ba_cancelTimer;

@end
```

### demo 示例
```
// 示例1：
	// 注意：文字、字体大小、图片等设置一定要在设置         CGFloat padding = 10;
    CGFloat viewCornerRadius = 15;
    
    [self.normalButton ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeNormal padding:padding];
    
    [self.normalButton ba_button_setViewRectCornerType:BAKit_ViewRectCornerTypeBottomRightAndTopRightAndBottomLeft viewCornerRadius:viewCornerRadius borderWidth:2.0f borderColor:BAKit_Color_RandomRGB()];
    
    
// 示例2：

- (void)setupNavi
{
    CGRect frame = CGRectMake(0, 0, 80, 40);
    UIButton *navi_rightButton = [UIButton ba_creatButtonWithFrame:frame title:@"xib" selTitle:nil titleColor:BAKit_Color_Red_pod titleFont:nil image:[UIImage imageNamed:@"tabbar_mainframeHL"] selImage:nil padding:2 buttonPositionStyle:BAKit_ButtonLayoutTypeCenterImageRight viewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:20 target:self selector:@selector(handleRightNaviButtonAction:)];
    navi_rightButton.backgroundColor = BAKit_Color_RandomRGB_pod();
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navi_rightButton];
    
    UIButton *navi_leftButton = [UIButton ba_creatButtonWithFrame:frame title:@"state" selTitle:nil titleColor:BAKit_Color_Red_pod titleFont:nil image:[UIImage imageNamed:@"tabbar_mainframeHL"] selImage:nil padding:2 buttonPositionStyle:BAKit_ButtonLayoutTypeCenterImageRight viewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:20 target:self selector:@selector(handleLeftNaviButtonAction:)];
    [navi_rightButton ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeBottomLeftAndTopLeft viewCornerRadius:20 borderWidth:2.0f borderColor:BAKit_Color_RandomRGB_pod()];
    navi_rightButton.backgroundColor = BAKit_Color_RandomRGBA_pod();
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navi_leftButton];
    
     // 点击事件 Block 返回！
    BAKit_WeakSelf
    navi_leftButton.ba_buttonActionBlock = ^(UIButton * _Nonnull button) {
        BAKit_StrongSelf
        // 添加按钮点击音效和震动效果
        [button ba_buttonPlaySoundEffectWithFileName:@"begin.mp3" isNeedShock:YES];
        [self.navigationController pushViewController:[ViewController3 new] animated:YES];
    };
    
    navi_rightButton.ba_buttonActionBlock = ^(UIButton * _Nonnull button) {
        BAKit_StrongSelf
        // 添加按钮点击音效和震动效果
        [button ba_buttonPlaySoundEffectWithFileName:@"failure.mp3" isNeedShock:YES];
        [self.navigationController pushViewController:[ViewController2 new] animated:YES];
    };
}

- (void)handleLeftNaviButtonAction:(UIButton *)sender
{
    // 添加按钮点击音效和震动效果
//    [sender ba_viewPlaySoundEffectWithFileName:@"begin.mp3" isNeedShock:YES];
//    [self.navigationController pushViewController:[ViewController3 new] animated:YES];
}

- (void)handleRightNaviButtonAction:(UIButton *)sender
{
    // 添加按钮点击音效和震动效果
//    [sender ba_buttonPlaySoundEffectWithFileName:@"failure.mp3" isNeedShock:YES];
//    [self.navigationController pushViewController:[ViewController2 new] animated:YES];
}

// 示例3：倒计时
- (IBAction)countDownClick:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    __block UIButton *btn = sender;
    [sender ba_countDownCustomWithTimeInterval:5 block:^(NSInteger currentTime) {
        // 此处是可以自由定制 title 和 image
        NSString *title = [NSString stringWithFormat:@"Countdown_0%ld", (long)currentTime];
        dispatch_async(dispatch_get_main_queue(), ^{
            [btn setTitle:nil forState:UIControlStateNormal];
            [btn setBackgroundImage:BAKit_ImageName(title) forState:UIControlStateNormal];
        });
    }];

    [sender setTimeStoppedCallback:^{
        [btn setTitle:@"倒计时" forState:UIControlStateNormal];
    }];
}

- (IBAction)skipClick:(UIButton *)sender {
    __block UIButton *btn = sender;
    [sender ba_countDownWithTimeInterval:5 countDownFormat:@"跳过 %zd"];
    [sender setTimeStoppedCallback:^{
        [btn setTitle:@"跳过" forState:UIControlStateNormal];
    }];
}

// 示例4：测试大图片 button 的 layout 布局，如果你的图片宽高大于 自身的宽高，则需要压缩后再配置布局
- (void)test2
{
    self.button.hidden = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    
    min_x = 100;
    min_y = 100;
    min_w = BAKit_SCREEN_WIDTH - min_x * 2;
    min_h = min_w;
    self.button.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    // 根据宽比例去缩放图片，注意：如果button 的图片 太宽，需要调用此方法去等比压缩图片，压缩完的图片，记得要在frame 之后设置图片
    UIImage *stretchableButtonImage = [[UIImage imageNamed:@"条形码.jpg"] ba_imageScaleToWidth:_button.frame.size.width];
    [_button setImage:stretchableButtonImage forState:UIControlStateNormal];
    
    // button 图文布局也要在图片设置之后设置才能有效
    _button.ba_buttonLayoutType = BAKit_ButtonLayoutTypeCenterImageTop;
}

#pragma mark - 测试大图片 button 的 layout 布局，如果你的图片宽高大于 自身的宽高，则需要压缩后再配置布局
- (UIButton *)button
{
    if (!_button)
    {
        // 测试大图片 button 的 layout 布局，如果你的图片宽高大于 自身的宽高，则需要压缩后再配置布局
        // 原生写法
        //        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_button setTitle:@"123456" forState:UIControlStateNormal];
        //        [_button setTitleColor:BAKit_Color_Red_pod forState:UIControlStateNormal];
        //        _button.backgroundColor = BAKit_Color_Gray_10_pod;
        
        // BAButton 简单写法
        _button = [UIButton ba_buttonWithFrame:CGRectZero title:@"123456" titleColor:BAKit_Color_Red_pod titleFont:[UIFont systemFontOfSize:15] backgroundColor:BAKit_Color_Gray_10_pod];
        
        [self.view addSubview:_button];
    }
    return _button;
}

其他示例可下载demo查看源码！
```

## 5、更新记录：【倒叙】
 欢迎使用 [【BAHome】](https://github.com/BAHome) 系列开源代码 ！
 如有更多需求，请前往：[【https://github.com/BAHome】](https://github.com/BAHome) 
 
 最新更新时间：2017-09-15【倒叙】<br>
 最新 Version：【Version：2.6.5】<br>
 更新内容：<br>
 2.6.5.1、优化内部代码，修复隐形崩溃 bug！ <br>
 
 最新更新时间：2017-09-12 【倒叙】<br>
 最新 Version：【Version：2.6.4】<br>
 更新内容：<br>
 2.6.4.1、新增 button 点击事件 blcok，具体使用详见 demo！ <br>
 2.6.4.2、新增 button 不同状态下的阴影设置，具体使用详见 demo！ <br>
 2.6.4.3、原 方法 【ba_viewPlaySoundEffectWithFileName】替换为：【ba_buttonPlaySoundEffectWithFileName】，具体使用详见 demo！ <br>
 
 最新更新时间：2017-08-17 【倒叙】<br>
 最新 Version：【Version：2.6.3】<br>
 更新内容：<br>
 2.6.3.1、优化细节处理，新增 连续点击按钮时停止播放上一音乐 <br>
 
 最新更新时间：2017-08-15 【倒叙】<br>
 最新 Version：【Version：2.6.2】<br>
 更新内容：<br>
 2.6.2.1、优化倒计时封装，线程处理优化 <br>
 
 最新更新时间：2017-08-14 【倒叙】<br>
 最新 Version：【Version：2.6.1】<br>
 更新内容：<br>
 2.6.1.1、新增 倒计时按钮纯图片更换，详情请看 倒计时 demo <br>
 
 最新更新时间：2017-08-12 【倒叙】<br>
 最新Version：【Version：2.6.0】<br>
 更新内容：<br>
 2.6.0.1、新增 按钮点击音效和震动效果封装 <br>
 
 最新更新时间：2017-08-03 【倒叙】<br>
 最新Version：【Version：2.5.9】<br>
 更新内容：<br>
 2.5.9.1、修复 UIButton：快速创建 button4：frame、title、backgroundImage 方法死循环bug(感谢群里 [@杭州-秦小强  11:52:23](https://github.com/wqforeverhell) 同学提出的 bug！) <br>
 
 最新更新时间：2017-07-19 【倒叙】<br>
 最新Version：【Version：2.5.8】<br>
 更新内容：<br>
 2.5.8.1、新增 两种快速创建 button 的方法：1、快速创建纯文字 button，2、快速创建纯图片 button <br>
 2.5.8.2、新增 单独配置文字位置的封装 <br>
 2.5.8.3、新增 字体颜色、背景颜色、image 等的 disabled 状态下的配置 <br>

 最新更新时间：2017-07-08 【倒叙】<br>
 最新Version：【Version：2.5.6】<br>
 更新内容：<br>
 2.5.6.1、删除 高亮、选中 背景颜色，以免默认情况下回自动加高亮颜色 <br>
 
 最新更新时间：2017-07-07 【倒叙】<br>
 最新Version：【Version：2.5.5】<br>
 更新内容：<br>
 2.5.5.1、重构 <UIButton+BAKit.h>类，新增多种快速创建 button 的方法 <br>
 2.5.5.2、新增多种快速创建 自定义 button 的方法 <br>
  
 最新更新时间：2017-06-27 【倒叙】<br>
 最新Version：【Version：2.5.4】<br>
 更新内容：<br>
 2.5.4.1、新增 大图片 button 的 layout 布局，如果你的图片宽高大于 自身的宽高，则需要压缩后再配置布局，具体看 demo test2<br>
 
 最新更新时间：2017-06-23 【倒叙】<br>
 最新Version：【Version：2.5.3】<br>
 更新内容：<br>
 2.5.3.1、优化部分宏定义<br>
 
 最新更新时间：2017-06-23 【倒叙】<br>
 最新Version：【Version：2.5.2】<br>
 更新内容：<br>
 2.5.2.1、优化部分宏定义
 
 最新更新时间：2017-06-20 【倒叙】<br>
 最新Version：【Version：2.5.1】<br>
 更新内容：<br>
 2.5.1.1、新增 view 的 border 的创建，可以自定义圆角、边框、边框颜色等(感谢群里 [@北京-大腿](http://www.jianshu.com/u/69939e049851) 同学提出的 需求！)<br>
 2.5.1.2、修复 xib 下圆角右边无效的bug，注意：如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效(感谢群里 [@北京-小黑](https://github.com/baishitong) 同学提出的 bug！)<br>
 
 最新更新时间：2017-06-19 【倒叙】<br>
 最新Version：【Version：2.5.0】<br>
 更新内容：<br>
 2.5.0.1、优化命名规范，更换了全局统一属性命名和方法命名，如果更新有报错的地方，大家别急，看 .h 文件更换过来即可，后期推出的 BAKit 系列产品，命名都将统一规范，在此给大家带来的不便之处，向大家道歉！希望大家谅解！多谢体谅！<br>
 
 最新更新时间：2017-06-01 【倒叙】<br>
 最新Version：【Version：2.4.3】<br>
 更新内容：<br>
 2.4.3.1、快速创建 button 方法改为类方法，可直接调用！<br>
 
 最新更新时间：2017-06-01 【倒叙】<br>
 最新Version：【Version：2.4.2】<br>
 更新内容：<br>
 2.4.2.1、优化注释<br>

 最新更新时间：2017-06-01 【倒叙】<br>
 最新Version：【Version：2.4.1】<br>
 更新内容：<br>
 2.4.1.1、优化注释，注意：文字、字体大小、图片等设置一定要在设置 ba_button_setBAButtonLayoutType 之前设置，要不然计算会以默认字体大小计算，导致位置偏移<br>
 
 最新更新时间：2017-05-27 【倒叙】<br>
 最新Version：【Version：2.4.0】<br>
 更新内容：<br>
 2.4.0.1、此版本由 [子丰大神](https://github.com/renzifeng) 亲自改版，再次感谢 [子丰大神](https://github.com/renzifeng)<br>
 2.4.0.2、新增 UIButton 各种状态下背景颜色、字体、border、font、动画等的监测及改变<br>
 2.4.0.3、新增 UIButton 倒计时的封装，两行代码搞定倒计时！<br>
 2.4.0.4、优化整体代码结构，代码规范！<br>
 
 最新更新时间：2017-05-26 【倒叙】<br>
 最新Version：【Version：2.3.2】<br>
 更新内容：<br>
 2.3.2.1、优化代码结构，修复 frame 改变后 padding 无法更改的问题！<br>
 
 最新更新时间：2017-05-24 【倒叙】<br>
 最新Version：【Version：2.3.1】<br>
 更新内容：<br>
 2.3.1.1、新增：padding_inset，文字或图片距离 button 左右边界的最小距离，默认为：5<br>
 
 最新更新时间：2017-05-20 【倒叙】
 最新Version：【Version：2.3.0】<br>
 更新内容：<br>
 2.3.0.1、用分类全新重构 BAButton，代码配置更灵活<br>
 2.3.0.2、可以自由设置 button 的文字和图片的布局、间距、每个角的切圆角<br>
 2.3.0.3、全面适配 纯代码、xib、storyboard<br>
 2.3.0.4、版本改动较大，希望大家谅解，如果用老版本的 BAButton，可以参考demo 更换新版本，后期改动不大<br>

* 2017-04-24 <br>
最新Version：【Version：2.2.1】<br>
更新内容：<br>
2.2.1.1、新增快速创建button 的demo，和 自定义 naviButton demo

* 2017-03-15 <br>
 最新Version：【Version：2.2.1】<br>
 更新内容：<br>
 2.2.1.1、button 的 角半径 buttonCornerRadii，默认 CGSizeMake(0, 0)

* 2017-03-02 <br>
 最新Version：【Version：2.2.0】<br>
 更新内容：<br>
 2.2.0.1、修复 buttonCornerRadii 只能在添加frame 后设置才能有效的问题，现在可以随意设置<br>
 2.2.0.2、新增设置文字或和图片间距，举个🌰：self.padding = 10;

* 2017-02-28 【倒叙】<br>
 最新Version：【Version：2.1.0】<br>
 更新内容：<br>
 2.1.1、继承自 UIButton 可以像 UIButton 一样随便添加系统属性<br>
 2.1.2、可以单独设置文字和图片的位置<br>
 2.1.3、还可以设置文字或者图片间距<br>
 2.1.4、可以设置按钮的任意一个角的圆角度数<br>
 2.1.4、全面适配纯代码、xib、storyboard
 
* 2016.03.04 <br>
pod 最新上架，修复部分已知bug，代码更精简！

## 6、bug 反馈
> 1、开发中遇到 bug，希望小伙伴儿们能够及时反馈与我们 BAHome 团队，我们必定会认真对待每一个问题！ <br>

> 2、以后提需求和 bug 的同学，记得把 git 或者博客链接给我们，我直接超链到你们那里！希望大家积极参与测试！<br> 

## 7、BAHome 团队成员
> 1、QQ 群 
479663605 <br> 
【注意：此群为 2 元 付费群，介意的小伙伴儿勿扰！】<br> 

> 孙博岩 <br> 
QQ：137361770 <br> 
git：[https://github.com/boai](https://github.com/boai) <br>
简书：[http://www.jianshu.com/u/95c9800fdf47](http://www.jianshu.com/u/95c9800fdf47) <br>
微博：[![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123) <br>

> 马景丽 <br> 
QQ：1253540493 <br> 
git：[https://github.com/MaJingli](https://github.com/MaJingli) <br>

> 陆晓峰 <br> 
QQ：442171865 <br> 
git：[https://github.com/zeR0Lu](https://github.com/zeR0Lu) <br>

> 陈集 <br> 
QQ：3161182978 <br> 
git：[https://github.com/chenjipdc](https://github.com/chenjipdc) <br>
简书：[http://www.jianshu.com/u/90ae559fc21d](http://www.jianshu.com/u/90ae559fc21d)

> 任子丰 <br> 
QQ：459643690 <br> 
git：[https://github.com/renzifeng](https://github.com/renzifeng) <br>

> 吴丰收 <br> 
QQ：498121294 <br> 

> 石少庸 <br> 
QQ：363605775 <br> 
git：[https://github.com/CrazyCoderShi](https://github.com/CrazyCoderShi) <br>
简书：[http://www.jianshu.com/u/0726f4d689a3](http://www.jianshu.com/u/0726f4d689a3)

## 8、开发环境 和 支持版本
> 开发使用 最新版本 Xcode，理论上支持 iOS 8 及以上版本，如有版本适配问题，请及时反馈！多谢合作！

## 9、感谢
> 感谢 [【BAHome】](https://github.com/BAHome) 团队成员倾力合作，后期会推出一系列 常用 UI 控件的封装，大家有需求得也可以在 issue 提出，如果合理，我们会尽快推出新版本！<br>

>  [【BAHome】](https://github.com/BAHome)  的发展离不开小伙伴儿的信任与推广，再次感谢各位小伙伴儿的支持！

