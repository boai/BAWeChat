# BAGridView
[![BAHome Team Name](https://img.shields.io/badge/Team-BAHome-brightgreen.svg?style=flat)](https://github.com/BAHome "BAHome Team")
![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/cocoapods/v/BAGridView.svg?style=flat) ![](https://img.shields.io/cocoapods/dt/BAGridView.svg
)  [![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123)

## 1、功能及简介
* 1、支付宝首页 九宫格 布局封装<br>
* 2、自适应按钮位置和数量<br>
* 3、自定义文字图片 或者 两行文字样式<br>
* 4、自定义分割线：显示/隐藏<br>
* 5、自定义分割线：颜色<br>
* 6、新增 支持 自定义 图片文字间距功能（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>
* 7、新增 自定义 所有文字字体（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>
* 8、新增 支持 自定义 item 背景颜色 和 选中背景颜色（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>

## 2、图片示例
![BAGridView1](https://github.com/BAHome/BAGridView/blob/master/Images/BAGridView1.png)
![BAGridView2](https://github.com/BAHome/BAGridView/blob/master/Images/BAGridView2.png)

## 3、安装、导入示例和源码地址
* 1、pod 导入【最新版本：![](https://img.shields.io/cocoapods/v/BAGridView.svg?style=flat)】： <br>
 `pod 'BAGridView'` <br>
如果发现 `pod search BAGridView` 搜索出来的不是最新版本，需要在终端执行 cd 转换文件路径命令退回到 desktop，然后执行 `pod setup` 命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了。<br>
具体步骤：
  - pod setup : 初始化
  - pod repo update : 更新仓库
  - pod search BAGridView
* 2、文件夹拖入：下载demo，把 BAGridView 文件夹拖入项目即可，<br>
* 3、导入头文件：<br>
`  #import "BAKit_BAGridView.h" `<br>
* 4、项目源码地址：<br>
 OC 版 ：[https://github.com/BAHome/BAGridView](https://github.com/BAHome/BAGridView)<br>

## 4、BAGridView 的类结构及 demo 示例
![BAGridView](https://github.com/BAHome/BAGridView/blob/master/Images/BAGridView.png)

### BAKit_BAGridView.h
```
#ifndef BAKit_BAGridView_h
#define BAKit_BAGridView_h

#import "BAGridView.h"
#import "BAGridItemModel.h"
#import "BAKit_ConfigurationDefine.h"


/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BAGridView
 
 最新更新时间：2017-06-23 【倒叙】
 最新Version：【Version：1.0.5】
 更新内容：
 1.0.5.1、优化部分宏定义
 
 最新更新时间：2017-06-23 【倒叙】
 最新Version：【Version：1.0.4】
 更新内容：
 1.0.4.1、优化部分宏定义
 
 最新更新时间：2017-06-23 【倒叙】<br>
 最新Version：【Version：1.0.3】<br>
 更新内容：<br>
 1.0.3.1、新增 支持 自定义 item 选中改变颜色后自动还原背景颜色（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>
 
 最新更新时间：2017-06-21 【倒叙】<br>
 最新Version：【Version：1.0.2】<br>
 更新内容：<br>
 1.0.2.1、新增 支持 自定义 item 背景颜色 和 选中背景颜色（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>
 
 最新更新时间：2017-06-21 【倒叙】<br>
 最新Version：【Version：1.0.1】<br>
 更新内容：<br>
 1.0.1.1、新增 支持 自定义 图片文字间距功能（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>
 1.0.1.2、新增 自定义 所有文字字体（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>
 
 最新更新时间：2017-06-20 【倒叙】<br>
 最新Version：【Version：1.0.0】<br>
 更新内容：<br>
 1.0.0.1、支付宝首页 九宫格 布局封装<br>
 1.0.0.2、自适应按钮位置和数量<br>
 1.0.0.3、自定义文字图片 或者 两行文字样式<br>
 1.0.0.4、自定义分割线：显示/隐藏<br>
 1.0.0.5、自定义分割线：颜色<br>
 
 */

#endif /* BAKit_BAGridView_h */

```

### BAGridView.h
```
#import <UIKit/UIKit.h>

@class BAGridItemModel, BAGridView;

/**
 宫格样式

 - BAGridViewTypeImageTitle: 上面是图片，下面是文字
 - BAGridViewTypeTitleDesc: 上下都是文字，上面标题字体大，下面是详情字体小
 */
typedef NS_ENUM(NSUInteger, BAGridViewType) {
    BAGridViewTypeImageTitle = 0,
    BAGridViewTypeTitleDesc
};

/**
 BAGridView 回调

 @param model 返回 BAGridItemModel
 @param indexPath indexPath
 */
typedef void (^BAGridViewBlock)(BAGridItemModel *model, NSIndexPath *indexPath);

/**
 BAGridView 配置回调

 @param tempView BAGridView
 */
typedef void (^BAGridView_configurationBlock)(BAGridView *tempView);

@interface BAGridView : UIView

/**
 宫格样式，默认：BAGridViewTypeImageTitle
 */
@property(nonatomic, assign) BAGridViewType gridViewType;

/**
 数据源：来自 BAGridItemModel
 */
@property(nonatomic, strong) NSArray <BAGridItemModel *>*dataArray;

/**
 item：点击回调
 */
@property(nonatomic, copy)   BAGridViewBlock ba_gridViewBlock;

/**
 item：高度，图片高度 默认：ba_gridView_itemHeight * 0.4
 */
@property(nonatomic, assign) CGFloat ba_gridView_itemHeight;

/**
 item：图片与文字间距（或者两行文字类型的间距），默认：0
 */
@property(nonatomic, assign) CGFloat ba_gridView_itemImageInset;

/**
 item：每行 item 的个数，默认：4个
 */
@property(nonatomic, assign) NSInteger ba_gridView_rowCount;

/**
 item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
 */
@property(nonatomic, strong) UIColor *ba_gridView_titleColor;

/**
 item：Desc 颜色，默认：BAKit_Color_Gray_9【BAKit_Color_RGB(216, 220, 228)】
 */
@property(nonatomic, strong) UIColor *ba_gridView_titleDescColor;

/**
 item：分割线颜色，默认：BAKit_Color_Gray_10【BAKit_Color_RGB(240, 240, 240)】
 */
@property(nonatomic, strong) UIColor *ba_gridView_lineColor;

/**
 item：背景颜色，默认：BAKit_Color_White
 */
@property(nonatomic, strong) UIColor *ba_gridView_backgroundColor;

/**
 item：背景选中颜色，默认：无色
 */
@property(nonatomic, strong) UIColor *ba_gridView_selectedBackgroundColor;

/**
 item：是否显示分割线
 */
@property(nonatomic, assign, getter=isShowLineView) BOOL showLineView;

/**
 item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
 */
@property(nonatomic, strong) UIFont *ba_gridView_titleFont;

/**
 item：Desc Font，默认：两行文字下 12
 */
@property(nonatomic, strong) UIFont *ba_gridView_titleDescFont;

/**
 快速创建宫格

 @param gridViewType 样式
 @param dataArray 数据
 @param configurationBlock 配置回调
 @param block 点击事件回调
 @return BAGridView
 */
+ (instancetype)ba_creatGridViewWithGridViewType:(BAGridViewType)gridViewType
                                       dataArray:(NSArray <BAGridItemModel *>*)dataArray
                              configurationBlock:(BAGridView_configurationBlock)configurationBlock
                                           block:(BAGridViewBlock)block;

@end

```

### demo 示例
```
// 示例1：
- (BAGridView *)gridView
{
    if (!_gridView)
    {
        _gridView = [BAGridView ba_creatGridViewWithGridViewType:BAGridViewTypeImageTitle dataArray:self.gridDataArray configurationBlock:^(BAGridView *tempView) {
            
            // 是否显示分割线
//            tempView.showLineView = NO;
            // item：分割线颜色，默认：BAKit_Color_Gray_11【BAKit_Color_RGB(248, 248, 248)】
//            tempView.ba_gridView_lineColor = BAKit_Color_Red;
            // item：每行 item 的个数，默认为4个
            tempView.ba_gridView_rowCount = kGridView_rowCount;
            // item：高度
            tempView.ba_gridView_itemHeight = kGridView_itemHeight;
            // item：图片与文字间距（或者两行文字类型的间距），默认：0
//            tempView.ba_gridView_itemImageInset = 10;
            //  item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
//            tempView.ba_gridView_titleColor = BAKit_Color_Black;
            // item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
            tempView.ba_gridView_titleFont = [UIFont boldSystemFontOfSize:15];
            // item：背景颜色，默认：BAKit_Color_White
            tempView.ba_gridView_backgroundColor = BAKit_Color_White;
            // item：背景选中颜色，默认：无色
            tempView.ba_gridView_selectedBackgroundColor = BAKit_Color_Red;
            
            self.gridView = tempView;
            
        } block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
            
            BAKit_ShowAlertWithMsg_ios8(model.titleString);
        }];
        _gridView.backgroundColor = BAKit_Color_White;
    }
    return _gridView;
}

- (NSMutableArray <BAGridItemModel *> *)gridDataArray
{
    if (!_gridDataArray)
    {
        _gridDataArray = @[].mutableCopy;
        
        NSArray *imageNameArray = @[@"tabbar_mainframeHL", @"tabbar_mainframeHL", @"tabbar_mainframeHL", @"tabbar_mainframeHL", @"tabbar_mainframeHL"];
        NSArray *titleArray = @[@"扫一扫", @"付钱", @"卡包", @"收银", @"卡包"];
        
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            BAGridItemModel *model = [BAGridItemModel new];
            model.imageName = imageNameArray[i];
            model.titleString = titleArray[i];
            
            [self.gridDataArray addObject:model];
        }
    }
    return _gridDataArray;
}
    
    
// 示例2：
- (BAGridView *)gridView2
{
    if (!_gridView2)
    {
        _gridView2 = [BAGridView ba_creatGridViewWithGridViewType:BAGridViewTypeTitleDesc dataArray:self.gridDataArray2 configurationBlock:^(BAGridView *tempView) {
                                                            
            // item：分割线颜色，默认：BAKit_Color_Gray_11【BAKit_Color_RGB(248, 248, 248)】
            tempView.ba_gridView_lineColor = BAKit_Color_Red;
            // item：每行 item 的个数，默认为4个
            tempView.ba_gridView_rowCount = kGridView_rowCount2;
            // item：高度
            tempView.ba_gridView_itemHeight = kGridView_itemHeight2;
            // item：图片与文字间距（或者两行文字类型的间距），默认：0
//            tempView.ba_gridView_itemImageInset = 10;
            //  item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
            tempView.ba_gridView_titleColor = BAKit_Color_Black;
            //  item：Desc 颜色，默认：BAKit_Color_Gray_9【BAKit_Color_RGB(216, 220, 228)】
            tempView.ba_gridView_titleDescColor = BAKit_Color_Gray_7;
            // item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
            tempView.ba_gridView_titleFont = [UIFont boldSystemFontOfSize:25];
            // item：Desc Font，默认：两行文字下 12
            tempView.ba_gridView_titleDescFont = [UIFont boldSystemFontOfSize:15];

            self.gridView2 = tempView;

        } block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
            
            BAKit_ShowAlertWithMsg_ios8(model.titleString);
        }];
        _gridView2.backgroundColor = [UIColor yellowColor];
    }
    return _gridView2;
}

- (NSMutableArray <BAGridItemModel *> *)gridDataArray2
{
    if (!_gridDataArray2)
    {
        _gridDataArray2 = @[].mutableCopy;
        
        NSArray *titleArray = @[@"200", @"20", @"200", @"10", ];
        NSArray *descArray = @[@"新增积分总量", @"返还积分总量", @"全返单元总量", @"每单元返还积分"];
        
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            BAGridItemModel *model = [BAGridItemModel new];
            model.desc = descArray[i];
            model.titleString = titleArray[i];
            
            [_gridDataArray2 addObject:model];
        }
    }
    return _gridDataArray2;
}

其他示例可下载demo查看源码！
```

## 5、更新记录：【倒叙】
 欢迎使用 [【BAHome】](https://github.com/BAHome) 系列开源代码 ！
 如有更多需求，请前往：[【https://github.com/BAHome】](https://github.com/BAHome) 
 
 最新更新时间：2017-06-23 【倒叙】
 最新Version：【Version：1.0.5】
 更新内容：
 1.0.5.1、优化部分宏定义
 
 最新更新时间：2017-06-23 【倒叙】
 最新Version：【Version：1.0.4】
 更新内容：
 1.0.4.1、优化部分宏定义
 
 最新更新时间：2017-06-23 【倒叙】<br>
 最新Version：【Version：1.0.3】<br>
 更新内容：<br>
 1.0.3.1、新增 支持 自定义 item 选中改变颜色后自动还原背景颜色（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>
 
 最新更新时间：2017-06-21 【倒叙】<br>
 最新Version：【Version：1.0.1】<br>
 更新内容：<br>
 1.0.1.1、新增 支持 自定义 图片文字间距功能（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>
  1.0.1.2、新增 自定义 所有文字字体（感谢群里 [@武汉-马阿飞](http://www.jianshu.com/u/7f8b1720f857) 同学提出的 需求！）<br>
 
 最新更新时间：2017-06-20 【倒叙】<br>
 最新Version：【Version：1.0.0】<br>
 更新内容：<br>
 1.0.0.1、支付宝首页 九宫格 布局封装<br>
 1.0.0.2、自适应按钮位置和数量<br>
 1.0.0.3、自定义文字图片 或者 两行文字样式<br>
 1.0.0.4、自定义分割线：显示/隐藏<br>
 1.0.0.5、自定义分割线：颜色<br>

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

