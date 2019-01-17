//
//  BAKit_PhotoKitManager.h
//  yunLianPay
//
//  Created by boai on 2017/6/28.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>


/// PhotoKit 授权的状态
typedef NS_ENUM(NSUInteger, BAKit_PhotoKitAuthorizationStatus) {
    BAKit_PhotoKitAuthorizationStatusNotUsingPhotoKit,   // 对于iOS7及以下不支持PhotoKit的系统，没有所谓的“授权状态”，所以定义一个特定的status用于表示这种情况
    BAKit_PhotoKitAuthorizationStatusNotDetermined,      // 还不确定有没有授权
    BAKit_PhotoKitAuthorizationStatusAuthorized,         // 已经授权
    BAKit_PhotoKitAuthorizationStatusNotAuthorized       // 手动禁止了授权
};

@interface BAKit_PhotoKitManager : NSObject

/**
 获取当前应用对照片的访问授权状态
 
 @return BAKit_PhotoKitAuthorizationStatus
 */
+ (BAKit_PhotoKitAuthorizationStatus)ba_photoKitManagerGetPHAuthorizationStatus;

/**
 调起系统询问是否授权访问“照片”的 UIAlertView
 
 @param handler 授权结束后调用的 block，默认不在主线程上执行，如果需要在 block 中修改 UI，记得dispatch到mainqueue
 */
+ (void)ba_photoKitManagerRequestAuthorization:(void(^)(BAKit_PhotoKitAuthorizationStatus status))handler;

/**
 保存图片到相册
 
 @param image image
 @param viewController viewController
 */
+ (void)ba_photoKitManagerSaveImageToLocalWithImage:(UIImage *)image viewController:(UIViewController *)viewController;

@end
