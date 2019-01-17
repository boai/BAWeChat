//
//  UINavigationBar+BAKit.h
//  BABaseProject
//
//  Created by 博爱 on 16/7/18.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BAKit)

/*!
 *  设置背景颜色
 *
 *  @param backgroundColor backgroundColor
 */
- (void)ba_naviSetBackgroundColor:(UIColor *)backgroundColor;

/*!
 *  设置alpha
 *
 *  @param alpha alpha
 */
- (void)ba_naviSetElementsAlpha:(CGFloat)alpha;

/*!
 *  设置Y
 *
 *  @param translationY translationY
 */
- (void)ba_naviSetTranslationY:(CGFloat)translationY;

//- (void)ba_naviSetTintColor:(UIColor *)tintColor;

/*!
 *  重置
 */
- (void)ba_naviReset;

@end
