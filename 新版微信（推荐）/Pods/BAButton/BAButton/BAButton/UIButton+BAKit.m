//
//  UIButton+BAKit.m
//  BAButtonDemo
//
//  Created by boai on 2017/5/17.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "UIButton+BAKit.h"
#import <objc/runtime.h>
#import "BAKit_ConfigurationDefine.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIImage (BAKit)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*!
 *  根据宽比例去缩放图片
 *
 *  @param width width description
 *
 *  @return return value description
 */
- (UIImage *)ba_imageScaleToWidth:(CGFloat)width
{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat old_width = imageSize.width;
    CGFloat old_height = imageSize.height;
    CGFloat targetWidth = width;
    CGFloat targetHeight = old_height / (old_width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, size) == NO)
    {
        CGFloat widthFactor = targetWidth / old_width;
        CGFloat heightFactor = targetHeight / old_height;
        if(widthFactor > heightFactor)
        {
            scaleFactor = widthFactor;
        }
        else
        {
            scaleFactor = heightFactor;
        }
        scaledWidth = old_width * scaleFactor;
        scaledHeight = old_height * scaleFactor;
        if(widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

@implementation UIButton (BAKit)

- (void)setupButtonLayout
{
    CGFloat image_w = self.imageView.bounds.size.width;
    CGFloat image_h = self.imageView.bounds.size.height;
    
    CGFloat title_w = self.titleLabel.bounds.size.width;
    CGFloat title_h = self.titleLabel.bounds.size.height;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        title_w = self.titleLabel.intrinsicContentSize.width;
        title_h = self.titleLabel.intrinsicContentSize.height;
    }

    UIEdgeInsets imageEdge = UIEdgeInsetsZero;
    UIEdgeInsets titleEdge = UIEdgeInsetsZero;
    
    if (self.ba_padding_inset == 0)
    {
        self.ba_padding_inset = 5;
    }
    
    switch (self.ba_buttonLayoutType) {
        case BAKit_ButtonLayoutTypeNormal:
        {
            
            titleEdge = UIEdgeInsetsMake(0, self.ba_padding, 0, 0);
            
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.ba_padding);
            
        }
            break;
        case BAKit_ButtonLayoutTypeCenterImageRight:
        {
            titleEdge = UIEdgeInsetsMake(0, -image_w - self.ba_padding, 0, image_w);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.ba_padding, 0, -title_w);
        }
            break;
        case BAKit_ButtonLayoutTypeCenterImageTop:
        {
            titleEdge = UIEdgeInsetsMake(0, -image_w, -image_h - self.ba_padding, 0);
            imageEdge = UIEdgeInsetsMake(-title_h - self.ba_padding, 0, 0, -title_w);
        }
            break;
        case BAKit_ButtonLayoutTypeCenterImageBottom:
        {
            titleEdge = UIEdgeInsetsMake(-image_h - self.ba_padding, -image_w, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, -title_h - self.ba_padding, -title_w);
        }
            break;
        case BAKit_ButtonLayoutTypeLeftImageLeft:
        {
            titleEdge = UIEdgeInsetsMake(0, self.ba_padding + self.ba_padding_inset, 0, 0);
            
            imageEdge = UIEdgeInsetsMake(0, self.ba_padding_inset, 0, 0);

            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case BAKit_ButtonLayoutTypeLeftImageRight:
        {
            titleEdge = UIEdgeInsetsMake(0, -image_w + self.ba_padding_inset, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.ba_padding + self.ba_padding_inset, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case BAKit_ButtonLayoutTypeRightImageLeft:
        {
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.ba_padding + self.ba_padding_inset);
            titleEdge = UIEdgeInsetsMake(0, 0, 0, self.ba_padding_inset);

            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case BAKit_ButtonLayoutTypeRightImageRight:
        {
            titleEdge = UIEdgeInsetsMake(0, 0, 0, image_w + self.ba_padding + self.ba_padding_inset);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, -title_w + self.ba_padding_inset);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
            
        default:
            break;
    }
    self.imageEdgeInsets = imageEdge;
    self.titleEdgeInsets = titleEdge;
}

/**
 快速设置 button 的布局样式 和 间距
 
 @param type button 的布局样式
 @param padding 文字与图片之间的间距
 */
- (void)ba_button_setButtonLayoutType:(BAKit_ButtonLayoutType)type padding:(CGFloat)padding
{
    self.ba_buttonLayoutType = type;
    self.ba_padding = padding;
}

/**
 快速切圆角
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 */
- (void)ba_button_setViewRectCornerType:(BAKit_ViewRectCornerType)type viewCornerRadius:(CGFloat)viewCornerRadius
{
    [self ba_view_setViewRectCornerType:type viewCornerRadius:viewCornerRadius];
}

/**
 快速切圆角，带边框、边框颜色
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 @param borderWidth 边线宽度
 @param borderColor 边线颜色
 */
- (void)ba_button_setViewRectCornerType:(BAKit_ViewRectCornerType)type
                       viewCornerRadius:(CGFloat)viewCornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
{
    [self ba_view_setViewRectCornerType:type viewCornerRadius:viewCornerRadius borderWidth:borderWidth borderColor:borderColor];
}

/* 给定框架创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
{
    return [UIButton initWithFrame:frame
                             title:nil];
}

/* 给定框架和字符串(字符串字体颜色默认是白色)创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
{
    return [UIButton initWithFrame:frame
                             title:title
                   backgroundImage:nil];
}

/* 给定框架、字符串和背景图片创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
    backgroundImage:(UIImage *)backgroundImage
{
    return [UIButton initWithFrame:frame
                             title:title
                   backgroundImage:backgroundImage
        highlightedBackgroundImage:nil];
}

/* 给定框架、字符串、背景图片和高亮背景图片创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
    backgroundImage:(UIImage *)backgroundImage
highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title
            forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundImage
                      forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackgroundImage
                      forState:UIControlStateHighlighted];
    return button;
}

/* 给定框架、字符串、颜色创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
              color:(UIColor *)color
{
    // 返回与'色'关联的颜色组件（包括透明度)
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [UIButton initWithFrame:frame
                             title:title
                   backgroundImage:[UIImage imageWithColor:color]
        highlightedBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:components[0]-0.1
                                                                           green:components[1]-0.1
                                                                            blue:components[2]-0.1
                                                                           alpha:1]]];
}

/* 给定框架、字符串、背景颜色和高亮背景颜色创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
              color:(UIColor *)color
   highlightedColor:(UIColor *)highlightedColor
{
    return [UIButton initWithFrame:frame
                             title:title
                   backgroundImage:[UIImage imageWithColor:color]
        highlightedBackgroundImage:[UIImage imageWithColor:highlightedColor]];
}

/* 给定框架、颜色创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              color:(UIColor *)color
{
    // 返回与'色'关联的颜色组件（包括透明度)
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [UIButton initWithFrame:frame
                             title:nil
                   backgroundImage:[UIImage imageWithColor:color]
        highlightedBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:components[0]-0.1
                                                                           green:components[1]-0.1
                                                                            blue:components[2]-0.1
                                                                           alpha:1]]];
}

/* 给定框架、背景颜色和高亮背景颜色创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              color:(UIColor *)color
   highlightedColor:(UIColor *)highlightedColor
{
    return [UIButton initWithFrame:frame
                             title:nil
                   backgroundImage:[UIImage imageWithColor:color]
        highlightedBackgroundImage:[UIImage imageWithColor:highlightedColor]];
}

/* 给定框架和图片创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              image:(UIImage *)image
{
    return [UIButton initWithFrame:frame
                             image:image
                  highlightedImage:nil];
}

/* 给定框架、背景图片和高亮背景图片创建一个UIButton对象 */
+ (id)initWithFrame:(CGRect)frame
              image:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:image
            forState:UIControlStateNormal];
    [button setImage:highlightedImage
            forState:UIControlStateHighlighted];
    return button;
}

