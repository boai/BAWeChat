//
//  UIColor+BAKit.h
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BAKit)

/**
 创建一个 hex 颜色
 
 @param hexstring hex
 @param alpha alpha
 @return 颜色
 */
+ (UIColor *)ba_colorWithHex:(NSString *)hexstring andAlpha:(CGFloat)alpha;

@end
