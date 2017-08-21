//
//  UIImage+BAKit.h
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BAKit)

/**
 创建一个 高斯模糊 图片
 
 @param radius 模糊的半径
 @return 高斯模糊 图片
 */
- (UIImage *)ba_imageGaussianBlur:(CGFloat)radius;

@end