/* 设置字符字体和大小 */
- (void)setTitleFont:(NSString *)fontName
                size:(CGFloat)size
{
    [self.titleLabel setFont:[UIFont fontWithName:fontName size:size]];
}

/* 设置字符颜色和高亮颜色 */
- (void)setTitleColor:(UIColor *)color
     highlightedColor:(UIColor *)highlightedColor
{
    [self setTitleColor:color
               forState:UIControlStateNormal];
    [self setTitleColor:highlightedColor
               forState:UIControlStateHighlighted];
}

#pragma mark - 快速创建 button
/**
 创建 button

 @param frame frame
 @param title title
 @param selTitle selTitle
 @param titleColor titleColor，默认：黑色
 @param titleFont titleFont默认：15
 @param image image description
 @param selImage selImage
 @param padding padding 文字图片间距
 @param buttonLayoutType buttonLayoutType 文字图片布局样式
 @param viewRectCornerType viewRectCornerType 圆角样式
 @param viewCornerRadius viewCornerRadius 圆角角度
 @param target target
 @param sel sel
 @return button
 */
+ (instancetype __nonnull)ba_creatButtonWithFrame:(CGRect)frame
                                            title:(NSString * __nullable)title
                                         selTitle:(NSString * __nullable)selTitle
                                       titleColor:(UIColor * __nullable)titleColor
                                        titleFont:(UIFont * __nullable)titleFont
                                            image:(UIImage * __nullable)image
                                         selImage:(UIImage * __nullable)selImage
                                          padding:(CGFloat)padding
                              buttonPositionStyle:(BAKit_ButtonLayoutType)buttonLayoutType
                               viewRectCornerType:(BAKit_ViewRectCornerType)viewRectCornerType
                                 viewCornerRadius:(CGFloat)viewCornerRadius
                                           target:(id __nullable)target
                                         selector:(SEL __nullable)sel
{
    UIButton *button = [[UIButton alloc] init];
    button.frame = frame;
    if (title)
    {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (selTitle)
    {
        [button setTitle:selTitle forState:UIControlStateSelected];
    }
    [button setTitleColor:titleColor ? titleColor : [UIColor blackColor] forState:UIControlStateNormal];
   
    button.titleLabel.font = titleFont ? titleFont : [UIFont systemFontOfSize:15.0f];
   
    if (selImage)
    {
        [button setImage:selImage forState:UIControlStateSelected];
    }
    if (image)
    {
        [button setImage:image forState:UIControlStateNormal];
    }
    [button ba_button_setButtonLayoutType:buttonLayoutType padding:padding];
    [button ba_button_setViewRectCornerType:viewRectCornerType viewCornerRadius:viewCornerRadius];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark - setter / getter
- (void)setBa_buttonLayoutType:(BAKit_ButtonLayoutType)ba_buttonLayoutType
{
    BAKit_Objc_setObj(@selector(ba_buttonLayoutType), @(ba_buttonLayoutType));
    [self setupButtonLayout];
}

- (BAKit_ButtonLayoutType)ba_buttonLayoutType
{
    return [BAKit_Objc_getObj integerValue];
}

- (void)setBa_padding:(CGFloat)ba_padding
{
    BAKit_Objc_setObj(@selector(ba_padding), @(ba_padding));
    [self setupButtonLayout];
}

- (CGFloat)ba_padding
{
    return [BAKit_Objc_getObj floatValue];
}

- (void)setBa_padding_inset:(CGFloat)ba_padding_inset
{
    BAKit_Objc_setObj(@selector(ba_padding_inset), @(ba_padding_inset));
    [self setupButtonLayout];
}

- (CGFloat)ba_padding_inset
{
    return [BAKit_Objc_getObj floatValue];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setupButtonLayout];
}

@end
NS_ASSUME_NONNULL_END

