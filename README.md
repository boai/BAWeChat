# BAWeChat
[![BAHome Team Name](https://img.shields.io/badge/Team-BAHome-brightgreen.svg?style=flat)](https://github.com/BAHome "BAHome Team")
![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
[![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123)

## 1、功能及简介
* 1、博爱微信，使用原生 frame + MVVM + MVC + [『QMUIKit』](https://github.com/QMUI/QMUI_iOS)  + BAKit 开源的微信<br>
* 2、展示图中的 FPS 是模拟器的数据，真机 iPhone 6上最低50， iPhone 7上最低59，基本上都在 58 以上，代码规范，新手学习可以做个参考 
* 3、注意：如果运行报错，请先 执行： `pod setup` 更新下本地的pod spec 库，更新时间漫长，需要耐心等待，然后再 执行：`pod update --verbose --no-repo-update` 更新pod，然后再运行！
* 4、全局使用 原生 frame 布局，完美适配横竖屏
* 5、使用 [『QMUIKit』](https://github.com/QMUI/QMUI_iOS)  框架快速搭建高性能项目框架，含全局配置文件再次封装，小伙伴儿们可以直接使用，无需采坑
* 6、朋友圈，采用 MVVM 框架布局，流畅的不能再流畅
	* 数据全部采用 json 数据
	* model 仿照新浪微博 的数据结构定制
	* 图片全部实现网路图片，png、gif动图，九宫格图片完美封装，使用 YYImage
	* 图片浏览器使用 MWPhotoBrowser 
	* 原文使用 [『MLLabel』](https://github.com/molon/MLLabel) ，实现文字内容解析，URL、电话号码等可以单独处理，详见源码
	* 原文实现微信文字长按复制收藏功能
	* 评论功能动态更新布局
* 7、通讯录，博爱出品，完美封装通讯录中英文混合排序，可以直接使用，代码简洁，一目了然
* 8、搜索，使用 [『QMUIKit』](https://github.com/QMUI/QMUI_iOS)  框架搜索功能，功能强大
* 9、系统通讯录获取并重新定制，使用 [『PPGetAddressBook』](https://github.com/jkpang/PPGetAddressBook) 源码
* 10、博爱自定义键盘的封装，让你的评论、聊天就是这么简单
* 11、各种转场动画封装，详见源码
* 12、各种启动动画封装，详见源码
* 13、网络库使用 [『BANetManager』](https://github.com/BAHome/BANetManager) 
* 14、还有很多功能封装，详见源码 BAKit 

## 2、图片示例
![通讯录.png](https://github.com/boai/BAWeChat/blob/master/Images/通讯录.png)
![搜索.png](https://github.com/boai/BAWeChat/blob/master/Images/搜索.png)
![发现.png](https://github.com/boai/BAWeChat/blob/master/Images/发现.png)
![朋友圈.gif](https://github.com/BAHome/BAWeChat/blob/master/Images/朋友圈.gif)
![评论.png](https://github.com/boai/BAWeChat/blob/master/Images/评论.png)
![图片浏览器.png](https://github.com/boai/BAWeChat/blob/master/Images/图片浏览器.png)
![我.png](https://github.com/boai/BAWeChat/blob/master/Images/我.png)

## 3、安装、导入示例和源码地址
* 1、项目源码地址：<br>
 OC 版 ：[https://github.com/BAHome/BAWeChat](https://github.com/BAHome/BAWeChat)<br>

## 4、BAWeChat 的类结构及 demo 示例
![发现-类结构.png](https://github.com/BAHome/BAWeChat/blob/master/Images/发现-类结构.png)

### BATimeLineViewModel.h
```
#import <Foundation/Foundation.h>

@class BATimeLineModel;
@interface BATimeLineViewModel : NSObject

/*! 原始数据 */
@property (nonatomic, strong) BATimeLineModel *model;

/*! 头像的 frame */
@property (nonatomic, assign) CGRect iconImageViewFrame;

/*! 昵称的 frame */
@property (nonatomic, assign) CGRect nameLabelFrame;

/*! 正文的 frame */
@property (nonatomic, assign) CGRect contentLabelFrame;

/*! 时间的 frame */
@property (nonatomic, assign) CGRect timeLabelFrame;

/*! 点赞和评论按钮的 frame */
@property (nonatomic, assign) CGRect operationButtonFrame;

/*! 来源的 frame */
@property (nonatomic, assign) CGRect sourceLabelFrame;

/*! 原创朋友圈的 frame */
@property (nonatomic, assign) CGRect originalContentViewFrame;

/*! 图片 View 的 frame */
@property (nonatomic, assign) CGRect photoViewFrame;

/*! 评论 Label 的 frame */
@property (nonatomic, assign) CGRect commentLabelFrame;

/*! 评论 View 的 frame */
@property (nonatomic, assign) CGRect commentViewFrame;


/*! cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/*! cell的内容Frame */
- (void)setUpContentFrame;

@end
```

### BATimeLineModel.h
```
#import <Foundation/Foundation.h>

@class BAUser, BATimeLineCommentModel;
@interface BATimeLineModel : NSObject

/*!
 *  发表用户
 */
@property (nonatomic, strong) BAUser *user;

/*!
 *  创建时间
 */
@property (nonatomic, copy) NSString *created_time;

/*!
 *  发表内容
 */
@property (nonatomic, copy) NSString *content;

/*!
 *  朋友圈来源
 */
@property (nonatomic, copy) NSString *source;

/*!
 *  配图数组(BAPhoto)
 */
@property (nonatomic, strong) NSArray <NSString *>*pic_urls;

/*!
 *  内容 ID
 */
@property (nonatomic, copy) NSString *contentId;

/*!
 *  内容的评论
 */
@property (nonatomic, strong) NSArray <BATimeLineCommentModel *>*comments;


@end

@interface BATimeLineCommentModel : NSObject

@property (nonatomic, copy) NSString *commentContent;

@property (nonatomic, strong) BAUser *firstUser;
@property (nonatomic, strong) BAUser *secondUser;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end
```

### demo 示例
```
其他示例可下载demo查看源码！
```

## 5、更新记录：【倒叙】
 欢迎使用 [【BAHome】](https://github.com/BAHome) 系列开源代码 ！
 如有更多需求，请前往：[【https://github.com/BAHome】](https://github.com/BAHome) 
 
 最新更新时间：2017-05-17 【倒叙】
 最新Version：【Version：1.1.0】<br>
 更新内容：<br>
 1.1.0.1、完美适配朋友圈的横竖屏<br>
 1.1.0.2、新增[『BANetManager』](https://github.com/BAHome/BANetManager)、[『BAAlert』](https://github.com/BAHome/BAAlert)、[『BAPickView』](https://github.com/BAHome/BAPickView)、[『BAButton』](https://github.com/BAHome/BAButton)等 BAKit 系列 pod 版本使用<br>

## 6、bug 反馈 和 联系方式
> 1、开发中遇到 bug，希望小伙伴儿们能够及时反馈与我们 BAHome 团队，我们必定会认真对待每一个问题！ <br>

> 2、联系方式 <br> 
QQ群：479663605  【注意：此群为 2 元 付费群，介意的小伙伴儿勿扰！】<br> 
博爱QQ：137361770 <br> 
博爱微博：[![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123) <br> 

## 7、开发环境 和 支持版本
> 开发使用 Xcode Version 8.3.2 (8E2002) ，理论上支持所有 iOS 版本，如有版本适配问题，请及时反馈！多谢合作！

## 8、感谢
> 感谢 BAHome 团队成员倾力合作，后期会推出一系列 常用 UI 控件的封装，大家有需求得也可以在 issue 提出，如果合理，我们会尽快推出新版本！<br>

> BAHome 的发展离不开小伙伴儿的信任与推广，再次感谢各位小伙伴儿的支持！

