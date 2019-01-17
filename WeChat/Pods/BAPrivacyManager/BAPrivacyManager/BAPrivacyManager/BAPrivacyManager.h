
/*!
 *  @header BAKit.h
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright  Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                一人 我编程累 累得只想把觉睡
//                两眼 是辛酸泪 代码咋写都不对
//
//                重启是也不行 关机它也不灵
//                我狂敲键盘怒砸鼠标 异常也不停
//
//                这循环它有点绕 注释也很微妙
//                我看了半天稀里糊涂马隔壁我草
//
//                加断点 再抵坝 堆栈瞬间就爆炸
//                日志输出如雨下 看到异常就害怕
//
//                调试一夜没人陪 心想这锅该归谁
//                回想当初心后悔 不该重构这地雷
//
//                翻日志 看半天 博客看了几百篇
//                闪退还是没复现 低头又点一根烟
//
//                加着班我心烦乱 烂摊子我不想干
//                离职损失就几万 一拍桌子把工作换
//
//                离职 我不再忙 在家 我守空房
//                我闲得无聊掏出电脑 代码又写几行

/*
 
 *********************************************************************************
 *
 * 在使用 BAKit 的过程中如果出现 bug 请及时以以下任意一种方式联系我，我会及时修复 bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * BAHome : https://github.com/BAHome
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */

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
