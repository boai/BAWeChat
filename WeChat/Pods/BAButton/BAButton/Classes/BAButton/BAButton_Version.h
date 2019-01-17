//
//  BAButton_Version.h
//  BAButton
//
//  Created by 孙博岩 on 2018/8/28.
//  Copyright © 2018 boai. All rights reserved.
//

#ifndef BAButton_Version_h
#define BAButton_Version_h


/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BAButton
 
 最新更新时间：2018-11-15【倒叙】<br>
 最新 Version：【Version：2.6.7】<br>
 更新内容：<br>
 2.6.7.1、全新适配 官方 pod demo！ <br>
 
 最新更新时间：2018-08-28【倒叙】<br>
 最新 Version：【Version：2.6.6】<br>
 更新内容：<br>
 2.6.6.1、优化内部代码，新增倒计时部分简化代码，详情看 demo 和源码！ <br>
 
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
 最新 Version：【Version：2.6.0】<br>
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

#endif /* BAButton_Version_h */
