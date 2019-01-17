//
//  UIView+BARectCorner.m
//  BAButton
//
//  Created by boai on 2017/5/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIView+BARectCorner.h"
#import "BAKit_ConfigurationDefine.h"

@implementation UIView (BARectCorner)

- (void)ba_view_setViewRectCornerType:(BAKit_ViewRectCornerType)type
                     viewCornerRadius:(CGFloat)viewCornerRadius
{
    self.ba_viewCornerRadius = viewCornerRadius;
    self.ba_viewRectCornerType = type;
}

/**
 快速切圆角，带边框、边框颜色
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 @param borderWidth 边线宽度
 @param borderColor 边线颜色
 */
- (void)ba_view_setViewRectCornerType:(BAKit_ViewRectCornerType)type
                     viewCornerRadius:(CGFloat)viewCornerRadius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
{
    self.ba_viewCornerRadius = viewCornerRadius;
    self.ba_viewRectCornerType = type;
    self.ba_viewBorderWidth = borderWidth;
    self.ba_viewBorderColor = borderColor;
}

#pragma mark - view 的 角半径，默认 CGSizeMake(0, 0)
- (void)setupViewCornerType
{
    UIRectCorner corners;
    CGSize cornerRadii;
    
    cornerRadii = CGSizeMake(self.ba_viewCornerRadius, self.ba_viewCornerRadius);
    if (self.ba_viewCornerRadius == 0)
    {
        cornerRadii = CGSizeMake(0, 0);
    }
    
    switch (self.ba_viewRectCornerType)
    {
        case BAKit_ViewRectCornerTypeBottomLeft:
        {
            corners = UIRectCornerBottomLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomRight:
        {
            corners = UIRectCornerBottomRight;
        }
            break;
        case BAKit_ViewRectCornerTypeTopLeft:
        {
            corners = UIRectCornerTopLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeTopRight:
        {
            corners = UIRectCornerTopRight;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomLeftAndBottomRight:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
            break;
        case BAKit_ViewRectCornerTypeTopLeftAndTopRight:
        {
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomLeftAndTopLeft:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomRightAndTopRight:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomRightAndTopRightAndTopLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomRightAndTopRightAndBottomLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeAllCorners:
        {
            corners = UIRectCornerAllCorners;
        }
            break;
            
        default:
            break;
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:corners
                                                           cornerRadii:cornerRadii];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.frame = self.bounds;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = bezierPath.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = self.ba_viewBorderColor.CGColor;
    borderLayer.lineWidth = self.ba_viewBorderWidth;
    borderLayer.frame = self.bounds;
    
    self.layer.mask = shapeLayer;
    [self.layer addSublayer:borderLayer];
//    self.clipsToBounds = YES;
}

#pragma mark - setter / getter
- (void)setBa_viewRectCornerType:(BAKit_ViewRectCornerType)ba_viewRectCornerType
{
    BAKit_Objc_setObj(@selector(ba_viewRectCornerType), @(ba_viewRectCornerType));
    [self setupViewCornerType];
}

- (BAKit_ViewRectCornerType)ba_viewRectCornerType
{
    return [BAKit_Objc_getObj integerValue];
}

- (void)setBa_viewCornerRadius:(CGFloat)ba_viewCornerRadius
{
    BAKit_Objc_setObj(@selector(ba_viewCornerRadius), @(ba_viewCornerRadius));
}

- (CGFloat)ba_viewCornerRadius
{
    return [BAKit_Objc_getObj integerValue];
}

- (void)setBa_viewBorderWidth:(CGFloat)ba_viewBorderWidth
{
    BAKit_Objc_setObj(@selector(ba_viewBorderWidth), @(ba_viewBorderWidth));
    [self setupViewCornerType];
}

- (CGFloat)ba_viewBorderWidth
{
    return [BAKit_Objc_getObj floatValue];
}

- (void)setBa_viewBorderColor:(UIColor *)ba_viewBorderColor
{
    BAKit_Objc_setObj(@selector(ba_viewBorderColor), ba_viewBorderColor);
    [self setupViewCornerType];
}

- (UIColor *)ba_viewBorderColor
{
    return BAKit_Objc_getObj;
}

@end
