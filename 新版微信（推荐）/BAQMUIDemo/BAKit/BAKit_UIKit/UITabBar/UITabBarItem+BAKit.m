//
//  UITabBarItem+BAKit.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UITabBarItem+BAKit.h"

@implementation UITabBarItem (BAKit)

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
                                     tag:(NSInteger)tag
{
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:tag];
    tabBarItem.selectedImage = selectedImage;
    if (selectedTitleColor)
    {
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : selectedTitleColor} forState:UIControlStateSelected];
    }
    
    return tabBarItem;
}

#pragma mark - setter / getter
- (void)setBa_tabBarItem_titleColor:(UIColor *)ba_tabBarItem_titleColor
{
    BAKit_Objc_setObj(@selector(ba_tabBarItem_titleColor), ba_tabBarItem_titleColor);
    NSDictionary <NSString *, id> *textAttributes = @{NSForegroundColorAttributeName: ba_tabBarItem_titleColor};
    [[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}

- (UIColor *)ba_tabBarItem_titleColor
{
    return BAKit_Objc_getObj;
}

- (void)setBa_tabBarItem_titleSelectedColor:(UIColor *)ba_tabBarItem_titleSelectedColor
{
    BAKit_Objc_setObj(@selector(ba_tabBarItem_titleSelectedColor), ba_tabBarItem_titleSelectedColor);
    NSDictionary <NSString *, id> *textAttributes = @{NSForegroundColorAttributeName: ba_tabBarItem_titleSelectedColor};
    [[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateSelected];
}

- (UIColor *)ba_tabBarItem_titleSelectedColor
{
    return BAKit_Objc_getObj;
}


@end
