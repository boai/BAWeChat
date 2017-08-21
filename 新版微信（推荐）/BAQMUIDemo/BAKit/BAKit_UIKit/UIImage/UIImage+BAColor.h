//
//  UIImage+BAColor.h
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BAColor)

/**
 创建一个 纯颜色 图片【全部铺满】
 
 @param color color
 @return 纯颜色 图片
 */
+ (UIImage *)ba_image_Color:(UIColor *)color;

/**
 创建一个 纯颜色 图片【可以设置 size】
 
 @param color color
 @param size size
 @return 纯颜色 图片
 */
+ (UIImage *)ba_image_Color:(UIColor *)color size:(CGSize)size;

@end
