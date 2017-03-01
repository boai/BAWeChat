# BAWeChat
* 1、博爱微信，使用原生 frame + MVVM + MVC + QMUIKit + BAKit 开源的微信<br>
* 2、展示图中的 FPS 是模拟器的数据，真机 iPhone 6上最低50， iPhone 7上最低59，基本上都在 58 以上，代码规范，新手学习可以做个参考 

## 一、版本介绍
* 1、全原生基础版，不含朋友圈，单独使用 BAKit 框架
* 2、MVVM 框架版，含通讯录、朋友圈、登陆注册等功能，使用 QMUIKit 和 BAKit 框架

## 二、主要功能
* 1、全局使用 原生 frame 布局，适配横竖屏【朋友圈横屏待frame优化】
* 2、使用 QMUIKit 框架快速搭建高性能项目框架，含全局配置文件再次封装，小伙伴儿们可以直接使用，无需采坑
* 3、朋友圈，采用 MVVM 框架布局，流畅的不能再流畅
	* 3.1 数据全部采用 json 数据
	* 3.2 model 仿照新浪微博 的数据结构定制
	* 3.3 图片全部实现网路图片，png、gif动图，九宫格图片完美封装，使用 YYImage
	* 3.4 图片浏览器使用 MWPhotoBrowser 
	* 3.5 原文使用 MLLabel ，实现文字内容解析，URL、电话号码等可以单独处理，详见源码
	* 3.6 原文实现微信文字长按复制收藏功能
	* 3.7 评论功能动态更新布局
* 4、通讯录，博爱出品，完美封装通讯录中英文混合排序，可以直接使用，代码简洁，一目了然
* 5、搜索，使用 QMUIKit 框架搜索功能，功能强大
* 6、系统通讯录获取并重新定制，使用 PPGetAddressBook 源码
* 7、博爱自定义键盘的封装，让你的评论、聊天就是这么简单
* 8、各种转场动画封装，详见源码
* 9、各种启动动画封装，详见源码
* 10、网络库使用 [『BANetManager』](https://github.com/boai/BANetManager) 
* 8、还有很多功能封装，详见源码 BAKit 

## 三、示例展示
![通讯录.png](https://github.com/boai/BAWeChat/blob/master/Images/通讯录.png)
![搜索.png](https://github.com/boai/BAWeChat/blob/master/Images/搜索.png)
![发现.png](https://github.com/boai/BAWeChat/blob/master/Images/发现.png)
![朋友圈.png](https://github.com/boai/BAWeChat/blob/master/Images/朋友圈.png)
![评论.png](https://github.com/boai/BAWeChat/blob/master/Images/评论.png)
![图片浏览器.png](https://github.com/boai/BAWeChat/blob/master/Images/图片浏览器.png)
![我.png](https://github.com/boai/BAWeChat/blob/master/Images/我.png)


## 四、代码规范
* 1、对于代码规范，很多程序员会不在意，如果你看了一个代码很规范的项目和代码很不规范的项目，你觉得让你接手这俩项目，你会选择哪一个？
* 2、代码规范我已经融合进 BAKit 中，对于 BAKit ，是我多年积累整理而成，现在很多项目也都在使用部分源码，我也是在实际项目开发中不断总结、更新，本次最新的 BAKit，我也是结合 SDK 开发整理而成，希望能给大家一点帮助！

## 五、更新更新记录【倒叙】
* 1、2017-03-01
	* 上传整体框架

## 六、推荐
序号 | 类库 | 简介及功能介绍 
:----------- | :-----------: | :-----------
1         | [『BAButton』](https://github.com/boai/BAButton)        | 完全实现 UIButton 的自定义的类库。pod 导入：`pod 'BAButton'`
2         | [pod安装和使用方法](http://www.cnblogs.com/boai/p/4977976.html)        | 对pod还是不熟的同学，可以看下我的博客，是最新的pod安装和使用方法，一直更新！
3         | [『BASegmentControl』](https://github.com/boai/BASegmentControl)        | 新增网易新闻的滑动SegmentControl，基于[『HMSegmentedControl』](https://github.com/HeshamMegid/HMSegmentedControl)的完美二次封装！
4         | [『BAReminderDemo』](https://github.com/boai/BAReminderDemo)        | 系统提醒和日历提醒，最近做了一个预约功能，有用到系统提醒和日历提醒，就写了这个demo！
5         | [『BALocalNotification』](https://github.com/boai/BALocalNotification)        | 本地通知最新完美封装，最近整理了下本地通知和极光推送，有很多坑都踩过了，刚刚整理出来的完美封装，肯定适合大部分场合，也可以用此封装写闹钟，也提醒事件，都可以！如果喜欢，请在git上点个星吧！
6         | [『BANetManager』](https://github.com/boai/BANetManager)        | 基于[『AFNetworking 3.1』](https://github.com/AFNetworking/AFNetworking)！最新版本的封装，集成了get/post 方法请求数据，单图/多图上传，视频上传/下载，网络监测 等多种网络请求方式！
7         | [『APP中的文字和APP名字的国际化多语言处理』](http://www.cnblogs.com/boai/p/5337558.html)        | 最全、最贴心的国际化处理博客！
8         | 3D Touch的纯代码实现方法        | 详见：[『BABaseProject』](https://github.com/boai/BABaseProject)的`appdelegate`！
9         | [『BACustomAlertView』](https://github.com/boai/BACustomAlertView)       | 目前为止，最为精简的alert封装，以后alert就用博爱的[『BACustomAlertView』](https://github.com/boai/BACustomAlertView)！

---
## 六、系统要求
* 该项目最低支持 iOS 8.0 和 Xcode 7.0。（部分动画效果仅支持iOS 8.0）使用时请仔细查看
	
## 七、个人简介
方式     | 链接 | 
:----------- | :-----------: | 
微博     | [『博爱1616』](http://weibo.com/2706728003/profile?rightmod=1&wvr=6&mod=personinfo&is_all=1)        |
博客     | [『http://boaihome.com』](http://boaihome.com)   | 
简书     | [『简书』](http://www.jianshu.com/users/95c9800fdf47/latest_articles) | 
简书专题  | [『简书专题链接』](http://www.jianshu.com/collection/072d578bf782) | 
QQ       | `137361770`        | 
iOS 10技术开发群       | `479663605`        | 

    为解决广大小白项目中遇到的各种疑难杂症，博爱新建了QQ群 `479663605`，希望广大小白和大神能够积极加入！

**~~老司机也欢迎！~~**

---

	
## 七、感谢

* 1、[『陆晓峰』](https://github.com/zeR0Lu)
* 2、[『陈集』](https://github.com/chenjipdc)
* 3、[『石少庸』](http://www.jianshu.com/u/0726f4d689a3)
<br>
	感谢以上几位大神帮忙优化此开源项目，使得今天能给开源给大家，几位大神的 git 和 博客 大家都可以随时关注！
	
	
	
	
	