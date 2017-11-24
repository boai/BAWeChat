# BAAlertController
[![BAHome Team Name](https://img.shields.io/badge/Team-BAHome-brightgreen.svg?style=flat)](https://github.com/BAHome "BAHome Team")
![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/cocoapods/v/BAAlertController.svg?style=flat) ![](https://img.shields.io/cocoapods/dt/BAAlertController.svg
)  [![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123)

## 1、功能及简介
* 1、用分类封装系统的 UIAlertController，代码无侵入，简洁高效，一个block 搞定系统alert 和 actionSheet
* 2、可以自定义按钮数量、按钮颜色【多按钮样式，颜色数组和title数组个数不等情况下，默认蓝色】
* 3、可以自定义 NSMutableAttributedString 的 alert 和 actionSheet，让你的 alert 更加炫酷
* 4、完美适配 iPhone 和 iPad 版本
* 5、理论完全兼容现有 iOS 8 以上系统版本

## 2、图片示例
![BAAlertController1](https://github.com/BAHome/BAAlertController/blob/master/Images/BAAlertController1.png)
![BAAlertController2](https://github.com/BAHome/BAAlertController/blob/master/Images/BAAlertController2.png)
![BAAlertController3](https://github.com/BAHome/BAAlertController/blob/master/Images/BAAlertController3.png)
![BAAlertController4](https://github.com/BAHome/BAAlertController/blob/master/Images/BAAlertController4.png)
![BAAlertController5](https://github.com/BAHome/BAAlertController/blob/master/Images/BAAlertController5.png)
![BAAlertController6](https://github.com/BAHome/BAAlertController/blob/master/Images/BAAlertController6.png)
![BAAlertController7](https://github.com/BAHome/BAAlertController/blob/master/Images/BAAlertController7.png)

## 3、安装、导入示例和源码地址
* 1、pod 导入【最新版本：![](https://img.shields.io/cocoapods/v/BAAlertController.svg?style=flat)】： <br>
 `pod 'BAAlertController'` <br>
如果发现 `pod search BAAlertController` 搜索出来的不是最新版本，需要在终端执行 cd 转换文件路径命令退回到 desktop，然后执行 `pod setup` 命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了。<br>
具体步骤：
  - pod setup : 初始化
  - pod repo update : 更新仓库
  - pod search BAAlertController
* 2、文件夹拖入：下载demo，把 BAAlertController 文件夹拖入项目即可，<br>
* 3、导入头文件：<br>
`  #import "BAAlertController.h" `<br>
* 4、项目源码地址：<br>
 OC 版 ：[https://github.com/BAHome/BAAlertController](https://github.com/BAHome/BAAlertController)<br>

## 4、BAAlertController 的类结构及 demo 示例
![BAAlertController](https://github.com/BAHome/BAAlertController/blob/master/Images/BAAlertController.png)

### BAAlertController.h
```
#ifndef BAAlertController_h
#define BAAlertController_h

#import "UIAlertController+BAKit.h"
#import "NSObject+BARunTime.h"
#import "NSMutableAttributedString+BAKit.h"

/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BAAlertController
 
 最新更新时间：2017-06-24 【倒叙】<br>
 最新Version：【Version：1.0.2】<br>
 更新内容：<br>
 1.0.2.1、优化内部细节命名，不影响外部使用<br>
 
 最新更新时间：2017-06-24 【倒叙】<br>
 最新Version：【Version：1.0.1】<br>
 更新内容：<br>
 1.0.1.1、更换方法名，原：ba_alert2ShowInViewController 替换为：ba_alertTextFieldShowInViewController<br>
 
 最新更新时间：2017-06-05 【倒叙】
 最新Version：【Version：1.0.0】
 更新内容：
 1.0.0.1、普通的 UIAlertController-alert，可以自由设置按钮数量、按钮颜色,
 1.0.0.2、普通的 UIAlertController-alert，可以自由设置按钮数量、按钮颜色【多按钮样式，颜色数组和title数组个数不等】
 1.0.0.3、普通的 带 textField 的 UIAlertController-alert，可添加一个或者多个 textField
 1.0.0.4、NSMutableAttributedString 的UIAlertController-alert，可以自由设置 NSMutableAttributedString（title、message）按钮数量、按钮颜色
 1.0.0.5、普通的 UIAlertController-actionSheet，可以自由设置按钮数量、按钮颜色
 1.0.0.6、NSMutableAttributedString 的UIAlertController-actionSheet，可以自由设置 NSMutableAttributedString（title、message）按钮数量、按钮颜色
 1.0.0.7、完美适配 iPhone 和 iPad 版本
 1.0.0.8、理论完全兼容现有 iOS 8 以上系统版本
 
 */

#endif /* BAAlertController_h */
```

### UIAlertController+BAKit.h
```
#import <UIKit/UIKit.h>

#if TARGET_OS_IOS
typedef void (^UIAlertControllerPopoverPresentationControllerBlock) (UIPopoverPresentationController * __nonnull popover);
#endif

/**
 按钮点击事件 block

 @param alertController alertController
 @param action UIAlertAction
 @param buttonIndex buttonIndex
 */
typedef void (^BAKit_AlertControllerButtonActionBlock) (UIAlertController * __nonnull alertController, UIAlertAction * __nonnull action, NSInteger buttonIndex);

/**
 textField 配置信息 block

 @param textField textField
 @param index index
 */
typedef void (^BAKit_AlertControllerTextFieldConfigurationActionBlock)(UITextField * _Nullable textField, NSInteger index);

@interface UIAlertController (BAKit)

/**
 快速创建一个系统 普通 UIAlertController-Alert
 
 @param viewController 显示的VC
 @param title title
 @param message message
 @param buttonTitleArray 按钮数组
 @param buttonTitleColorArray 按钮颜色数组，默认：系统蓝色，如果颜色数组个数小于title数组个数，则全部为默认蓝色
 @param block block
 @return UIAlertController-Alert
 */
+ (nonnull instancetype)ba_alertShowInViewController:(nonnull UIViewController *)viewController
                                               title:(nullable NSString *)title
                                             message:(nullable NSString *)message
                                    buttonTitleArray:(nullable NSArray *)buttonTitleArray
                               buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
                                               block:(nullable BAKit_AlertControllerButtonActionBlock)block;

/**
 快速创建一个系统 普通 带 textField 的 UIAlertController-Alert
 
 @param viewController 显示的VC
 @param title title
 @param message message
 @param buttonTitleArray 按钮数组
 @param buttonTitleColorArray 按钮颜色数组，默认：系统蓝色，如果颜色数组个数小于title数组个数，则全部为默认蓝色
 @param buttonEnabledNoWithTitleArray 初始化的时候按钮为 EnabledNo 状态 的 title 数组
 @param textFieldPlaceholderArray textFieldPlaceholderArray 需要添加的 textField placeholder 数组
 @param textFieldConfigurationActionBlock textField 配置信息 block
 @param block block
 @return 普通 带 textField 的 UIAlertController-Alert
 */
+ (nonnull instancetype)ba_alertTextFieldShowInViewController:(nonnull UIViewController *)viewController
                                                title:(nullable NSString *)title
                                              message:(nullable NSString *)message
                                     buttonTitleArray:(nullable NSArray *)buttonTitleArray
                                buttonTitleColorArray:(nullable NSArray <UIColor *> *)buttonTitleColorArray
                        buttonEnabledNoWithTitleArray:(NSArray <NSString *> *_Nullable)buttonEnabledNoWithTitleArray
                            textFieldPlaceholderArray:(NSArray <NSString *> *_Nullable)textFieldPlaceholderArray
                    textFieldConfigurationActionBlock:(nullable BAKit_AlertControllerTextFieldConfigurationActionBlock)textFieldConfigurationActionBlock
                                                block:(nullable BAKit_AlertControllerButtonActionBlock)block;

/**
 快速创建一个系统 attributedTitle UIAlertController-Alert
 
 @param viewController 显示的VC
 @param attributedTitle attributedTitle
 @param attributedMessage attributedMessage
 @param buttonTitleArray 按钮数组
 @param buttonTitleColorArray 按钮颜色数组，默认：系统蓝色，如果颜色数组个数小于title数组个数，则全部为默认蓝色
 @param block block
 @return UIAlertController-Alert
 */
+ (nonnull instancetype)ba_alertAttributedShowInViewController:(nonnull UIViewController *)viewController
                                               attributedTitle:(nullable NSMutableAttributedString *)attributedTitle
                                             attributedMessage:(nullable NSMutableAttributedString *)attributedMessage
                                              buttonTitleArray:(nullable NSArray *)buttonTitleArray
                                         buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
                                                         block:(nullable BAKit_AlertControllerButtonActionBlock)block;


/**
 快速创建一个系统 普通 UIAlertController-ActionSheet
 
 @param viewController 显示的VC
 @param title title
 @param message message
 @param buttonTitleArray 按钮数组
 @param buttonTitleColorArray 按钮颜色数组，默认：系统蓝色，如果颜色数组个数小于title数组个数，则全部为默认蓝色
 @param popoverPresentationControllerBlock popoverPresentationControllerBlock description
 @param block block
 @return UIAlertController-ActionSheet
 */
+ (nonnull instancetype)ba_actionSheetShowInViewController:(nonnull UIViewController *)viewController
                                                                title:(nullable NSString *)title
                                                                  message:(nullable NSString *)message
                                                        buttonTitleArray:(nullable NSArray *)buttonTitleArray
                                                    buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
#if TARGET_OS_IOS
                                       popoverPresentationControllerBlock:(nullable UIAlertControllerPopoverPresentationControllerBlock)popoverPresentationControllerBlock
#endif
                                                                block:(nullable BAKit_AlertControllerButtonActionBlock)block;

/**
 快速创建一个系统 attributedTitle UIAlertController-ActionSheet
 
 @param viewController 显示的VC
 @param attributedTitle attributedTitle
 @param attributedMessage attributedMessage
 @param buttonTitleArray 按钮数组
 @param buttonTitleColorArray 按钮颜色数组，默认：系统蓝色，如果颜色数组个数小于title数组个数，则全部为默认蓝色
 @param popoverPresentationControllerBlock popoverPresentationControllerBlock description
 @param block block
 @return UIAlertController-ActionSheet
 */
+ (nonnull instancetype)ba_actionSheetAttributedShowInViewController:(nonnull UIViewController *)viewController
                                                     attributedTitle:(nullable NSMutableAttributedString *)attributedTitle
                                                   attributedMessage:(nullable NSMutableAttributedString *)attributedMessage
                                                    buttonTitleArray:(nullable NSArray *)buttonTitleArray
                                               buttonTitleColorArray:(nullable NSArray <UIColor *>*)buttonTitleColorArray
#if TARGET_OS_IOS
                                  popoverPresentationControllerBlock:(nullable UIAlertControllerPopoverPresentationControllerBlock)popoverPresentationControllerBlock
#endif
                                                               block:(nullable BAKit_AlertControllerButtonActionBlock)block;

@end
```

### NSObject+BARunTime.h
```
#import <Foundation/Foundation.h>

@interface NSObject (BARunTime)

/**
 *  将 ‘字典数组‘ 转换成当前模型的对象数组
 *
 *  @param array 字典数组
 *
 *  @return 返回模型对象的数组
 */
+ (NSArray *)ba_objectsWithArray:(NSArray *)array;

/**
 *  返回当前类的所有属性列表
 *
 *  @return 属性名称
 */
+ (NSArray *)ba_propertysList;

/**
 *  返回当前类的所有成员变量数组
 *
 *  @return 当前类的所有成员变量！ 
 *
 *  Tips：用于调试, 可以尝试查看所有不开源的类的ivar
 */
+ (NSArray *)ba_ivarList;

/**
 *  返回当前类的所有方法
 *
 *  @return 当前类的所有成员变量！
 */
+ (NSArray *)ba_methodList;

/**
 *  返回当前类的所有协议
 *
 *  @return 当前类的所有协议！
 */
+ (NSArray *)ba_protocolList;

@end
```

### NSMutableAttributedString+BAKit.h
```
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (BAKit)
#pragma mark - *****  富文本处理 类

/*! 完全自定义样式 */
- (void)ba_changeAttributeDict:(NSDictionary *)dict range:(NSRange)range;

/*! 改变某位置的颜色 */
- (void)ba_changeColor:(UIColor *)color range:(NSRange)range;

/*! 设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色 */
- (void)ba_changeBackgroundColor:(UIColor *)color range:(NSRange)range;

///*! 设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符，  //  2 表示使用所有连体符号，默认值为 1（iOS 不支持 2） */
//- (void)ba_changeLigatureWithValue:(int)value range:(NSRange)range;

/*! 改变某位置的普通字号 */
- (void)ba_changeSystemFont:(UIFont *)font range:(NSRange)range;

/*! 设置字形倾斜度，取值为 NSNumber（float）,正值右倾，负值左倾   */
- (void)ba_changeObliquenessValue:(NSNumber *)value range:(NSRange)range;

/*! 设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本 */
- (void)ba_changeVerticalGlyphFormValue:(NSNumber *)value range:(NSRange)range;

/*! 设置文字书写方向，从左向右书写或者从右向左书写 */
- (void)ba_changeWritingDirectionStyle:(NSWritingDirection)style;

/*! 改变某位置的行距 */
- (void)ba_changeLineSpacing:(CGFloat)spacing
                        from:(NSInteger)loc
                       length:(NSInteger)length;

/*! 改变某位置的段落距离 */
- (void)ba_changeParagraphSpacing:(CGFloat)spacing
                              from:(NSInteger)loc
                             length:(NSInteger)length;

/*! 改变段的顶部和文本内容的开头之间的距离 */
- (void)ba_changeBeforeLparagraphSpacing:(CGFloat)spacing
                                   from:(NSInteger)loc
                                  length:(NSInteger)length;

/*! 设置下划线样式：根据枚举选择 */
- (void)ba_changeUnderlineStyle:(NSUnderlineStyle)style color:(UIColor *)color Range:(NSRange)range;
/*! 全部加下划线 设置下划线样式：根据枚举选择 */
- (void)ba_changeUnderlineAtAllStyle:(NSUnderlineStyle)style color:(UIColor *)color;

/*! 设置删除线样式：根据枚举选择 */
- (void)ba_changeStrikethroughStyle:(NSUnderlineStyle)style color:(UIColor *)color Range:(NSRange)range;
/*! 全部添加删除线 设置删除线样式：根据枚举选择 */
- (void)ba_changeStrikethroughAtAllStyle:(NSUnderlineStyle)style color:(UIColor *)color;

/*! 设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄  */
- (void)ba_changeKernWithValue:(NSNumber *)value Range:(NSRange)range;

/*! 根据位置设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本 */
- (void)ba_changeExpansionWithValue:(NSNumber *)value Range:(NSRange)range;
#pragma mark

/*! 根据位置添加阴影效果 */
- (void)ba_changeShadowWithShadow:(NSShadow *)shadow Range:(NSRange)range;

/*! 根据位置修改描边颜色 */
- (void)ba_changeStrokeColorWithColor:(UIColor *)strokeColor
                             strokeWidth:(NSNumber *)strokeWidth
                                   Range:(NSRange)range;

/*!
 *
 *   实例化 NSMutableAttributedString 字符串
 *
 *  @param texts      用于存储所需设置字符串的数组(根据所需自定义类型分组)
 *  @param attrsArray 富文本属性样式的集合(数组元素是texts的相应文本的属性--字典)
 *  @param space      texts文本之间的间距数组 1 代表一个空格的距离
 *
 *  @return NSMutableAttributedString实例
 */
- (instancetype)initWithStrings:(NSArray <NSString *>*)texts
                attributesArray:(NSArray <NSDictionary<NSString *,id>*>*)attrsArray
                      space:(NSArray <NSNumber *>*)space;

@end
```

### demo 示例
```
- (void)alertController1
{
    NSArray *buttonTitleColorArray = @[BAKit_Color_Red_pod, BAKit_Color_Green_pod] ;

    [UIAlertController ba_alertShowInViewController:self
                                              title:title0
                                            message:msg0
                                   buttonTitleArray:@[@"取 消", @"确 定"]
                              buttonTitleColorArray:buttonTitleColorArray
                                              block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
      NSString *msg = [NSString stringWithFormat:@"你点击了第 %ld 个按钮！", (long)buttonIndex];
      BAKit_ShowAlertWithMsg_ios8(msg);
    }];
}

- (void)alertController2
{
    NSArray *buttonTitleColorArray = @[BAKit_Color_Red_pod, BAKit_Color_Green_pod] ;

    [UIAlertController ba_alertShowInViewController:self
                                              title:title0
                                            message:msg0
                                   buttonTitleArray:@[@"取 消", @"确 定", @"确 定1", @"确 定2"]
                              buttonTitleColorArray:buttonTitleColorArray
                                              block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                  NSString *msg = [NSString stringWithFormat:@"你点击了第 %ld 个按钮！", (long)buttonIndex];
                                                  BAKit_ShowAlertWithMsg_ios8(msg);
                                                  
                                              }];
}

- (void)alertController3
{
    // AlertController 的 textField placeholder 数组，根据这个添加 textField
    NSArray *textFieldPlaceholderArray = @[@"用户名/手机号/邮箱", @"密码"];
    NSArray *buttonTitleColorArray = @[BAKit_Color_Red_pod, BAKit_Color_Green_pod] ;

    [UIAlertController ba_alertTextFieldShowInViewController:self title:msg2 message:nil  buttonTitleArray:@[@"取 消", @"确 定"] buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:@[@"确 定"] textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
        // 添加通知，监听 textField 输入的文字变化
        [BAKit_NotiCenter addObserver:self selector:@selector(handleAlertTextFieldDidChangeAction:) name:UITextFieldTextDidChangeNotification object:textField];

        if (index == 0)
        {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (index == 1)
        {
            textField.secureTextEntry = YES;
        }
        
    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        UITextField *loginTextField = alertController.textFields[0];
        UITextField *passwordTextField = alertController.textFields[1];

        NSString *msg = [NSString stringWithFormat:@"你点击了第 %ld 个按钮！\n账号：%@\n密码：%@", (long)buttonIndex, loginTextField.text, passwordTextField.text];
        BAKit_ShowAlertWithMsg_ios8(msg);
        [BAKit_NotiCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];

    }];
}

- (void)handleAlertTextFieldDidChangeAction:(NSNotification *)notification
{
    // 通知处理，判断文字输入的长度 大于 3 的时候，确定按钮可点击，否则，不可点击
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *login = alertController.textFields[0];
        UIAlertAction *sureAction = alertController.actions[1];
        sureAction.enabled = login.text.length > 3;
    }
}

- (void)alertController4
{
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title0 attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
    NSString *result = @"当前用户未 登录 ，是否 登录 ？";
    NSString *keyWord = @"登录";
    
    /*! 关键字添加效果 */
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc]initWithString:result];
    
    /*! 获取关键字位置 */
    NSRange range = [result rangeOfString:keyWord];
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@2.0,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrokeColorAttributeName:[UIColor blueColor],NSStrokeWidthAttributeName:@2.0,NSVerticalGlyphFormAttributeName:@(0)};
    
    /*! 设置关键字属性 */
    [attributedMessage ba_changeAttributeDict:dic range:range];
    
    NSArray *buttonTitleColorArray = @[BAKit_Color_Red_pod, BAKit_Color_Green_pod] ;

    [UIAlertController ba_alertAttributedShowInViewController:self
                                              attributedTitle:attributedTitle
                                            attributedMessage:attributedMessage
                                             buttonTitleArray:@[@"取 消", @"确 定"]
                                        buttonTitleColorArray:buttonTitleColorArray
                                                        block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                            
                                                            NSString *msg = [NSString stringWithFormat:@"你点击了第 %ld 个按钮！", (long)buttonIndex];
                                                            BAKit_ShowAlertWithMsg_ios8(msg);
    }];
}

- (void)alertController5
{
    NSArray *buttonTitleColorArray = @[BAKit_Color_Red_pod, BAKit_Color_Green_pod, BAKit_Color_Yellow_pod, BAKit_Color_Orange_pod] ;
    [UIAlertController ba_actionSheetShowInViewController:self title:title0 message:nil buttonTitleArray:@[@"safari打开", @"复制链接", @"分享", @"刷新"] buttonTitleColorArray:buttonTitleColorArray popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
        
        if (popover)
        {
            // 在使用 UITableViewCell 的frame属性获取origin得到的坐标是不变的. 也就是说如果UITableView初始化完毕后,每个cell的坐标是固定的,x不变,y 随index递增的. 经过测试发现,任何一个cell拖拽或则滑动到UITableView的任意相对位置,cell的frame属性都没有改变. 那怎样获取UITableViewCell相对于UITableView的坐标?
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:self.indexPath];
            CGRect frame = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
            popover.sourceView = self.view;
            popover.sourceRect = frame;
            // 如果用的是按钮点击需要做 iPad 版本适配的话，就需要在次设置
//            popover.sourceView = sender;
//            popover.sourceRect = sender.bounds;
            
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        NSString *msg = [NSString stringWithFormat:@"你点击了第 %ld 个按钮！", (long)buttonIndex];
        BAKit_ShowAlertWithMsg_ios8(msg);
        
    }];
}

- (void)alertController6
{
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title0 attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
    NSString *result = @"当前用户未 登录 ，是否 登录 ？";
    NSString *keyWord = @"登录";
    
    /*! 关键字添加效果 */
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc]initWithString:result];
    
    /*! 获取关键字位置 */
    NSRange range = [result rangeOfString:keyWord];
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@2.0,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrokeColorAttributeName:[UIColor blueColor],NSStrokeWidthAttributeName:@2.0,NSVerticalGlyphFormAttributeName:@(0)};
    
    /*! 设置关键字属性 */
    [attributedMessage ba_changeAttributeDict:dic range:range];
    
    NSArray *buttonTitleColorArray = @[BAKit_Color_Red_pod, BAKit_Color_Green_pod, BAKit_Color_Yellow_pod, BAKit_Color_Orange_pod];

    [UIAlertController ba_actionSheetAttributedShowInViewController:self attributedTitle:attributedTitle attributedMessage:attributedMessage buttonTitleArray:@[@"safari打开", @"复制链接", @"分享", @"刷新"] buttonTitleColorArray:buttonTitleColorArray popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
        if (popover)
        {
            // 在使用 UITableViewCell 的frame属性获取origin得到的坐标是不变的. 也就是说如果UITableView初始化完毕后,每个cell的坐标是固定的,x不变,y 随index递增的. 经过测试发现,任何一个cell拖拽或则滑动到UITableView的任意相对位置,cell的frame属性都没有改变. 那怎样获取UITableViewCell相对于UITableView的坐标?
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:self.indexPath];
            CGRect frame = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
            popover.sourceView = self.view;
            popover.sourceRect = frame;
            // 如果用的是按钮点击需要做 iPad 版本适配的话，就需要在次设置
            //            popover.sourceView = sender;
            //            popover.sourceRect = sender.bounds;
            
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        NSString *msg = [NSString stringWithFormat:@"你点击了第 %ld 个按钮！", (long)buttonIndex];
        BAKit_ShowAlertWithMsg_ios8(msg);
        
    }];
}

其他示例可下载demo查看源码！
```

## 5、更新记录：【倒叙】
 欢迎使用 [【BAHome】](https://github.com/BAHome) 系列开源代码 ！
 如有更多需求，请前往：[【https://github.com/BAHome】](https://github.com/BAHome) 
 
 最新更新时间：2017-06-24 【倒叙】<br>
 最新Version：【Version：1.0.2】<br>
 更新内容：<br>
 1.0.2.1、优化内部细节命名，不影响外部使用<br>
 
 最新更新时间：2017-06-24 【倒叙】<br>
 最新Version：【Version：1.0.1】<br>
 更新内容：<br>
 1.0.1.1、更换方法名，原：ba_alert2ShowInViewController 替换为：ba_alertTextFieldShowInViewController<br>
 
 最新更新时间：2017-06-05 【倒叙】<br>
 最新Version：【Version：1.0.0】<br>
 更新内容：<br>
 1.0.0.1、普通的 UIAlertController-alert，可以自由设置按钮数量、按钮颜色<br>
 1.0.0.2、普通的 UIAlertController-alert，可以自由设置按钮数量、按钮颜色【多按钮样式，颜色数组和title数组个数不等】<br>
 1.0.0.3、普通的 带 textField 的 UIAlertController-alert，可添加一个或者多个 textField<br>
 1.0.0.4、NSMutableAttributedString 的UIAlertController-alert，可以自由设置 NSMutableAttributedString（title、message）按钮数量、按钮颜色<br>
 1.0.0.5、普通的 UIAlertController-actionSheet，可以自由设置按钮数量、按钮颜色<br>
 1.0.0.6、NSMutableAttributedString 的UIAlertController-actionSheet，可以自由设置 NSMutableAttributedString（title、message）按钮数量、按钮颜色<br>
 1.0.0.7、完美适配 iPhone 和 iPad 版本<br>
 1.0.0.8、理论完全兼容现有 iOS 8 以上系统版本<br>

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
> 感谢 BAHome 团队成员倾力合作，后期会推出一系列 常用 UI 控件的封装，大家有需求得也可以在 issue 提出，如果合理，我们会尽快推出新版本！<br>

> BAHome 的发展离不开小伙伴儿的信任与推广，再次感谢各位小伙伴儿的支持！

