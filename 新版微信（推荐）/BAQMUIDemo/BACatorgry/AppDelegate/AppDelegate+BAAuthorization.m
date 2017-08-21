//
//  AppDelegate+BAAuthorization.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate+BAAuthorization.h"
#import "PPGetAddressBook.h"

@implementation AppDelegate (BAAuthorization)

#pragma mark - 获取所有权限
- (void)ba_authorizationAll
{
    [self ba_authorizationAddressBook];
    
}

#pragma mark - 获取通讯录权限
- (void)ba_authorizationAddressBook
{
    [PPGetAddressBook requestAddressBookAuthorization];
}

@end
