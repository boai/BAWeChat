# BAAlert

[![BAHome Team Name](https://img.shields.io/badge/Team-BAHome-brightgreen.svg?style=flat)](https://github.com/BAHome "BAHome Team")
[![CI Status](https://img.shields.io/travis/boai/BAAlert.svg?style=flat)](https://travis-ci.org/boai/BAAlert)
[![Version](https://img.shields.io/cocoapods/v/BAAlert.svg?style=flat)](https://cocoapods.org/pods/BAAlert)
[![License](https://img.shields.io/cocoapods/l/BAAlert.svg?style=flat)](https://cocoapods.org/pods/BAAlert)
[![Platform](https://img.shields.io/cocoapods/p/BAAlert.svg?style=flat)](https://cocoapods.org/pods/BAAlert)
 [![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123)
 
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BAAlert is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BAAlert'
```

## Author

boai, sunboyan@outlook.com

## License

BAAlert is available under the MIT license. See the LICENSE file for more info.

## 1、功能及简介
* 1、手势触摸隐藏开关，可随时开关 <br>
* 2、可以自定义背景图片、背景颜色、按钮颜色
* 3、可以添加文字和图片，且可以滑动查看！
* 4、横竖屏适配完美
* 5、有各种炫酷动画展示你的 alert
* 6、可以自定义每个按钮颜色

## 2、图片示例
![BAAlert1.gif](https://github.com/BAHome/BAAlert/blob/master/Images/BAAlert1.gif)
![BAAlert2.gif](https://github.com/BAHome/BAAlert/blob/master/Images/BAAlert2.gif)

## 3、安装、导入示例和源码地址
* 1、pod 导入【最新版本：![](https://img.shields.io/cocoapods/v/BAAlert.svg?style=flat) ![](https://img.shields.io/cocoapods/dt/BAAlert.svg
)】： <br>
`pod 'BAAlert'` ` pod 'BAAlert-Swift'`  <br>
如果发现 `pod search BAAlert` 搜索出来的不是最新版本，需要在终端执行 cd 转换文件路径命令退回到 desktop，然后执行 `pod setup` 命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了。<br>
具体步骤：
- pod setup : 初始化
- pod repo update : 更新仓库
- pod search BAAlert
* 2、文件夹拖入：下载demo，把 BAAlert 文件夹拖入项目即可，<br>
* 3、导入头文件：<br>
`  #import "BAAlert_OC.h" `<br>
* 4、项目源码地址：<br>
OC 版 ：[https://github.com/BAHome/BAAlert](https://github.com/BAHome/BAAlert)<br>
swift 版 ：[https://github.com/BAHome/BAAlert-Swift](https://github.com/BAHome/BAAlert-Swift)<br>
系统原生 UIAlertController 分类封装：[https://github.com/BAHome/BAAlertController](https://github.com/BAHome/BAAlertController)

## 4、BAAlert 的类结构及 demo 示例
![BAAlert.png](https://github.com/BAHome/BAAlert/blob/master/Images/BAAlert.png)

### BAAlert_OC.h
```
#ifndef BAAlert_OC_h
#define BAAlert_OC_h

#import "BAAlert.h"
#import "BAActionSheet.h"
#import "BAKit_ConfigurationDefine.h"
#import "CALayer+BAAnimation.h"
#import "UIView+BAAnimation.h"
#import "NSBundle+BAPod.h"

#endif /* BAAlert_OC_h */
```

### BAAlert.h
```
#import <UIKit/UIKit.h>
#import "BAAlert_Config.h"

@class BAAlert;

typedef void(^BAAlert_ConfigBlock)(BAAlert *tempView);

@interface BAAlert : UIView

/*! 背景颜色 默认：半透明*/
@property (nonatomic, strong) UIColor *bgColor;

/*! 是否开启边缘触摸隐藏 alert 默认：NO */
@property (nonatomic, assign) BOOL isTouchEdgeHide;

/*! 背景图片名字 默认：没有图片*/
@property (nonatomic, strong) NSString *bgImageName;

/*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
@property (nonatomic, assign, getter=isShowAnimate) BOOL showAnimate;

/*! 进出场动画枚举 默认：1 ，并且默认开启动画开关 */
@property (nonatomic, assign) BAAlertAnimatingStyle animatingStyle;

/*! 背景高斯模糊枚举 默认：没有模糊效果 */
@property (nonatomic, assign) BAAlertBlurEffectStyle blurEffectStyle;

/*! 是否需要开启键盘自适应 默认：NO，注意：如果用了第三方键盘适配的话，可以将此属性设置为 NO！以免冲突 */
@property(nonatomic, assign) BOOL isNeedAutoKeyboardFrame;

/*! 进场动画持续时间 默认：0.5f */
@property (nonatomic, assign) double startAnimationDuration;

/*! 出场动画持续时间 默认：0.5f */
@property (nonatomic, assign) double endAnimationDuration;


/*!
*  创建一个完全自定义的 alertView
*
*  @param customView    自定义 View
*  @param configuration 属性配置：如 bgColor、buttonTitleColor、isTouchEdgeHide...
*/
+ (void)ba_alertShowCustomView:(UIView *)customView
configuration:(BAAlert_ConfigBlock) configuration;

/*!
*  创建一个类似于系统的alert
*
*  @param title         标题：可空
*  @param message       消息内容：可空
*  @param image         图片：可空
*  @param buttonTitleArray  按钮标题：不可空
*  @param buttonTitleColorArray  按钮标题颜色：可空，默认蓝色
*  @param configuration 属性配置：如 bgColor、buttonTitleColor、isTouchEdgeHide...
*  @param actionBlock        按钮的点击事件处理
*/
+ (void)ba_alertShowWithTitle:(NSString *)title
message:(NSString *)message
image:(UIImage *)image
buttonTitleArray:(NSArray <NSString *>*)buttonTitleArray
buttonTitleColorArray:(NSArray <UIColor *>*)buttonTitleColorArray
configuration:(BAAlert_ConfigBlock)configuration
actionBlock:(BAAlert_ButtonActionBlock)actionBlock;

/*!
*  视图消失
*/
- (void)ba_alertHidden;

@end
```

### BAActionSheet.h
```
#import <UIKit/UIKit.h>
#import "BAAlert_Config.h"

@class BAActionSheet, BAActionSheetModel;

typedef void(^BAActionSheet_ConfigBlock)(BAActionSheet *tempView);
typedef void (^BAActionSheet_ActionBlock)(NSIndexPath *indexPath, BAActionSheetModel *model);


@interface BAActionSheet : UIView

/*! 是否开启边缘触摸隐藏 alert 默认：YES */
@property (nonatomic, assign) BOOL isTouchEdgeHide;

/*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
@property (nonatomic, assign, getter=isShowAnimate) BOOL showAnimate;

/*! 进出场动画枚举 默认：1 ，并且默认开启动画开关 */
@property (nonatomic, assign) BAAlertAnimatingStyle animatingStyle;

/*! BAActionSheet 类型，默认：1 */
@property (nonatomic, assign) BAActionSheetType actionSheetType;

@property (nonatomic, strong) NSArray <BAActionSheetModel *>*dataArray;
@property (nonatomic, strong) NSString *title;

/*!
*
*  @param configuration 属性配置：如 bgColor、buttonTitleColor、isTouchEdgeHide...
*  @param actionBlock   block回调点击的选项
*/
+ (void)ba_actionSheetShowWithConfiguration:(BAActionSheet_ConfigBlock)configuration
actionBlock:(BAActionSheet_ActionBlock)actionBlock;

/*!
*  隐藏 BAActionSheet
*/
- (void)ba_actionSheetHidden;

@end

@class BAActionSheetSubContentModel;
@interface BAActionSheetModel : NSObject

@property(nonatomic, copy) NSString *imageUrl;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *subContent;
@property(nonatomic, strong) NSArray <BAActionSheetSubContentModel *>*subContentArray;

@end

@interface BAActionSheetSubContentModel : NSObject

@property(nonatomic, copy) NSString *subContent;

@end
```
### demo 示例
```
- (void)actionSheet1
{
NSMutableArray *dataArray = [NSMutableArray array];
NSArray *contentArray = @[@"微信支付", @"支付宝", @"预付款账户"];
NSArray *subContentArray = @[@"", @"18588888888", @"余额：￥480.00"];
NSArray *imageArray = @[@"123.png", @"背景.jpg", @"美女.jpg"];

for (NSInteger i = 0; i < contentArray.count; i++)
{
BAActionSheetModel *model = [BAActionSheetModel new];
model.imageUrl = imageArray[i];
model.content = contentArray[i];
model.subContent = subContentArray[i];

[dataArray addObject:model];
}
BAKit_WeakSelf
[BAActionSheet ba_actionSheetShowWithConfiguration:^(BAActionSheet *tempView) {

BAKit_StrongSelf
tempView.title = @"支付方式";
tempView.dataArray = dataArray;
tempView.isTouchEdgeHide = NO;
tempView.showAnimate = YES;

self.actionSheet = tempView;
} actionBlock:^(NSIndexPath *indexPath, BAActionSheetModel *model) {
BAKit_ShowAlertWithMsg_ios8(model.content);
}];
}

- (void)actionSheet2
{
NSMutableArray *dataArray = [NSMutableArray array];
NSArray *contentArray = @[@"微信支付", @"支付宝", @"预付款账户"];

for (NSInteger i = 0; i < contentArray.count; i++)
{
BAActionSheetModel *model = [BAActionSheetModel new];
//        model.imageUrl = imageArray[i];
model.content = contentArray[i];
//        model.subContent = subContentArray[i];

[dataArray addObject:model];
}
BAKit_WeakSelf
[BAActionSheet ba_actionSheetShowWithConfiguration:^(BAActionSheet *tempView) {

BAKit_StrongSelf
//        tempView.title = @"支付方式";
tempView.dataArray = dataArray;
tempView.actionSheetType = BAActionSheetTypeCustom;
//        tempView.isTouchEdgeHide = NO;

self.actionSheet = tempView;
} actionBlock:^(NSIndexPath *indexPath, BAActionSheetModel *model) {
BAKit_ShowAlertWithMsg_ios8(model.content);
}];
}

- (void)actionSheet3
{
NSArray *contentArray = @[@"微信支付", @"支付宝", @"预付款账户", @"中行"];
NSArray <NSArray *>*subContentArray = @[
@[@"微信支付1", @"微信支付2", @"微信支付3"],
@[@"支付宝1", @"支付宝2", @"支付宝3", @"支付宝4"],
@[],
@[@"中行1", @"中行2", @"中行3", @"中行4", @"中行5", @"中行6", @"中行7", @"中行2", @"中行3", @"中行4", @"中行5", @"中行6", @"中行7", @"中行2", @"中行3", @"中行4", @"中行5", @"中行6", @"中行7", @"中行2", @"中行3", @"中行4", @"中行5", @"中行6", @"中行7"]
];

NSMutableArray *dataArray = @[].mutableCopy;
for (NSInteger i = 0; i < contentArray.count; i++)
{
BAActionSheetModel *model = [BAActionSheetModel new];
model.content = contentArray[i];

NSMutableArray *mutArray = @[].mutableCopy;
for (NSInteger j = 0; j < subContentArray[i].count; j ++)
{
BAActionSheetSubContentModel *subContentModel = [BAActionSheetSubContentModel new];
subContentModel.subContent = subContentArray[i][j];
[mutArray addObject:subContentModel];
}
model.subContentArray = mutArray;

[dataArray addObject:model];
}

BAKit_WeakSelf
[BAActionSheet ba_actionSheetShowWithConfiguration:^(BAActionSheet *tempView) {

BAKit_StrongSelf
tempView.title = @"支付方式";
tempView.dataArray = dataArray;
tempView.actionSheetType = BAActionSheetTypeExpand;
//        tempView.isTouchEdgeHide = NO;

self.actionSheet = tempView;
} actionBlock:^(NSIndexPath *indexPath, BAActionSheetModel *model) {
if (model.subContentArray.count > 0)
{
BAKit_ShowAlertWithMsg_ios8(model.subContentArray[indexPath.row].subContent);
}
else
{
BAKit_ShowAlertWithMsg_ios8(model.content);
}
}];
}


- (void)alert1
{
BAKit_WeakSelf
/*! 第一种封装使用示例 */
[BAAlert ba_alertShowWithTitle:title0 message:titleMsg0 image:nil buttonTitleArray:@[@"取消",@"确定",@"确定2",@"确定3"] buttonTitleColorArray:@[[UIColor greenColor], [UIColor redColor], [UIColor grayColor], [UIColor purpleColor]] configuration:^(BAAlert *tempView) {
BAKit_StrongSelf
//        temp.bgColor       = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.3];
/*! 开启边缘触摸隐藏alertView */
tempView.isTouchEdgeHide = YES;
/*! 添加高斯模糊的样式 */
tempView.blurEffectStyle = BAAlertBlurEffectStyleLight;
/*! 开启动画 */
tempView.showAnimate   = YES;
//        /*! 进出场动画样式 默认为：1 */
//        tempView.animatingStyle  = 1;
self.alertView1 = tempView;
} actionBlock:^(NSInteger index) {
BAKit_StrongSelf
[self.alertView1 ba_alertHidden];
if (index == 1)
{
NSLog(@"点击了确定按钮！");
ViewController2 *vc2 = [ViewController2 new];
vc2.title = @"alert1";
[self.navigationController pushViewController:vc2 animated:YES];
}
}];
}

- (void)alert2
{
//    /*! 2、自定义按钮颜色 */
BAKit_WeakSelf
[BAAlert ba_alertShowWithTitle:@"温馨提示：" message:titleMsg2 image:nil buttonTitleArray:@[@"取消", @"跳转VC2"] buttonTitleColorArray:@[[UIColor greenColor], [UIColor redColor]] configuration:^(BAAlert *tempView) {
BAKit_StrongSelf
/*! 自定义按钮文字颜色 */
//    tempView.buttonTitleColor = [UIColor orangeColor];
tempView.bgColor = [UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:0.3];
tempView.isTouchEdgeHide = YES;

/*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
tempView.showAnimate = YES;
tempView.animatingStyle  = BAAlertAnimatingStyleShake;

self.alertView2 = tempView;

} actionBlock:^(NSInteger index) {
BAKit_StrongSelf
[self.alertView2 ba_alertHidden];
if (index == 0)
{
NSLog(@"点击了取消按钮！");
}
else if (index == 1)
{
NSLog(@"点击了确定按钮！");
ViewController2 *vc2 = [ViewController2 new];
vc2.title = @"alert2";
[self.navigationController pushViewController:vc2 animated:YES];
}
}];
}

- (void)alert3
{
/*! 3、自定义背景图片 */
BAKit_WeakSelf
[BAAlert ba_alertShowWithTitle:@"温馨提示：" message:titleMsg1 image:nil buttonTitleArray:@[@"取消", @"确定"] buttonTitleColorArray:@[[UIColor greenColor], [UIColor redColor]] configuration:^(BAAlert *tempView) {
BAKit_StrongSelf
/*! 自定义按钮文字颜色 */
//    tempView.buttonTitleColor = [UIColor orangeColor];
/*! 自定义alert的背景图片 */
tempView.bgImageName      = @"背景.jpg";
/*! 开启动画，并且设置动画样式，默认：1 */
//        tempView.showAnimate = YES;

/*! 没有开启动画，直接进出场动画样式，默认开启动画 */
tempView.animatingStyle  = BAAlertAnimatingStyleFall;

self.alertView3 = tempView;
} actionBlock:^(NSInteger index) {
BAKit_StrongSelf
[self.alertView3 ba_alertHidden];
if (index == 0)
{
NSLog(@"点击了取消按钮！");
}
else if (index == 1)
{
NSLog(@"点击了确定按钮！");
ViewController2 *vc2 = [ViewController2 new];
vc2.title = @"alert3";
[self.navigationController pushViewController:vc2 animated:YES];
}
}];
}

- (void)alert4
{
/*! 4、内置图片和文字，可滑动查看 */
BAKit_WeakSelf
[BAAlert ba_alertShowWithTitle:@"温馨提示：" message:titleMsg1 image:[UIImage imageNamed:@"美女.jpg"] buttonTitleArray:@[@"取消", @"跳转VC2"] buttonTitleColorArray:@[[UIColor greenColor], [UIColor redColor]] configuration:^(BAAlert *tempView) {
BAKit_StrongSelf
/*! 自定义按钮文字颜色 */
//    tempView.buttonTitleColor = [UIColor orangeColor];
/*! 自定义alert的背景图片 */
tempView.bgImageName = @"背景.jpg";
/*! 是否显示动画效果 */
tempView.showAnimate = YES;
self.alertView4 = tempView;
} actionBlock:^(NSInteger index) {
BAKit_StrongSelf
[self.alertView4 ba_alertHidden];
if (index == 0)
{
NSLog(@"点击了取消按钮！");
}
else if (index == 1)
{
NSLog(@"点击了确定按钮！");
ViewController2 *vc2 = [ViewController2 new];
vc2.title = @"alert4";
[self.navigationController pushViewController:vc2 animated:YES];
}
}];
}

- (void)alert5
{
/*! 5、完全自定义alert，注意：此处不能使用懒加载创建自定义的 view，只能每次弹出都创建，以免第二次弹出不显示，因为 alert 在消失的时候，会将 自定义的 view 全部移除！ */
_customView = [CustomView new];
self.customView.frame = CGRectMake(50, BAKit_SCREEN_HEIGHT - 200, BAKit_SCREEN_WIDTH - 50 * 2, 162);
//    设置居中
//    self.customView.center = self.view.center;
/*! 使用 BAAlert 弹出自定义View  */
BAKit_WeakSelf
[BAAlert ba_alertShowCustomView:self.customView configuration:^(BAAlert *tempView) {

BAKit_StrongSelf
tempView.isTouchEdgeHide = NO;
/*! 是否需要开启键盘自适应 默认：NO，注意：如果用了第三方键盘适配的话，可以将此属性设置为 NO！以免冲突 */
tempView.isNeedAutoKeyboardFrame = NO;
tempView.animatingStyle = BAAlertAnimatingStyleScale;
self.alertView5 = tempView;
}];

self.customView.block = ^(NSInteger index) {
BAKit_StrongSelf
if (index == 1)
{
[self.alertView5 ba_alertHidden];
}
};
}

其他示例可下载demo查看源码！
```

## 5、更新记录：【倒叙】
欢迎使用 [【BAHome】](https://github.com/BAHome) 系列开源代码 ！
如有更多需求，请前往：[【https://github.com/BAHome】](https://github.com/BAHome) 

最新更新时间：2018-11-15 【倒叙】 <br>
最新Version：【Version：1.2.7】 <br>
更新内容： <br>
1.2.7.1、官方 pod 标准版本 demo 全新适配，支持本地调试 <br>
1.2.7.2、公开 `#import "UIView+BAAnimation.h"` 文件 <br>

最新更新时间：2018-04-12 【倒叙】 <br>
最新Version：【Version：1.2.6】 <br>
更新内容： <br>
1.2.6.1、新增 进场动画持续时间 默认：0.5f (startAnimationDuration/endAnimationDuration) <br>
1.2.6.2、优化部分动画封装<br>

最新更新时间：2017-10-30 【倒叙】 <br>
最新Version：【Version：1.2.5】 <br>
更新内容： <br>
1.2.5.1、修复 isTouchEdgeHide 属性设置为 NO 的时候，无效的bug（感谢群里 [@北京-菲菲] 同学提出的 bug！）<br>
1.2.5.2、修复 键盘弹出的时候，点击背景隐藏 alert 的时候，键盘偶尔消失不了的bug（感谢群里 [@广州-王培] 同学提出的 bug！）<br>
1.2.5.3、新增 isNeedAutoKeyboardFrame 属性，是否需要开启键盘自适应 默认：NO，注意：如果用了第三方键盘适配的话，可以将此属性设置为 NO！以免冲突<br>

最新更新时间：2017-08-21 【倒叙】 <br>
最新Version：【Version：1.2.4】 <br>
更新内容： <br>
1.2.4.1、修复 自定义背景图片不显示的问题（感谢群里 [@北京-邵峰] 同学提出的 bug！）<br>

最新更新时间：2017-08-18 【倒叙】 <br>
最新Version：【Version：1.2.3】 <br>
更新内容： <br>
1.2.3.1、优化自定义 alert 的布局，横竖屏可以适配了！ <br>

最新更新时间：2017-06-23 【倒叙】 <br>
最新Version：【Version：1.2.2】 <br>
更新内容： <br>
1.2.2.1、优化部分宏定义 <br>

最新更新时间：2017-05-20 【倒叙】 <br>
最新Version：【Version：1.1.9】 <br>
更新内容： <br>
1.1.9.1、修复动画过度白屏问题  <br>

最新更新时间：2017-05-15 【倒叙】 <br>
最新Version：【Version：1.1.8】 <br>
更新内容： <br>
1.1.8.1、精简代码结构，删除多余或者重复代码  <br>
1.1.8.2、规范代码属性和方法命名，原有方法名和属性名有较大改动，忘见谅  <br>
1.1.8.3、重构 actionSheet，新增多种样式  <br>

最新更新时间：2017-05-13 【倒叙】 <br>
最新Version：【Version：1.1.7】 <br>
更新内容： <br>
1.1.7.1、精简代码结构，删除多余或者重复代码  <br>
1.1.7.2、规范代码属性和方法命名，原有方法名和属性名有较大改动，忘见谅  <br>
1.1.7.3、优化部分动画  <br>
1.1.7.4、subView 布局优化  <br>
1.1.7.5、actionSheet 新增自定义文字颜色、title 字体颜色  <br>

最新更新时间：2017-05-10 【倒叙】 <br>
最新Version：【Version：1.1.5】 <br>
更新内容： <br>
1.1.5.1、删除原有封装内部按钮点击事件中 ba_dismissAlertView 方法，此方法可在外部自由调用  <br>

最新更新时间：2017-05-09 【倒叙】 <br>
最新Version：【Version：1.1.4】 <br>
更新内容： <br>
1.1.4.1、pod 更新xib 文件 <br>

最新更新时间：2017-05-08 【倒叙】
最新Version：【Version：1.1.0】
更新内容：
1.1.0.1、优化方法名命名规范
1.1.0.2、新增键盘内部处理
1.1.0.3、用原生 autoLayout 重构，自定义 alert 的布局再也不是问题了
1.1.0.4、优化代码结构，修复内在隐藏内存泄漏
1.1.0.5、新增 BAAlert_OC.h 文件，只需导入 BAAlert_OC.h 一个文件就可以使用 alert 和 actionSheet 了
1.1.0.6、删除了部分代码和属性，具体见源码 和 demo

## 6、bug 反馈
> 1、开发中遇到 bug，希望小伙伴儿们能够及时反馈与我们 [【BAHome】](https://github.com/BAHome) 团队，我们必定会认真对待每一个问题！ <br>

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
> 感谢 [【BAHome】](https://github.com/BAHome)  团队成员倾力合作，后期会推出一系列 常用 UI 控件的封装，大家有需求得也可以在 issue 提出，如果合理，我们会尽快推出新版本！<br>

> [【BAHome】](https://github.com/BAHome)  的发展离不开小伙伴儿的信任与推广，再次感谢各位小伙伴儿的支持！

