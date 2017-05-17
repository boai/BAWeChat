# BAAlert

目前为止，最为精简的 alert 和 actionSheet 封装！BAAlert 是原 DSAlert 的转移，以后更新都在这里更新，希望大家注意下！

---

## 更新提示：【倒叙更新】

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
最新Version：【Version：1.1.6】 <br>
更新内容： <br>
1.1.6.1、修复 两个按钮的情况下，button title 只显示最后一个title 的bug！  <br>

最新更新时间：2017-05-10 【倒叙】 <br>
最新Version：【Version：1.1.5】 <br>
更新内容： <br>
1.1.5.1、删除原有封装内部按钮点击事件中 ba_dismissAlertView 方法，此方法可在外部自由调用  <br>

最新更新时间：2017-05-09 【倒叙】 <br>
最新Version：【Version：1.1.4】 <br>
更新内容： <br>
1.1.4.1、pod 更新xib 文件 <br>

最新更新时间：2017-05-08 【倒叙】 <br>
最新Version：【Version：1.1.0】 <br>
更新内容： <br>
1.1.0.1、优化方法名命名规范 <br>
1.1.0.2、新增键盘内部处理 <br>
1.1.0.3、用原生 autoLayout 重构，自定义 alert 的布局再也不是问题了 <br>
1.1.0.4、优化代码结构，修复内在隐藏内存泄漏 <br>
1.1.0.5、新增 BAAlert_OC.h 文件，只需导入 BAAlert_OC.h 一个文件就可以使用 alert 和 actionSheet 了 <br>
1.1.0.6、删除了部分代码和属性，具体见源码 和 demo
 
* 12、终于可以愉快的 pod 导入了，pod 导入：` pod 'BAAlert' ` 【最新版本：1.0.1】
* 11、可以自定义每个按钮的字体颜色了！
* 10、再次设计结构，新增frameWork静态库文件封装，喜欢简洁的你可以直接导入frameWork即可！
* 9、多种炫酷入场、退出动画，让你的APP各种叼！
* 8、新增高斯模糊，枚举选择，简单明了！
* 7、新增是否开启边缘触摸隐藏 alert 默认：关闭，属性：isTouchEdgeHide，可自由开关边缘触摸！
* 6、完美适配横竖屏
* 5、简单的两行搞定一个自定义 alert
* 4、手势触摸隐藏
* 3、可以自定义背景图片、按钮颜色
* 2、可以添加文字和图片，且可以滑动查看
* 1、理论完全兼容目前所有 iOS 系统版本

---

