//
//  BAAlert_Version.h
//  BAAlert
//
//  Created by boai on 2017/10/30.
//  Copyright © 2017年 boai. All rights reserved.
//

#ifndef BAAlert_Version_h
#define BAAlert_Version_h

/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BAAlert
 系统原生 UIAlertController 分类封装：https://github.com/BAHome/BAAlertController
 
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
 
 最新更新时间：2017-06-19 【倒叙】 <br>
 最新Version：【Version：1.2.0】 <br>
 更新内容： <br>
 1.2.0.1、统一全局宏定义文件，优化代码规范  <br>
 
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
 
 */

#endif /* BAAlert_Version_h */
