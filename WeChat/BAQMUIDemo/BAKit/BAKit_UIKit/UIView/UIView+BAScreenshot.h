//
//  UIView+BAScreenshot.h
//  BAQMUIDemo
//
//  Created by boai on 2017/5/27.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BAScreenshot)


/**
 获取当前屏幕截图

 @return 当前屏幕截图
 */
- (UIImage *)ba_viewGetImageShot;

/**
 保存当前屏幕截图

 @return 当前屏幕截图
 */
- (UIImage *)ba_viewSaveScreenshot;

@end
