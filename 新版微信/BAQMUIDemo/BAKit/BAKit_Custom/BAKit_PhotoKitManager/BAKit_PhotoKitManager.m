//
//  BAKit_PhotoKitManager.m
//  yunLianPay
//
//  Created by boai on 2017/6/28.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKit_PhotoKitManager.h"
#import <Photos/Photos.h>

@implementation BAKit_PhotoKitManager

/**
 获取当前应用对照片的访问授权状态

 @return BAKit_PhotoKitAuthorizationStatus
 */
+ (BAKit_PhotoKitAuthorizationStatus)ba_photoKitManagerGetPHAuthorizationStatus
{
    BAKit_PhotoKitAuthorizationStatus status;
    // 获取当前应用对照片的访问授权状态
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    if (authorizationStatus == PHAuthorizationStatusRestricted || authorizationStatus == PHAuthorizationStatusDenied) {
        status = BAKit_PhotoKitAuthorizationStatusNotAuthorized;
    } else if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
        status = BAKit_PhotoKitAuthorizationStatusNotDetermined;
    } else {
        status = BAKit_PhotoKitAuthorizationStatusAuthorized;
    }
    return status;
}

/**
 调起系统询问是否授权访问“照片”的 UIAlertView

 @param handler 授权结束后调用的 block，默认不在主线程上执行，如果需要在 block 中修改 UI，记得dispatch到mainqueue
 */
+ (void)ba_photoKitManagerRequestAuthorization:(void(^)(BAKit_PhotoKitAuthorizationStatus status))handler
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus phStatus) {
        BAKit_PhotoKitAuthorizationStatus status;
        if (phStatus == PHAuthorizationStatusRestricted || phStatus == PHAuthorizationStatusDenied) {
            status = BAKit_PhotoKitAuthorizationStatusNotAuthorized;
        } else if (phStatus == PHAuthorizationStatusNotDetermined) {
            status = BAKit_PhotoKitAuthorizationStatusNotDetermined;
        } else {
            status = BAKit_PhotoKitAuthorizationStatusAuthorized;
        }
        if (handler) {
            handler(status);
        }
    }];
}

/**
 保存图片到相册

 @param image image
 @param viewController viewController
 */
+ (void)ba_photoKitManagerSaveImageToLocalWithImage:(UIImage *)image viewController:(UIViewController *)viewController
{
    if ([self ba_photoKitManagerGetPHAuthorizationStatus] == BAKit_PhotoKitAuthorizationStatusNotDetermined)
    {
        [self ba_photoKitManagerRequestAuthorization:^(BAKit_PhotoKitAuthorizationStatus status) {
            // requestAuthorization:(void(^)(BAKit_PhotoKitAuthorizationStatus status))handler 不在主线程执行，因此涉及 UI 相关的操作需要手工放置到主流程执行。
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == BAKit_PhotoKitAuthorizationStatusAuthorized || status == BAKit_PhotoKitAuthorizationStatusNotUsingPhotoKit)
                {
                    [self ba_photoKitManagerSaveImageToAlbumWithImage:image viewController:viewController];
                }
                else
                {
                    [self ba_showAlertWhenSavedPhotoFailuredByPermissionDeniedWithViewController:viewController];
                }
            });
        }];
    }
    else if ([self ba_photoKitManagerGetPHAuthorizationStatus] == BAKit_PhotoKitAuthorizationStatusNotAuthorized)
    {
        [self ba_showAlertWhenSavedPhotoFailuredByPermissionDeniedWithViewController:viewController];
    }
    else
    {
        [self ba_photoKitManagerSaveImageToAlbumWithImage:image viewController:viewController];
    }
}

+ (void)ba_photoKitManagerSaveImageToAlbumWithImage:(UIImage *)image viewController:(UIViewController *)viewController
{
    [UIAlertController ba_alertShowInViewController:viewController title:@"保存图片到相册" message:@"" buttonTitleArray:@[@"取消", @"确定"] buttonTitleColorArray:nil block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            [self ba_photoKitManagerSaveWithImage:image];
        }
    }];
}

