# BAPrivacyManager
[![BAHome Team Name](https://img.shields.io/badge/Team-BAHome-brightgreen.svg?style=flat)](https://github.com/BAHome "BAHome Team")
![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/cocoapods/v/BAPrivacyManager.svg?style=flat) ![](https://img.shields.io/cocoapods/dt/BAPrivacyManager.svg
)  [![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123)

## 1、功能及简介
* 1、iOS 所有隐私权限封装，定位、蓝牙、通知、运动、日历、相册、相机等 14 种权限封装！详见 demo！ <br>

## 2、图片示例
![BAPrivacyManager1](https://github.com/BAHome/BAPrivacyManager/blob/master/Images/BAPrivacyManager1.png)

## 3、安装、导入示例和源码地址
* 1、pod 导入【最新版本：![](https://img.shields.io/cocoapods/v/BAPrivacyManager.svg?style=flat)】： <br>
 `pod 'BAPrivacyManager'` <br>
如果发现 `pod search BAPrivacyManager` 搜索出来的不是最新版本，需要在终端执行 cd 转换文件路径命令退回到 desktop，然后执行 `pod setup` 命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了。<br>
具体步骤：
  - pod setup : 初始化
  - pod repo update : 更新仓库
  - pod search BAPrivacyManager
* 2、文件夹拖入：下载demo，把 BAPrivacyManager 文件夹拖入项目即可，<br>
* 3、导入头文件：<br>
`  #import "BAKit_PrivacyManager.h" `<br>
* 4、项目源码地址：<br>
 OC 版 ：[https://github.com/BAHome/BAPrivacyManager](https://github.com/BAHome/BAPrivacyManager)<br>

## 4、BAPrivacyManager 的类结构及 demo 示例
![BAPrivacyManager](https://github.com/BAHome/BAPrivacyManager/blob/master/Images/BAPrivacyManager.png)

### BAPrivacyManager.h
```
#import <Foundation/Foundation.h>
#import "BAKit_Singleton.h"

// Import required frameworks
#import <CoreLocation/CoreLocation.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreMotion/CoreMotion.h>
#import <EventKit/EventKit.h>
#import <HomeKit/HomeKit.h>
#import <HealthKit/HealthKit.h>
#import <StoreKit/StoreKit.h>
#import <Speech/Speech.h>
// 相册
#import <Photos/Photos.h>
// 通知
#import <UserNotifications/UserNotifications.h>


/**
 隐私类型

 - BAKit_PrivacyType_None: 无
 - BAKit_PrivacyType_LocationServices: 定位
 - BAKit_PrivacyType_Contacts: 通讯录
 - BAKit_PrivacyType_Calendars: 日历
 - BAKit_PrivacyType_Reminders: 提醒事项
 - BAKit_PrivacyType_Photos: 照片
 - BAKit_PrivacyType_Camera: 相机
 - BAKit_PrivacyType_BluetoothSharing: 蓝牙共享
 - BAKit_PrivacyType_Microphone: 麦克风
 - BAKit_PrivacyType_SpeechRecognition: 语音识别 >= iOS 10.0
 - BAKit_PrivacyType_Health: 健康 >= iOS 8.0
 - BAKit_PrivacyType_HomeKit: 家庭 >= iOS 8.0
 - BAKit_PrivacyType_MediaAndAppleMusic: 媒体与 Apple Music >= iOS 9.3
 - BAKit_PrivacyType_MotionAndFitness: 运动与健身
 - BAKit_PrivacyType_MessageNotification: 消息通知
 */
typedef NS_ENUM(NSUInteger, BAKit_PrivacyType){
    BAKit_PrivacyType_None               = 0,
    BAKit_PrivacyType_LocationServices,
    BAKit_PrivacyType_Contacts,
    BAKit_PrivacyType_Calendars,
    BAKit_PrivacyType_Reminders,
    BAKit_PrivacyType_Photos,
    BAKit_PrivacyType_Camera,
    BAKit_PrivacyType_BluetoothSharing,
    BAKit_PrivacyType_Microphone,
    BAKit_PrivacyType_SpeechRecognition,
    BAKit_PrivacyType_Health,
    BAKit_PrivacyType_HomeKit,
    BAKit_PrivacyType_MediaAndAppleMusic,
    BAKit_PrivacyType_MotionAndFitness,
    BAKit_PrivacyType_MessageNotification,
};

/**
 权限状态，参考：PHAuthorizationStatus 等，可以根据返回的不同状态做相应的处理

 - BAKit_PrivacyStatus_NotDetermined: 用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 - BAKit_PrivacyStatus_Authorized: 已授权
 - BAKit_PrivacyStatus_Denied: 拒绝
 - BAKit_PrivacyStatus_Restricted: 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 - BAKit_PrivacyStatus_NotSupport: 硬件等不支持
 */
typedef NS_ENUM(NSUInteger, BAKit_PrivacyStatus){
    BAKit_PrivacyStatus_NotDetermined  = 0,
    BAKit_PrivacyStatus_Authorized     = 1,
    BAKit_PrivacyStatus_Denied         = 2,
    BAKit_PrivacyStatus_Restricted     = 3,
    BAKit_PrivacyStatus_NotSupport     = 4,
};

/**
 定位权限状态，参考：CLAuthorizationStatus

 - BAKit_LocationAuthorizationStatus_NotDetermined: 用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 - BAKit_LocationAuthorizationStatus_Authorized: 一直允许获取定位 ps：< iOS8用
 - BAKit_LocationAuthorizationStatus_Denied: 拒绝
 - BAKit_LocationAuthorizationStatus_Restricted: 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 - BAKit_LocationAuthorizationStatus_NotSupport: 硬件等不支持
 - BAKit_LocationAuthorizationStatus_AuthorizedAlways: 一直允许获取定位
 - BAKit_LocationAuthorizationStatus_AuthorizedWhenInUse: 在使用时允许获取定位
 */
typedef NS_ENUM(NSUInteger, BAKit_LocationAuthorizationStatus){
    BAKit_LocationAuthorizationStatus_NotDetermined         = 0,
    BAKit_LocationAuthorizationStatus_Authorized            = 1,
    BAKit_LocationAuthorizationStatus_Denied                = 2,
    BAKit_LocationAuthorizationStatus_Restricted            = 3,
    BAKit_LocationAuthorizationStatus_NotSupport            = 4,
    BAKit_LocationAuthorizationStatus_AuthorizedAlways      = 5,
    BAKit_LocationAuthorizationStatus_AuthorizedWhenInUse   = 6,
};

/**
 蓝牙连接状态，参考：CBManagerState

 - BAKit_CBManagerStatus_Unknown: 未知状态
 - BAKit_CBManagerStatus_Resetting: 正在重置，与系统服务暂时丢失
 - BAKit_CBManagerStatus_Unsupported: 不支持蓝牙
 - BAKit_CBManagerStatus_Unauthorized: 未授权
 - BAKit_CBManagerStatus_PoweredOff: 关闭
 - BAKit_CBManagerStatus_PoweredOn: 开启并可用
 */
typedef NS_ENUM(NSUInteger, BAKit_CBManagerStatus){
    BAKit_CBManagerStatus_Unknown         = 0,
    BAKit_CBManagerStatus_Resetting       = 1,
    BAKit_CBManagerStatus_Unsupported     = 2,
    BAKit_CBManagerStatus_Unauthorized    = 3,
    BAKit_CBManagerStatus_PoweredOff      = 4,
    BAKit_CBManagerStatus_PoweredOn       = 5,
};

/*
 定义权限状态回调 block
 */
typedef void(^BAKit_PrivacyResultBlock)(BAKit_PrivacyStatus status, BAKit_PrivacyType type);

/**
 定位权限 block

 @param status 定位权限状态
 */
typedef void(^BAKit_PrivacyOfLocationResultBlock)(BAKit_LocationAuthorizationStatus status);

/**
 蓝牙连接状态 block

 @param status 蓝牙连接状态
 */
typedef void(^BAKit_PrivacyOfBluetoothResultBlock)(BAKit_CBManagerStatus status);

/**
 家庭状态 block

 @param isHaveHomeAccess HomeKit 状态
 */
typedef void(^BAKit_PrivacyOfHomeResultBlock)(BOOL isHaveHomeAccess);

/**
 运动与健身状态 block

 @param isHaveMotionAccess 运动与健身状态
 */
typedef void(^BAKit_PrivacyOfMotionResultBlock)(BOOL isHaveMotionAccess);

/**
 是否开启通知

 @param isOpenMessageNotification 开启通知状态
 @param type 通知类型
 */
typedef void(^BAKit_PrivacyOfMessageNotificationResultBlock)(BOOL isOpenMessageNotification, UIUserNotificationType type);

#define BAPrivacyManagerShared  [BAPrivacyManager sharedBAPrivacyManager]

@interface BAPrivacyManager : NSObject
BAKit_SingletonH(BAPrivacyManager)


#pragma mark - checkAndRequestAccessForType
- (void)ba_authorizationManagerCheckAccessForType:(BAKit_PrivacyType)type
                                            block:(BAKit_PrivacyResultBlock)block;

#pragma mark - Contacts
- (void)ba_checkAndRequestPrivacyOfContactsWithBlock:(BAKit_PrivacyResultBlock)block;

#pragma mark - Calendars
- (void)ba_checkAndRequestPrivacyOfCalendarsWithBlock:(BAKit_PrivacyResultBlock)block;

#pragma mark - Reminders
- (void)ba_checkAndRequestPrivacyOfRemindersWithBlock:(BAKit_PrivacyResultBlock)block;

#pragma mark - Photos
- (void)ba_checkAndRequestPrivacyOfPhotosWithBlock:(BAKit_PrivacyResultBlock)block;

#pragma mark - Microphone
- (void)ba_checkAndRequestPrivacyOfMicrophoneWithBlock:(BAKit_PrivacyResultBlock)block;

#pragma mark - SpeechRecognition
- (void)ba_checkAndRequestPrivacyOfSpeechRecognitionWithBlock:(BAKit_PrivacyResultBlock)block;

#pragma mark - Camera
- (void)ba_checkAndRequestPrivacyOfCameraWithBlock:(BAKit_PrivacyResultBlock)block;

#pragma mark - Health，注意：需要证书支持 healthkit
- (void)ba_checkAndRequestPrivacyOfHealthWithBlock:(BAKit_PrivacyResultBlock)block;

#pragma mark - HomeKit，注意：需要证书支持 HomeKit
- (void)ba_checkAndRequestPrivacyOfHomeWithBlock:(BAKit_PrivacyOfHomeResultBlock)block;

#pragma mark - HMHomeManagerDelegate
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager;

#pragma mark - MediaAndAppleMusic
- (void)ba_checkAndRequestPrivacyOfAppleMusicWithBlock:(BAKit_PrivacyResultBlock)block;

#pragma mark - MotionAndFitness
- (void)ba_checkAndRequestPrivacyOfMotionAndFitness;

#pragma mark - 通知权限监测
- (void)ba_openMessageNotificationServiceWithBlock:(BAKit_PrivacyOfMessageNotificationResultBlock)block;

#pragma mark - LocationServices
- (void)ba_checkAndRequestPrivacyOfLocationServicesWithBlock:(BAKit_PrivacyOfLocationResultBlock)block;

#pragma mark - BluetoothSharing 支持 iOS 10.0 以上
- (void)ba_checkAndRequestPrivacyOfBluetoothSharingWithBlock:(BAKit_PrivacyOfBluetoothResultBlock)block;

@end
```

### demo 示例
```
// 示例1：定位权限
[BAPrivacyManagerShared ba_checkAndRequestPrivacyOfLocationServicesWithBlock:^(BAKit_LocationAuthorizationStatus status) {
                if (status == BAKit_LocationAuthorizationStatus_Authorized)
                {
                    BAKit_ShowAlertWithMsg_ios8(@"已经授权过，无需授权");
                }
                else if (status == BAKit_LocationAuthorizationStatus_NotDetermined)
                {
                    BAKit_ShowAlertWithMsg_ios8(@"第一次授权！");
                }
                else
                {
                    NSString *msg = [NSString stringWithFormat:@"授权类型：%@，授权状态：%ld", self.dataArray[indexPath.row], status];
                    NSLog(@"%@", msg);
                    BAKit_ShowAlertWithMsg_ios8(msg);
                }
                
            }];
    
    
// 示例2：通知权限
[BAPrivacyManagerShared ba_openMessageNotificationServiceWithBlock:^(BOOL isOpenMessageNotification, UIUserNotificationType type) {
                NSString *msg = [NSString stringWithFormat:@"授权类型：%@，授权状态：%d，%ld", self.dataArray[indexPath.row], isOpenMessageNotification, type];
                NSLog(@"%@", msg);
                BAKit_ShowAlertWithMsg_ios8(msg);
            }];

// 示例3：蓝牙权限
[BAPrivacyManagerShared ba_checkAndRequestPrivacyOfBluetoothSharingWithBlock:^(BAKit_CBManagerStatus status) {
                NSString *msg = [NSString stringWithFormat:@"授权类型：%@，授权状态：%ld", self.dataArray[indexPath.row], status];
                NSLog(@"%@", msg);
                BAKit_ShowAlertWithMsg_ios8(msg);
            }];

其他示例可下载demo查看源码！
```

## 5、更新记录：【倒叙】
 欢迎使用 [【BAHome】](https://github.com/BAHome) 系列开源代码 ！
 如有更多需求，请前往：[【https://github.com/BAHome】](https://github.com/BAHome) 
 
 最新更新时间：2017-10-07【倒叙】<br>
 最新 Version：【Version：1.0.0】<br>
 更新内容：<br>
 1.0.0.1、iOS 所有隐私权限封装，定位、蓝牙、通知、运动、日历、相册、相机等 14 种权限封装！详见 demo！ <br>


## 6、bug 反馈
> 1、开发中遇到 bug，希望小伙伴儿们能够及时反馈与我们 [【BAHome】](https://github.com/BAHome) 团队，我们必定会认真对待每一个问题！ <br>

> 2、以后提需求和 bug 的同学，记得把 git 或者博客链接给我们，我直接超链到你们那里！希望大家积极参与测试！<br> 

## 7、BAHome 团队成员
> 1、QQ 群 
479663605 <br> 
【注意：此群为 2 元 付费群，介意的小伙伴儿勿扰！】<br> 

> 孙博岩 <br> 
QQ：137361770 <br> 
git：[https://github.com/boai](https://github.com/boai) <br>
简书：[http://www.jianshu.com/u/95c9800fdf47](http://www.jianshu.com/u/95c9800fdf47) <br>
微博：[![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123) <br>

> 马景丽 <br> 
QQ：1253540493 <br> 
git：[https://github.com/MaJingli](https://github.com/MaJingli) <br>

> 陆晓峰 <br> 
QQ：442171865 <br> 
git：[https://github.com/zeR0Lu](https://github.com/zeR0Lu) <br>

> 陈集 <br> 
QQ：3161182978 <br> 
git：[https://github.com/chenjipdc](https://github.com/chenjipdc) <br>
简书：[http://www.jianshu.com/u/90ae559fc21d](http://www.jianshu.com/u/90ae559fc21d)

> 任子丰 <br> 
QQ：459643690 <br> 
git：[https://github.com/renzifeng](https://github.com/renzifeng) <br>

> 吴丰收 <br> 
QQ：498121294 <br> 

> 石少庸 <br> 
QQ：363605775 <br> 
git：[https://github.com/CrazyCoderShi](https://github.com/CrazyCoderShi) <br>
简书：[http://www.jianshu.com/u/0726f4d689a3](http://www.jianshu.com/u/0726f4d689a3)

## 8、开发环境 和 支持版本
> 开发使用 最新版本 Xcode，理论上支持 iOS 8 及以上版本，如有版本适配问题，请及时反馈！多谢合作！

## 9、感谢
> 感谢 [【BAHome】](https://github.com/BAHome) 团队成员倾力合作，后期会推出一系列 常用 UI 控件的封装，大家有需求得也可以在 issue 提出，如果合理，我们会尽快推出新版本！<br>

>  [【BAHome】](https://github.com/BAHome)  的发展离不开小伙伴儿的信任与推广，再次感谢各位小伙伴儿的支持！

