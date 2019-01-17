//
//  BATextView_Version.h
//  BATextView
//
//  Created by boai on 2017/9/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#ifndef BATextView_Version_h
#define BATextView_Version_h

/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BATextView
 
 最新更新时间：2018-06-15 【倒叙】<br>
 最新Version：【Version：1.0.5】<br>
 更新内容：<br>
 1.0.5.1、修改已知BUG：感谢 群里同学（@深圳-Apec）提出 [Issues](https://github.com/BAHome/BATextView/is
 
 最新更新时间：2018-03-22 【倒叙】<br>
 最新Version：【Version：1.0.4】<br>
 更新内容：<br>
  1.0.4.1、修改BUG：感谢 Github同学提出 [Issues](https://github.com/BAHome/BATextView/issues/4) 调用ba_text赋值后和ba_placeholder颜色字体大小一样的BUG。现已修复该问题
 
 最新更新时间：2017-11-15 【倒叙】<br>
 最新Version：【Version：1.0.3】<br>
 更新内容：<br>
 1.0.3.1、优化输入表情的时候，最大字数限制出现的特殊情况<br>
 1.0.3.2、优化输入文字后收回键盘后再次输入之前的内容消失的问题<br>
 1.0.3.3、【方法新增】：默认 self.text 文字时的属性 ba_text：TextView 默认 text，注意：一定要用 ba_text 设置，用系统的 self.text 设置无效，此外，如果有默认 text，一定要在 ba_placeholder 赋值之前赋值 ba_text，要不然会出现文字颜色错乱！感谢群里[@北京-张浩](https://github.com/907064772 )大神的优化！<br>
 1.0.3.4、【方法新增】：新增 UITextView 代理 shouldChangeTextInRange 改成 block （ba_textView_ShouldChangeTextInRangeBlock）返回，使用更加方便！  <br>
 1.0.3.5、【方法替换】：原有 typedef void (^BAKit_TextView_WordDidChangedBlock)(NSInteger current_length)，替换成 typedef void (^BAKit_TextView_WordDidChangedBlock)(NSString *current_text) <br>
 1.0.3.6、修改BUG：感谢 Github同学提出 [Issues](https://github.com/BAHome/BATextView/issues/4) 调用ba_text赋值后和ba_placeholder颜色字体大小一样的BUG。现已修复该问题

 最新更新时间：2017-09-19 【倒叙】<br>
 最新Version：【Version：1.0.2】<br>
 更新内容：<br>
 1.0.2.1、优化 - (BOOL)ba_textView_isEmpty; 方法，修复 输入文字和 placeholder 文字一样时判断无效的 bug(感谢群里 [@成都-刘军](https://github.com/liujunliuhong ) 同学提出的 bug！) <br>
 
 最新更新时间：2017-06-01 【倒叙】<br>
 最新Version：【Version：1.0.1】<br>
 更新内容：<br>
 1.0.1.1、优化注释<br>
 
 最新更新时间：2017-05-27 【倒叙】<br>
 最新Version：【Version：1.0.0】<br>
 更新内容：<br>
 1.0.0.1、可以自定义 placeholder的(字体、颜色)、文字(字体、颜色)
 1.0.0.2、可以自定义 输入文字的(字体、颜色)、文字(字体、颜色)
 1.0.0.3、可以自动布局，自适应高度，实时监测输入文字的最大高度
 1.0.0.4、可以实时监测输入文字的最大个数，可以限制最大输入文字字数
 1.0.0.5、用分类整理，无需改动源码即可实现各种自定义功能
 
 */

#endif /* BATextView_Version_h */
