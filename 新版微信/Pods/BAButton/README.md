# BAButton
自定义button

>**开发中如有问题，可以联系本人**

**新浪微博：@博爱1616**

**QQ：     137361770**

#### 对pod还是不熟的同学，可以看下我的博客，是最新的pod安装和使用方法，

###### http://www.cnblogs.com/boai/p/4977976.html


# 更新记录：【倒叙】

 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 最新更新时间：2017-05-20 【倒叙】
 最新Version：【Version：2.3.0】<br>
 更新内容：<br>
 2.3.0.1、用分类全新重构 BAButton，代码配置更灵活<br>
 2.3.0.2、可以自由设置 button 的文字和图片的布局、间距、每个角的切圆角<br>
 2.3.0.3、全面适配 纯代码、xib、storyboard<br>
 2.3.0.4、版本改动较大，希望大家谅解，如果用老版本的 BAButton，可以参考demo 更换新版本，后期改动不大<br>

* 2017-04-24 <br>
最新Version：【Version：2.2.1】<br>
更新内容：<br>
2.2.1.1、新增快速创建button 的demo，和 自定义 naviButton demo

* 2017-03-15 <br>
 最新Version：【Version：2.2.1】<br>
 更新内容：<br>
 2.2.1.1、button 的 角半径 buttonCornerRadii，默认 CGSizeMake(0, 0)

* 2017-03-02 <br>
 最新Version：【Version：2.2.0】<br>
 更新内容：<br>
 2.2.0.1、修复 buttonCornerRadii 只能在添加frame 后设置才能有效的问题，现在可以随意设置<br>
 2.2.0.2、新增设置文字或和图片间距，举个🌰：self.padding = 10;

* 2017-02-28 【倒叙】<br>
 最新Version：【Version：2.1.0】<br>
 更新内容：<br>
 2.1.1、继承自 UIButton 可以像 UIButton 一样随便添加系统属性<br>
 2.1.2、可以单独设置文字和图片的位置<br>
 2.1.3、还可以设置文字或者图片间距<br>
 2.1.4、可以设置按钮的任意一个角的圆角度数<br>
 2.1.4、全面适配纯代码、xib、storyboard
* 2016.12.04 <br>
pod 最新上架，修复部分已知bug，代码更精简！

### 示例展示：

![BAButton1](https://github.com/BAHome/BAButton/blob/master/images/BAButton1.png)
![BAButton2](https://github.com/BAHome/BAButton/blob/master/images/BAButton2.png)


## 完全实现 button 的自定义，

### pod 导入：   pod 'BAButton', '~> 2.3.0'
如果发现pod search BAButton 搜索出来的不是最新版本，需要在终端执行cd转换文件路径命令退回到desktop，然后执行pod setup命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了
具体步骤：
- pod setup : 初始化
- pod repo update : 更新仓库
- pod search BAButton


### 项目中导入头文件：
```
#import <BAButton.h> 即可
```

``` 用枚举展示button的类型：

/**
 button 的样式，以图片为基准

 - BAButtonLayoutTypeNormal: button 默认样式：内容居中-图左文右
 - BAButtonLayoutTypeCenterImageRight: 内容居中-图右文左
 - BAButtonLayoutTypeCenterImageTop: 内容居中-图上文下
 - BAButtonLayoutTypeCenterImageBottom: 内容居中-图下文上
 - BAButtonLayoutTypeLeftImageLeft: 内容居左-图左文右
 - BAButtonLayoutTypeLeftImageRight: 内容居左-图右文左
 - BAButtonLayoutTypeRightImageLeft: 内容居右-图左文右
 - BAButtonLayoutTypeRightImageRight: 内容居右-图右文左
 */
typedef NS_ENUM(NSInteger, BAButtonLayoutType) {
    BAButtonLayoutTypeNormal = 0,
    BAButtonLayoutTypeCenterImageRight,
    BAButtonLayoutTypeCenterImageTop,
    BAButtonLayoutTypeCenterImageBottom,
    BAButtonLayoutTypeLeftImageLeft,
    BAButtonLayoutTypeLeftImageRight,
    BAButtonLayoutTypeRightImageLeft,
    BAButtonLayoutTypeRightImageRight,
};

/*!
 *  设置 viewRectCornerType 样式，
 *  注意：BAViewRectCornerType 必须要先设置 viewCornerRadius，才能有效，否则设置无效，
 */
typedef NS_ENUM(NSInteger, BAViewRectCornerType) {
    /*!
     *  设置下左角 圆角半径
     */
    BAViewRectCornerTypeBottomLeft = 0,
    /*!
     *  设置下右角 圆角半径
     */
    BAViewRectCornerTypeBottomRight,
    /*!
     *  设置上左角 圆角半径
     */
    BAViewRectCornerTypeTopLeft,
    /*!
     *  设置下右角 圆角半径
     */
    BAViewRectCornerTypeTopRight,
    /*!
     *  设置下左、下右角 圆角半径
     */
    BAViewRectCornerTypeBottomLeftAndBottomRight,
    /*!
     *  设置上左、上右角 圆角半径
     */
    BAViewRectCornerTypeTopLeftAndTopRight,
    /*!
     *  设置下左、上左角 圆角半径
     */
    BAViewRectCornerTypeBottomLeftAndTopLeft,
    /*!
     *  设置下右、上右角 圆角半径
     */
    BAViewRectCornerTypeBottomRightAndTopRight,
    /*!
     *  设置上左、上右、下右角 圆角半径
     */
    BAViewRectCornerTypeBottomRightAndTopRightAndTopLeft,
    /*!
     *  设置下右、上右、下左角 圆角半径
     */
    BAViewRectCornerTypeBottomRightAndTopRightAndBottomLeft,
    /*!
     *  设置全部四个角 圆角半径
     */
    BAViewRectCornerTypeAllCorners
};


// 大家下载demo后可能出现图片不显示，只需更换图片即可，注意button的frame哦！
// 此外，此button的titleLAbel只支持一行显示，不支持多行！敬请注意！

// 示例1：
    [self.normalButton ba_button_setBAButtonLayoutType:BAButtonLayoutTypeNormal padding:padding];
    [self.normalButton ba_button_setBAViewRectCornerType:BAViewRectCornerTypeBottomLeft viewCornerRadius:viewCornerRadius];
    

// 示例2：
    CGRect frame = CGRectMake(0, 0, 80, 40);
    UIButton *navi_rightButton = [[UIButton alloc] creatButtonWithFrame:frame title:@"xib" selTitle:nil titleColor:nil titleFont:nil image:[UIImage imageNamed:@"tabbar_mainframeHL"] selImage:nil padding:2 buttonPositionStyle:BAButtonLayoutTypeCenterImageRight viewRectCornerType:BAViewRectCornerTypeAllCorners viewCornerRadius:20 target:self selector:@selector(handleRightNaviButtonAction)];
    navi_rightButton.backgroundColor = BAKit_ColorRandom();
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navi_rightButton];

其他示例可下载demo查看源码！
