//
//  NSObject+BAProgressHUD.h
//  demoTest
//
//  Created by 博爱 on 16/4/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface NSObject (BAProgressHUD)

/*!
*  弹出文字提示（菊花转动）
*
*  @param text 提示内容
*/
- (void)ba_hudShowText:(NSString *)text;

/*!
 *  弹出文字提示，自定义显示时间(默认1.5秒)
 *
 *  @param text 提示内容
 */
- (void)ba_hudShowText2:(NSString *)text;

/*!
 *  显示忙
 */
- (void)ba_hudShowBusy;

/*!
 *  隐藏提示
 */
- (void)ba_hudHideProgress;

@end
