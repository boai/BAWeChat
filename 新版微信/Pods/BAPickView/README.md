# BAPickView

目前为止，最为精简的 自定义 pickView 和 日期选择器 封装！

---

## 更新提示：【倒叙更新】

最新更新时间：2017-05-16 【倒叙】 <br>
最新Version：【Version：1.0.0】 <br>
更新内容： <br>
1.0.0.1、城市选择器，三级联动，可返回省市县和精确的经纬度  <br>
1.0.0.2、可以自定义 array 显示，性别选择等【目前只支持单行数据】  <br>
1.0.0.3、日期选择器：年月日，可以完全自定义 NSDateFormatter  <br>
1.0.0.4、日期选择器：年月，可以完全自定义 NSDateFormatter  <br>
1.0.0.5、横竖屏适配完美  <br>
1.0.0.6、可以自定义按钮颜色、背景颜色等  <br>
1.0.0.7、理论完全兼容现有所有 iOS 系统版本  <br>

---

## 0、安装、导入示例和源码地址：
* 0.1、pod 导入：` pod 'BAPickView' ` 【最新版本：1.0.0】
* 0.2、使用方法2：下载demo，把 BAPickView 文件夹拖入项目即可，<br>
导入头文件：<br>
`  #import "BAPickView_OC.h" `<br>
* 0.3、项目源码地址：<br>
 OC版 ：[https://github.com/BAHome/BAPickView](https://github.com/BAHome/BAPickView)<br>

---

## 1、图片示例：

<!--![BAAlert.gif](https://github.com/BAHome/BAAlert/blob/master/BAAlert.gif)-->

---

## 2、代码示例：

```

- (void)pickView1
{
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatCityPickerViewWithConfiguration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        self.pickView = tempView;
    } block:^(BAKit_CityModel *model) {
        BAKit_StrongSelf
        // 返回 BAKit_CityModel，包含省市县 和 详细的经纬度
        NSString *msg = [NSString stringWithFormat:@"%@%@%@\n纬度：%f\n经度：%f", model.province, model.city, model.area, model.coordie.latitude, model.coordie.longitude];
        NSLog(@"%@", msg);
        BAKit_ShowAlertWithMsg_ios8(msg);
    }];
}

- (void)pickView2
{
    NSArray *array = @[@"男", @"女"];
    
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatCustomPickerViewWithDataArray:array configuration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        // 可以自由定制 toolBar 和 pickView 的背景颜色
        tempView.backgroundColor_toolBar = [UIColor cyanColor];
        tempView.backgroundColor_pickView = [UIColor greenColor];
        self.pickView = tempView;
    } block:^(NSString *resultString) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView3
{
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatPickerViewWithType:BAKit_PickerViewTypeDate configuration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        
        // 可以自由定制 NSDateFormatter
//        tempView.dateType = BAKit_PickerViewDateTypeYMDEHMS;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy年MM月dd日";
        tempView.customDateFormatter = formatter;
        // 可以自由定制按钮颜色
        tempView.buttonTitleColor_sure = [UIColor redColor];
        tempView.buttonTitleColor_cancle = [UIColor greenColor];
        self.pickView = tempView;
        
    } block:^(NSString *resultString) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView4
{
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatPickerViewWithType:BAKit_PickerViewTypeDateYM configuration:^(BAKit_PickerView *tempView) {
        
        BAKit_StrongSelf
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM";
        tempView.customDateFormatter = formatter;
        self.pickView = tempView;
    } block:^(NSString *resultString) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

```
## 3、系统要求

    该项目最低支持 iOS 7.0 和 Xcode 8.0，理论支持目前所有 iOS 系统版本！
	
---






