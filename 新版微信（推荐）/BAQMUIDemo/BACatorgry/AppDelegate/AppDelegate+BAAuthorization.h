//
//  AppDelegate+BAAuthorization.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BAAuthorization)

/*!
 *  获取所有权限
 */
- (void)ba_authorizationAll;

/*!
 *  获取通讯录权限
 */
- (void)ba_authorizationAddressBook;

@end
