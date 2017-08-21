//
//  UITabBarController+BAKit.h
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (BAKit)


/**
 tabBar：默认选中颜色
 */
@property(nonatomic, strong) UIColor *ba_tabBar_tintColor;

/**
 tabBar：默认背景颜色
 */
@property(nonatomic, strong) UIColor *ba_tabBar_backgroundColor;

/**
 tabBar：默认背景图片
 */
@property(nonatomic, strong) UIImage *ba_tabBar_backgroundImage;

@end
