//
//  UITabBarItem+BAKit.h
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (BAKit)

/**
 tabBarItem：默认非选中颜色，注意：只需在第一个 VC 后面设置即可，其他 VC 无需设置
 */
@property(nonatomic, strong) UIColor *ba_tabBarItem_titleColor;

/**
 tabBarItem：默认选中颜色，注意：只需在第一个 VC 后面设置即可，其他 VC 无需设置
 */
@property(nonatomic, strong) UIColor *ba_tabBarItem_titleSelectedColor;

/**
 快速创建 UITabBarItem
 
 @param title title
 @param image image
 @param selectedImage selectedImage
 @param selectedTitleColor selectedTitleColor
 @param tag tag
 @return UITabBarItem
 */
+ (UITabBarItem *)ba_tabBarItemWithTitle:(NSString *)title
                                   image:(UIImage *)image
                           selectedImage:(UIImage *)selectedImage
                      selectedTitleColor:(UIColor *)selectedTitleColor
                                     tag:(NSInteger)tag;

@end