+ (void)ba_photoKitManagerSaveWithImage:(UIImage *)image
{
//    // 把图片加入到指定的相册对应的 PHAssetCollection
//    [[PHPhotoLibrary sharedPhotoLibrary] addImageToAlbum:image.CGImage
//                                    albumAssetCollection:nil
//                                             orientation:image.imageOrientation
//                                       completionHandler:^(BOOL success, NSDate *creationDate, NSError *error) {
//                                           if (success) {
//                                               PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
//                                               fetchOptions.predicate = [NSPredicate predicateWithFormat:@"creationDate = %@", creationDate];
//                                               PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:nil options:fetchOptions];
//                                               PHAsset *phAsset = fetchResult.lastObject;
//                                               BAKit_ShowAlertWithMsg(@"已保存到相册!");
//                                               
//                                           } else {
//                                               NSLog(@"Get PHAsset of image error: %@", error);
//                                               BAKit_ShowAlertWithMsg(@"保存失败!");
//                                           }
//                                       }];
    
    [self ba_addImageToAlbum:image.CGImage albumAssetCollection:nil orientation:image.imageOrientation completionHandler:^(BOOL success, NSDate *creationDate, NSError *error) {
           if (success)
           {
               PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
               fetchOptions.predicate = [NSPredicate predicateWithFormat:@"creationDate = %@", creationDate];
               PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:nil options:fetchOptions];
               PHAsset *phAsset = fetchResult.lastObject;
               BAKit_ShowAlertWithMsg(@"已保存到相册!");

           } else {
               NSLog(@"Get PHAsset of image error: %@", error);
               BAKit_ShowAlertWithMsg(@"保存失败!");
           }
    }];
}

+ (void)ba_addImageToAlbum:(CGImageRef)imageRef albumAssetCollection:(PHAssetCollection *)albumAssetCollection orientation:(UIImageOrientation)orientation completionHandler:(void(^)(BOOL success, NSDate *creationDate, NSError *error))completionHandler {
    UIImage *targetImage = [UIImage imageWithCGImage:imageRef scale:BAKit_ScreenScale orientation:orientation];
    __block NSDate *creationDate = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 创建一个以图片生成新的 PHAsset，这时图片已经被添加到“相机胶卷”
        
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:targetImage];
        assetChangeRequest.creationDate = [NSDate date];
        creationDate = assetChangeRequest.creationDate;
        
        if (albumAssetCollection.assetCollectionType == PHAssetCollectionTypeAlbum) {
            // 如果传入的相册类型为标准的相册（非“智能相册”和“时刻”），则把刚刚创建的 Asset 添加到传入的相册中。
            
            // 创建一个改变 PHAssetCollection 的请求，并指定相册对应的 PHAssetCollection
            PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:albumAssetCollection];
            /**
             *  把 PHAsset 加入到对应的 PHAssetCollection 中，系统推荐的方法是调用 placeholderForCreatedAsset ，
             *  返回一个的 placeholder 来代替刚创建的 PHAsset 的引用，并把该引用加入到一个 PHAssetCollectionChangeRequest 中。
             */
            [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
        }
        
    } completionHandler:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Creating asset of image error : %@", error);
        }
        
        if (completionHandler) {
            /**
             *  performChanges:completionHandler 不在主线程执行，若用户在该 block 中操作 UI 时会产生一些问题，
             *  为了避免这种情况，这里该 block 主动放到主线程执行。
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(success, creationDate, error);
            });
        }
    }];
}

+ (void)ba_showAlertWhenSavedPhotoFailuredByPermissionDeniedWithViewController:(UIViewController *)viewController
{
    NSArray *buttonTitleArray = @[@"知道了", @"去设置"];
    NSArray *buttonTitleColorArray = @[BAKit_Color_Green, BAKit_Color_Red];
    [UIAlertController ba_alertShowInViewController:viewController title:@"无法保存" message:@"你未开启“允许 BAKit 访问照片”选项" buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            NSURL *url = [[NSURL alloc] initWithString:@"prefs:root=Privacy&path=PHOTOS"];
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
}

@end