## 0、安装、导入示例和源码地址：
* 0.1、pod 导入：` pod 'BAAlert' ` 【最新版本：1.1.2】
* 0.2、使用方法2：下载demo，把 BAAlert 文件夹拖入项目即可，<br>
导入头文件：<br>
`  #import "BAAlert_OC.h" `<br>
* 0.3、项目源码地址：<br>
 OC版    ：[https://github.com/BAHome/BAAlert](https://github.com/BAHome/BAAlert)<br>

---

## 1、图片示例：

<!--![BAAlert.gif](https://github.com/BAHome/BAAlert/blob/master/BAAlert.gif)-->

---

## 2、代码示例：
* 2.1 类似系统 alert【加边缘手势消失】、高斯模糊背景

```

- (void)alert1
{
    BAKit_WeakSelf
    /*! 第一种封装使用示例 */
    [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:titleMsg0 image:nil buttonTitles:@[@"取消",@"确定",@"确定2",@"确定3"] buttonTitlesColor:@[[UIColor redColor], [UIColor greenColor], [UIColor grayColor], [UIColor purpleColor]] configuration:^(BAAlert *temp) {
        
        //        temp.bgColor       = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.3];
        /*! 开启边缘触摸隐藏alertView */
        temp.isTouchEdgeHide = NO;
        /*! 添加高斯模糊的样式 */
        temp.blurEffectStyle = BAAlertBlurEffectStyleLight;
        /*! 开启动画 */
        //        temp.isShowAnimate   = YES;
        //        /*! 进出场动画样式 默认为：1 */
        //        temp.animatingStyle  = 1;
    }actionClick:^(NSInteger index) {
        BAKit_StrongSelf
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            //            [weakSelf.alertView1 ba_dismissAlertView];
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert1";
            [self.navigationController pushViewController:vc2 animated:YES];
            /*! 隐藏alert */
            //            [weakSelf.alertView1 ba_dismissAlertView];
        }
    }];
    
    /*! 第二种常用方法使用示例 */
    
    //    /*! 1、类似系统alert【加边缘手势消失】 */
    //    _alertView1 = [[BAAlert alloc] ba_showTitle:@"温馨提示："
    //
    //                                                    image:nil
    //                                             buttonTitles:@[@"取消", @"确定"]];
    //    _alertView1.bgColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.3];
    //    /*! 是否开启边缘触摸隐藏 alert */
    //    _alertView1.isTouchEdgeHide = YES;
    //    /*! 显示alert */
    //    [_alertView1 ba_showAlertView];
    //
    //    BAKit_WeakSelf
    //    _alertView1.buttonActionBlock = ^(NSInteger index){
    //        if (index == 0)
    //        {
    //            NSLog(@"点击了取消按钮！");
    //            /*! 隐藏alert */
    ////            [weakSelf.alertView1 ba_dismissAlertView];
    //        }
    //        else if (index == 1)
    //        {
    //            NSLog(@"点击了确定按钮！");
    //            ViewController2 *vc2 = [ViewController2 new];
    //            vc2.title = @"alert1";
    //            [weakSelf.navigationController pushViewController:vc2 animated:YES];
    //            /*! 隐藏alert */
    ////            [weakSelf.alertView1 ba_dismissAlertView];
    //        }
    //    };
}

- (void)alert2
{
//    /*! 2、自定义按钮颜色 */
    BAKit_WeakSelf
    [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:titleMsg2 image:nil buttonTitles:@[@"取消", @"跳转VC2"] buttonTitlesColor:@[[UIColor redColor], [UIColor greenColor]] configuration:^(BAAlert *tempView) {
        BAKit_StrongSelf
        self.alertView2 = tempView;
        /*! 自定义按钮文字颜色 */
        //    _alertView2.buttonTitleColor = [UIColor orangeColor];
        self.alertView2.bgColor = [UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:0.3];
        
        /*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
        self.alertView2.showAnimate = YES;
    } actionClick:^(NSInteger index) {
        BAKit_StrongSelf
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            //            [weakSelf.alertView2 ba_dismissAlertView];
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
    [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:titleMsg1 image:nil buttonTitles:@[@"取消", @"确定"] buttonTitlesColor:@[[UIColor redColor], [UIColor greenColor]] configuration:^(BAAlert *tempView) {
        BAKit_StrongSelf
        self.alertView3 = tempView;
        /*! 自定义按钮文字颜色 */
        //    _alertView3.buttonTitleColor = [UIColor orangeColor];
        /*! 自定义alert的背景图片 */
        self.alertView3.bgImageName      = @"背景.jpg";
        /*! 开启动画，并且设置动画样式，默认：1 */
        //    _alertView3.isShowAnimate = YES;
        
        /*! 没有开启动画，直接进出场动画样式，默认开启动画 */
        self.alertView3.animatingStyle  = BAAlertAnimatingStyleFall;
        
    } actionClick:^(NSInteger index) {
        BAKit_StrongSelf
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            //            [weakSelf.alertView3 ba_dismissAlertView];
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert3";
            [self.navigationController pushViewController:vc2 animated:YES];
            /*! 隐藏alert */
            //            [weakSelf.alertView3 ba_dismissAlertView];
        }
    }];
}

- (void)alert4
{
    /*! 4、内置图片和文字，可滑动查看 */
    BAKit_WeakSelf
    [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:titleMsg1 image:[UIImage imageNamed:@"美女.jpg"] buttonTitles:@[@"取消", @"跳转VC2"]  buttonTitlesColor:@[[UIColor redColor], [UIColor greenColor]] configuration:^(BAAlert *tempView) {
        BAKit_StrongSelf
        self.alertView4 = tempView;
        /*! 自定义按钮文字颜色 */
        //    _alertView4.buttonTitleColor = [UIColor orangeColor];
        /*! 自定义alert的背景图片 */
        self.alertView4.bgImageName      = @"背景.jpg";
        /*! 是否显示动画效果 */
        self.alertView4.showAnimate    = YES;
        
    } actionClick:^(NSInteger index) {
        BAKit_StrongSelf
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            //            [weakSelf.alertView4 ba_dismissAlertView];
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert4";
            [self.navigationController pushViewController:vc2 animated:YES];
            /*! 隐藏alert */
            //            [weakSelf.alertView4 ba_dismissAlertView];
        }
    }];
}

```

* 2.5 完全自定义alert

```
- (void)alert5
{
    /*! 5、完全自定义alert */
    
    BAKit_WeakSelf
    [self setViewPwdBgView];
    
    [BAAlert ba_showCustomView:self.viewPwdBgView configuration:^(BAAlert *tempView) {
        BAKit_StrongSelf
        tempView.isTouchEdgeHide = YES;
        tempView.animatingStyle = BAAlertAnimatingStyleScale;
        self.alertView5 = tempView;
    }];
}

#pragma mark - 自定义视图
- (void)setViewPwdBgView
{
    _viewPwdBgView                         = [UIView new];
    _viewPwdBgView.frame                   = CGRectMake(30, 300, SCREENWIDTH - 60, 160);
    
    _viewPwdBgView.backgroundColor         = [UIColor whiteColor];
    _viewPwdBgView.layer.masksToBounds     = YES;
    _viewPwdBgView.layer.cornerRadius      = 10.0f;
    
    CGFloat buttonWith                     = (SCREENWIDTH - 60)/2 - 0.5;
    CGFloat buttonHeight                   = 40;
    
    UILabel *titleLabel                    = [UILabel new];
    titleLabel.frame                       = CGRectMake(0, 0, _viewPwdBgView.frame.size.width, buttonHeight);
    titleLabel.textAlignment               = NSTextAlignmentCenter;
    titleLabel.font                        = [UIFont systemFontOfSize:18];
    titleLabel.text                        = @"请补全好友姓名，确保信息安全";
    //
    UIView *lineView1                      = [UIView new];
    lineView1.frame                        = CGRectMake(0, CGRectGetMaxY(titleLabel.frame), _viewPwdBgView.frame.size.width, 1);
    lineView1.backgroundColor              = [UIColor lightGrayColor];
    
    _pwdTextField                          = [UITextField new];
    _pwdTextField.frame                    = CGRectMake(_viewPwdBgView.frame.size.width/4, CGRectGetMaxY(lineView1.frame) + 20,  100, buttonHeight);
    _pwdTextField.borderStyle              = UITextBorderStyleRoundedRect;
    _pwdTextField.textAlignment            = NSTextAlignmentCenter;
    _pwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel *textView                      = [UILabel new];
    textView.font                          = [UIFont boldSystemFontOfSize:18];
    textView.frame                         = CGRectMake(CGRectGetMaxX(_pwdTextField.frame), _pwdTextField.frame.origin.y, _viewPwdBgView.frame.size.width - _pwdTextField.frame.origin.x - 15, buttonHeight);
    //
    UIView *lineView2                      = [UIView new];
    lineView2.frame                        = CGRectMake(0, _viewPwdBgView.frame.size.height - 41, _viewPwdBgView.frame.size.width, 1);
    lineView2.backgroundColor              = [UIColor lightGrayColor];
    
    UIButton *cancleButton                 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView2.frame), buttonWith, buttonHeight)];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView3                      = [UIView new];
    lineView3.frame                        = CGRectMake(buttonWith, CGRectGetMinY(cancleButton.frame), 1, buttonHeight);
    lineView3.backgroundColor              = [UIColor lightGrayColor];
    
    UIButton *sureButton                   = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView3.frame), CGRectGetMinY(cancleButton.frame), buttonWith, buttonHeight)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [sureButton setBackgroundColor:[UIColor clearColor]];
    [sureButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.tag                       = 1;
    sureButton.tag                         = 2;
    
    [_viewPwdBgView addSubview:titleLabel];
    [_viewPwdBgView addSubview:lineView1];
    [_viewPwdBgView addSubview:_pwdTextField];
    [_viewPwdBgView addSubview:textView];
    [_viewPwdBgView addSubview:lineView2];
    [_viewPwdBgView addSubview:cancleButton];
    [_viewPwdBgView addSubview:lineView3];
    [_viewPwdBgView addSubview:sureButton];
    
}

- (void)cancleButtonAction:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        NSLog(@"点击了取消按钮！");
        /*! 隐藏alert */
        [_alertView5 ba_dismissAlertView];
        [_pwdTextField resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [_pwdTextField resignFirstResponder];
        NSLog(@"点击了确定按钮！密码：%@", _pwdTextField.text);
        
        //        WEAKSELF;
        if (_pwdTextField.text.length < 4 || _pwdTextField.text.length > 8 )
        {
            self.pwdTextField.text = @"";
            [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:@"请输入正确的密码！" image:nil buttonTitles:@[@"确定"] buttonTitlesColor:@[[UIColor redColor], [UIColor cyanColor]] configuration:^(BAAlert *tempView) {
                //                weakSelf.alert2 = tempView;
            } actionClick:^(NSInteger index) {
                if (1 == index)
                {
                    return;
                }
            }];
            return;
        }
        /*! 隐藏alert */
        [_alertView5 ba_dismissAlertView];
        [_pwdTextField resignFirstResponder];
    }
}

```

* 2.6 actionsheet

```
[BAActionSheet ba_showBAActionSheetWithStyle:BAActionSheetStyleNormal
                                              contentArray:@[@"测试1",@"测试2",@"测试3"]
                                                imageArray:nil
                                                  redIndex:1
                                                     title:nil
                                             configuration:^(BAActionSheet *tempView) {
                                                 BAKit_StrongSelf
                                                 self.actionSheet1 = tempView;
                                                 self.actionSheet1.isTouchEdgeHide = YES;
                                             } clikckButtonIndex:^(NSInteger index) {
                                                 BAKit_StrongSelf
                                                 NSLog(@"你点击了第 %ld 行！",(long)index);
                                                 [self.actionSheet1 ba_dismissBAActionSheet];
                                             }];
```

* 2.7 actionsheet带标题

```
[BAActionSheet ba_showBAActionSheetWithStyle:BAActionSheetStyleTitle
                                              contentArray:@[@"测试1",@"测试2",@"测试3"]
                                                imageArray:nil
                                                  redIndex:1
                                                     title:@"测试带标题的ActionSheet"
                                             configuration:^(BAActionSheet *tempView) {
                                                 BAKit_StrongSelf
                                                 self.actionSheet1 = tempView;
                                             } clikckButtonIndex:^(NSInteger index) {
                                                 BAKit_StrongSelf
                                                 NSLog(@"你点击了第 %ld 行！",(long)index);
                                                 [self.actionSheet1 ba_dismissBAActionSheet];
                                             }];
```

* 2.8 actionsheet带标题带图片

```
[BAActionSheet ba_showBAActionSheetWithStyle:BAActionSheetStyleImageAndTitle
                                              contentArray:@[@"测试1",@"测试2",@"测试3"]
                                                imageArray:@[[UIImage imageNamed:@"123.png"],[UIImage imageNamed:@"背景.jpg"],[UIImage imageNamed:@"美女.jpg"]]
                                                  redIndex:1
                                                     title:@"测试带标题和图片的ActionSheet"
                                             configuration:^(BAActionSheet *tempView) {
                                                 BAKit_StrongSelf
                                                 self.actionSheet1 = tempView;
                                             } clikckButtonIndex:^(NSInteger index) {
                                                 BAKit_StrongSelf
                                                 NSLog(@"你点击了第 %ld 行！",(long)index);
                                                 [self.actionSheet1 ba_dismissBAActionSheet];
                                             }];
```

## 3、系统要求

    该项目最低支持 iOS 7.0 和 Xcode 7.2，理论支持目前所有 iOS 系统版本！
	
---






