//
//  CALayer+BAAnimation.h
//  BAQMUIDemo
//
//  Created by boai on 2017/5/28.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (BAAnimation)

/**
 摇晃动画：用于错误提示
 
 @param value 晃动的幅度，默认：5.0f
 @param repeatCount 晃动的次数，默认：5.0f
 */
- (void)ba_layer_animationShakeWithValue:(CGFloat)value repeatCount:(CGFloat)repeatCount;

@end
