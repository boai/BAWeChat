//
//  UIDevice+BAKit.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "UIDevice+BAKit.h"

@implementation UIDevice (BAKit)

/*!
 *  强制锁定屏幕方向
 *
 *  @param orientation 屏幕方向
 */
+ (void)ba_deviceInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

@end
