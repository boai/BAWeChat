### UIAlertView、UIActionSheet、UIAlertController封装

#### cocoapods安装

##### oc版本
```ruby
platform :ios, '6.0'
pod 'LBXAlertAction'
```

##### swift版本
```ruby
platform :ios, '8.0'
pod 'AlertAction'
```

#### 手动导入：
将LBXAlertAction文件夹中的所有文件拽入项目中
导入主头文件：#import "LBXAlertAction.h"

swift:将AlertAction文件夹内所有文件拖入项目中即可

## 使用说明

### Alert形式示例

```obj-c

//oc版本
__weak __typeof(self) weakSelf = self;
[LBXAlertAction showAlertWithTitle:@"标题"
                               msg:@"提示消息内容"
                  buttonsStatement:@[@"取消",@"确认1",@"确认2",@"确认3",@"确认4",@"确认5",@"确认6"]
                       chooseBlock:^(NSInteger buttonIdx) {

                          NSArray* array = @[@"取消",@"确认1",@"确认2",@"确认3",@"确认4",@"确认5",@"确认6"];

                          //按钮按顺序输出
                          NSLog(@"u choose:%@",array[buttonIdx]);
                         [weakSelf dosomething];
                          }];
```


```swift
//swift版本
        let items = ["cancel","ok1","ok2"];
        
        AlertAction.showAlert(title: "title", message: "message", btnStatements:items ) { (buttonIndex) in
            
            
            let items = ["cancel","ok1","ok2"];
            
            print(buttonIndex)
            
            print(items[buttonIndex])
          
        }

```

### Sheet形式示例

```obj-c
__weak __typeof(self) weakSelf = self;
[LBXAlertAction showActionSheetWithTitle:@"标题"
                                 message:@"ios8系统之后才会显示本消息内容"
                       cancelButtonTitle:@"取消"
                  destructiveButtonTitle:@"destruct"
                        otherButtonTitle:@[@"items1",@"items2",@"items3"]
                             chooseBlock:^(NSInteger buttonIdx) {

                            //取消为0，destructiveButtonTitle从1开始，
                            //如果destructiveButtonTitle输入为nil，则otherButtonTitle从1开始，否则从2开始
                            NSLog(@"%ld",buttonIdx);
                           [weakSelf dosomething];
                           }];
```

```swift
//swift版本
        let destrucitve:String? = "destructive"
        
//        let destrucitve:String? = nil
        
        AlertAction.showSheet(title: "title", message: "ios8之后才会显示本条信息",  destructiveButtonTitle: destrucitve,cancelButtonTitle: "cancel", otherButtonTitles: ["other1","other2"]) { (buttonIdx, itemTitle) in
            
            /*
             经测试
             buttonIdx：  destructiveButtonTitle 为0， cancelButtonTitle 为1，otherButtonTitles按顺序增加
             如果destructiveButtonTitle 传入值为nil,那么 cancelButtonTitle 为0，otherButtonTitles按顺序增加
             
             或者按照itemTitle来判断用户点击那个按钮更稳妥
             */
            
            print(buttonIdx)
            print(itemTitle)
        }


