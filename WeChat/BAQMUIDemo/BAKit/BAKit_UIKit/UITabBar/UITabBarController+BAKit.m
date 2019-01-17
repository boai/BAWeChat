//
//  UITabBarController+BAKit.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UITabBarController+BAKit.h"

@implementation UITabBarController (BAKit)

- (void)setBa_tabBar_tintColor:(UIColor *)ba_tabBar_tintColor
{
    BAKit_Objc_setObj(@selector(ba_tabBar_tintColor), ba_tabBar_tintColor);
    [UITabBar appearance].tintColor = ba_tabBar_tintColor;
}

- (UIColor *)ba_tabBar_tintColor
{
    return BAKit_Objc_getObj;
}

- (void)setBa_tabBar_backgroundColor:(UIColor *)ba_tabBar_backgroundColor
{
    BAKit_Objc_setObj(@selector(ba_tabBar_backgroundColor), ba_tabBar_backgroundColor);
    [UITabBar appearance].backgroundImage = [UIImage ba_image_Color:ba_tabBar_backgroundColor];
}

- (UIColor *)ba_tabBar_backgroundColor
{
    return BAKit_Objc_getObj;
}

- (void)setBa_tabBar_backgroundImage:(UIImage *)ba_tabBar_backgroundImage
{
    BAKit_Objc_setObj(@selector(ba_tabBar_backgroundImage), ba_tabBar_backgroundImage);
    [UITabBar appearance].backgroundImage = ba_tabBar_backgroundImage;
}

- (UIImage *)ba_tabBar_backgroundImage
{
    return BAKit_Objc_getObj;
}

@end
