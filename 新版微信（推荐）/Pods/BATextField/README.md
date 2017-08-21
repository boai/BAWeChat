# BATextField
[![BAHome Team Name](https://img.shields.io/badge/Team-BAHome-brightgreen.svg?style=flat)](https://github.com/BAHome "BAHome Team")
![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/cocoapods/v/BATextField.svg?style=flat) ![](https://img.shields.io/cocoapods/dt/BATextField.svg
)  [![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123)

## 1、功能及简介
* 1、用分类封装 UITextField，代码无任何侵入更改 <br>
* 2、用 block 方式实现所需代理回调，更加方便，代码更简洁
* 3、一个属性搞定 最大长度限制
* 4、一个属性搞定 placeholder 字体、字体颜色
* 5、一行代码搞定 输入的内容是否为空
* 6、一行代码搞定 选中所有文字、选中指定范围的文字
* 7、一行代码搞定 输入历史记录

## 2、图片示例
![BATextField](https://github.com/BAHome/BATextField/blob/master/Images/BATextField.gif)

## 3、安装、导入示例和源码地址
* 1、pod 导入【最新版本：![](https://img.shields.io/cocoapods/v/BATextField.svg?style=flat)】： <br>
 `pod 'BATextField'` <br>
如果发现 `pod search BATextField` 搜索出来的不是最新版本，需要在终端执行 cd 转换文件路径命令退回到 desktop，然后执行 `pod setup` 命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了。<br>
具体步骤：
  - pod setup : 初始化
  - pod repo update : 更新仓库
  - pod search BATextField
* 2、文件夹拖入：下载demo，把 BATextField 文件夹拖入项目即可，<br>
* 3、导入头文件：<br>
`  #import "BATextField.h" `<br>
* 4、项目源码地址：<br>
 OC 版 ：[https://github.com/BAHome/BATextField](https://github.com/BAHome/BATextField)<br>

## 4、BATextField 的类结构及 demo 示例
![BATextField](https://github.com/BAHome/BATextField/blob/master/Images/BATextField.png)

### BAKit_WebView.h
```
#ifndef BATextField_h
#define BATextField_h

#import "UITextField+BAKit.h"
#import "UITextField+BAHistory.h"
#import "BAKit_ConfigurationDefine.h"
#import "UIView+BAFrame.h"
#import "BAKit_UserDefaults.h"

/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BAWKWebView
 
 最新更新时间：2017-06-24 【倒叙】
 最新Version：【Version：1.0.2】
 更新内容：
 1.0.2.1、优化部分宏定义
 
 最新更新时间：2017-06-23 【倒叙】
 最新Version：【Version：1.0.1】
 更新内容：
 1.0.1.1、优化部分宏定义
 
 最新更新时间：2017-06-17 【倒叙】
 最新Version：【Version：1.0.0】
 更新内容：
 1.0.0.1、用分类封装 UITextField，代码无任何侵入更改
 1.0.0.2、用 block 方式实现所需代理回调，更加方便，代码更简洁
 1.0.0.3、一个属性搞定 最大长度限制
 1.0.0.4、一个属性搞定 placeholder 字体、字体颜色
 1.0.0.5、一行代码搞定 输入的内容是否为空
 1.0.0.6、一行代码搞定 选中所有文字、选中指定范围的文字
 1.0.0.7、一行代码搞定 输入历史记录
 
 */

#endif /* BATextField_h */
```

### UITextField+BAKit.h
```
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UITextField (BAKit)

/**
 placeholder：文字颜色，默认：黑色
 */
@property(nonatomic, strong) UIColor *ba_placeholderColor;

/**
 placeholder：文字字体
 */
@property(nonatomic, strong) UIFont *ba_placeholderFont;

/**
 限制最大输入长度
 */
@property (assign, nonatomic)  NSInteger ba_maxLength;


/**
 判断 UITextField 输入的内容是否为空
 
 @return YES，NO
 */
- (BOOL)ba_textField_isEmpty;

/**
 选中所有文字
 */
- (void)ba_textField_selectAllText;

/**
 当前选中的字符串范围

 @return NSRange
 */
- (NSRange)ba_textField_selectedRange;

/**
 选中指定范围的文字

 @param range NSRange 范围
 */
- (void)ba_textField_setSelectedRange:(NSRange)range;

@end
```

## UITextField+BAHistory.h
```
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
```

### demo 示例
```
// 示例1：
- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [UITextField new];
        _textField.placeholder = @"这里是 placeholder！限制最大位数：6！";
        _textField.backgroundColor = BAKit_Color_Gray_11;
        
        // placeholder：文字颜色
        _textField.ba_placeholderColor = BAKit_Color_Green;
        // placeholder：文字字体
        _textField.ba_placeholderFont = [UIFont systemFontOfSize:11];
        // 限制最大输入长度
        _textField.ba_maxLength = 6;
        
        [self.view addSubview:_textField];
    }
    return _textField;
}
    
// 示例2：加载普通 URL
- (UITextField *)textField1
{
    if (!_textField1)
    {
        _textField1 = [UITextField new];
        _textField1.placeholder = @"点击 return 后，可以保存输入历史！【限制输入11位】";
        _textField1.backgroundColor = BAKit_Color_Gray_11;
        _textField1.delegate = self;
        
        // placeholder：文字颜色，默认：黑色
        _textField1.ba_placeholderColor = BAKit_Color_Orange;
        // placeholder：文字字体
        _textField1.ba_placeholderFont = [UIFont boldSystemFontOfSize:13];
        // 限制最大输入长度
        _textField1.ba_maxLength = 11;
        // textFieldID：识别 ID，要用到历史记录，请务必添加
        _textField1.ba_textFieldID = @"user_account";
        
        // clearButton 标题，默认：清楚历史内容
        _textField1.ba_clearButtonTitle = @"clear";
        // clearButton 标题颜色，默认：[[UIColor blueColor] colorWithAlphaComponent:0.5f]
        _textField1.ba_clearButtonTitleColor = BAKit_Color_Green;
        
        [self.view addSubview:_textField1];
    }
    return _textField1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_textField1 ba_textFieldHistoryArrayHide];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_textField1 == textField)
    {
        // 当开始编辑的时候，显示 历史数据
        [_textField1 ba_textFieldHistoryArrayShow];
        return YES;
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_textField1 == textField)
    {
        // 点击 return，一定要记得 同步数据
        [_textField1 ba_textFieldHistoryArraySynchronize];
        
        // 同步完数据后，记得隐藏 历史数据
        [_textField1 ba_textFieldHistoryArrayHide];
        _textField1.text = nil;
        [_textField1 resignFirstResponder];
        return YES;
    }
    return NO;
}

其他示例可下载 demo 查看源码！
```

## 5、更新记录：【倒叙】
 欢迎使用 [【BAHome】](https://github.com/BAHome) 系列开源代码 ！
 如有更多需求，请前往：[【https://github.com/BAHome】](https://github.com/BAHome) 
 
 最新更新时间：2017-06-24 【倒叙】
 最新Version：【Version：1.0.2】
 更新内容：
 1.0.2.1、优化部分宏定义
 
 最新更新时间：2017-06-23 【倒叙】
 最新Version：【Version：1.0.1】
 更新内容：
 1.0.1.1、优化部分宏定义
 
 最新更新时间：2017-06-17 【倒叙】<br>
 最新Version：【Version：1.0.0】<br>
 更新内容：<br>
 1.0.0.1、用分类封装 UITextField，代码无任何侵入更改<br>
 1.0.0.2、用 block 方式实现所需代理回调，更加方便，代码更简洁<br>
 1.0.0.3、一个属性搞定 最大长度限制<br>
 1.0.0.4、一个属性搞定 placeholder 字体、字体颜色<br>
 1.0.0.5、一行代码搞定 输入的内容是否为空<br>
 1.0.0.6、一行代码搞定 选中所有文字、选中指定范围的文字<br>
 1.0.0.7、一行代码搞定 输入历史记录<br>
 
## 6、bug 反馈 和 联系方式
> 1、开发中遇到 bug，希望小伙伴儿们能够及时反馈与我们 BAHome 团队，我们必定会认真对待每一个问题！ <br>

> 2、以后提需求和 bug 的同学，记得把 git 或者博客链接给我们，我直接超链到你们那里！希望大家积极参与测试！<br> 

> 3、联系方式 <br> 
QQ群：479663605  【注意：此群为 2 元 付费群，介意的小伙伴儿勿扰！】<br> 
博爱QQ：137361770 <br> 
博爱微博：[![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123) <br> 

## 7、开发环境 和 支持版本
> 开发使用 Xcode Version 8.3.2 (8E2002) ，理论上支持所有 iOS 版本，如有版本适配问题，请及时反馈！多谢合作！

## 8、感谢
> 感谢 BAHome 团队成员倾力合作，后期会推出一系列 常用 UI 控件的封装，大家有需求得也可以在 issue 提出，如果合理，我们会尽快推出新版本！<br>

> BAHome 的发展离不开小伙伴儿的信任与推广，再次感谢各位小伙伴儿的支持！

