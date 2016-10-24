//
//  BACommon.h
//  博爱微信
//
//  Created by 博爱 on 2016/10/24.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/NSObject.h>
#import <CoreLocation/CoreLocation.h>


@interface BACommon : NSObject

/*!
 *  将图片保存到应用程序沙盒中去,imageNameString的格式为 @"upLoad.png"
 *
 *  @param image           image description
 *  @param imageNameString imageNameString description
 */
+ (void)ba_saveImagetoLocal:(UIImage*)image imageName:(NSString *)imageNameString;

/*!
 *  与服务端连接已断开,请检查您的网络连接是否正常.
 */
+ (void)ba_showNoReachabileTips;



@end
