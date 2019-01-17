//
//  UIButton+BAKit.m
//  BAButtonDemo
//
//  Created by boai on 2017/5/17.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "UIButton+BAKit.h"
#import <objc/runtime.h>
#import <AudioToolbox/AudioToolbox.h>

#import "BAKit_ConfigurationDefine.h"


@implementation UIImage (BAButton)

/**
 UIImage：创建一个 纯颜色 图片【全部铺满】
 
 @param color color
 @return 纯颜色 图片
 */
+ (UIImage *)ba_image_Color:(UIColor *)color
{
    UIImage *image = [self ba_image_Color:color size:CGSizeMake(1.0f, 1.0f)];
    return image;
}

/**
 UIImage：创建一个 纯颜色 图片【可以设置 size】
 
 @param color color
 @param size size
 @return 纯颜色 图片
 */
+ (UIImage *)ba_image_Color:(UIColor *)color size:(CGSize)size
{
    CGRect rect          = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *image       = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 UIImage：根据宽比例去缩放图片

 @param width width description
 @return UIImage
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


@interface UIView (BAButton)

/**
 UIView：给 View 添加点击音效（一般用于 button 按钮的点击音效），注意，此方法不带播放结束回调，如果需要播放结束回调，请将 .m 文件中的 C 函数（soundCompleteCallBack）回调复制到播放按钮的.m 里，在里面做相关处理即可
 
 @param filename 音乐文件名称
 @param isNeedShock 是否播放音效并震动
 */
- (void)ba_viewPlaySoundEffectWithFileName:(NSString *)filename
                               isNeedShock:(BOOL)isNeedShock;

@end

@implementation UIView (BAButton)


/**
 UIView：点击音效结束后的回调，实际情况可参考里面注释
 
 @param soundID soundID description
 @param clientData clientData description
 */
void soundCompleteCallback(SystemSoundID soundID, void *clientData) {
    NSLog(@"播放完成");
    //    AudioServicesRemoveSystemSoundCompletion (mySSID);
    //    UILabel *label = (__bridge UILabel *)data;
    //    label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
}

/**
 UIView：给 View 添加点击音效（一般用于 button 按钮的点击音效），注意，此方法不带播放结束回调，如果需要播放结束回调，请将 .m 文件中的 C 函数（soundCompleteCallBack）回调复制到播放按钮的.m 里，在里面做相关处理即可
 
 @param filename 音乐文件名称
 @param isNeedShock 是否播放音效并震动
 */
- (void)ba_viewPlaySoundEffectWithFileName:(NSString *)filename
                               isNeedShock:(BOOL)isNeedShock
{
    // 1、判断文件名是否为空
    if (filename == nil)
    {
        return;
    }
    [self ba_viewStopAlertSound];
    
    // 1、获取音效文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    // 2、创建音效文件 URL
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    // 3、音效声音的唯一标示 soundID
    SystemSoundID soundID = 0;
    
    /**
     * inFileUrl: 音频文件 url
     * outSystemSoundID: 声音 id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    // 4、将音效加入到系统音效服务中，NSURL 需要桥接成 CFURLRef，会返回一个长整形 soundID，用来做音效的唯一标示
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 6、播放音频
    AudioServicesPlaySystemSound(soundID);
    
    if (isNeedShock)
    {
        // 7、播放音效并震动
        AudioServicesPlayAlertSound(soundID);
    }
    
    // 保存
    // 立即同步
    [BAKit_NSUserDefaults setObject:@(soundID).stringValue forKey:@"soundID"];
    [BAKit_NSUserDefaults synchronize];

}

/**
 UIView：停止播放音乐（按钮点击音效的停止）
 */
- (void)ba_viewStopAlertSound
{
    NSString *soundIDString = [BAKit_NSUserDefaults objectForKey:@"soundID"];
    
    NSAssert(soundIDString.length, @"soundID 不能为空！");

    SystemSoundID soundID = [soundIDString intValue];
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(soundID);
    AudioServicesRemoveSystemSoundCompletion(soundID);
}

@end

@implementation UIButton (BAKit)

- (void)setupBAButtonLayout
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

#pragma mark - 快速创建 button

/**
 UIButton：快速创建 button1：frame、title、titleColor、titleFont
 
 @param frame frame
 @param title title
 @param titleColor titleColor
 @param titleFont titleFont
 @return button
 */
+ (id)ba_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
              titleColor:(UIColor * __nullable)titleColor
               titleFont:(UIFont * __nullable)titleFont
{
    UIButton *button = [UIButton ba_buttonWithFrame:frame title:title titleColor:titleColor titleFont:titleFont backgroundColor:nil];
    
    return button;
}

/**
 UIButton：快速创建 button2：frame、title、backgroundColor
 
 @param frame frame
 @param title title
 @param backgroundColor backgroundColor
 @return button
 */
+ (id)ba_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
         backgroundColor:(UIColor * __nullable)backgroundColor
{
    UIButton *button = [UIButton ba_buttonWithFrame:frame title:title titleColor:nil titleFont:nil backgroundColor:backgroundColor];
    
    return button;
}

/**
 UIButton：快速创建 button3：frame、title、titleColor、titleFont、backgroundColor
 
 @param frame frame
 @param title title
 @param titleColor titleColor
 @param titleFont titleFont
 @param backgroundColor backgroundColor
 @return button
 */
+ (id)ba_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
              titleColor:(UIColor * __nullable)titleColor
               titleFont:(UIFont * __nullable)titleFont
         backgroundColor:(UIColor * __nullable)backgroundColor
{
    UIButton *button = [UIButton ba_buttonWithFrame:frame title:title titleColor:titleColor titleFont:titleFont image:nil backgroundColor:backgroundColor];
    
    return button;
}

/**
 UIButton：快速创建 button4：frame、title、backgroundImage
 
 @param frame frame
 @param title title
 @param backgroundImage backgroundImage
 @return button
 */
+ (id)ba_buttonWithFrame:(CGRect)frame
                   title:(NSString * __nullable)title
         backgroundImage:(UIImage * __nullable)backgroundImage
{
    UIButton *button = [UIButton ba_buttonWithFrame:frame title:title titleColor:nil titleFont:nil image:nil backgroundImage:backgroundImage];
    return button;
}

/**
 UIButton：快速创建 button5：frame、title、titleColor、titleFont、image、backgroundColor
 
 @param frame frame description
 @param title title description
 @param titleColor titleColor description
 @param titleFont titleFont description
 @param image image description
 @param backgroundColor backgroundColor description
 @return button
 */
+ (instancetype)ba_buttonWithFrame:(CGRect)frame
                             title:(NSString * __nullable)title
                        titleColor:(UIColor * __nullable)titleColor
                         titleFont:(UIFont * __nullable)titleFont
                             image:(UIImage * __nullable)image
                   backgroundColor:(UIColor * __nullable)backgroundColor
{
    UIButton *button = [UIButton ba_buttonWithFrame:frame title:title selectedTitle:nil highlightedTitle:nil titleColor:titleColor selectedTitleColor:nil highlightedTitleColor:nil titleFont:titleFont image:image selectedImage:nil highlightedImage:nil backgroundImage:nil selectedBackgroundImage:nil highlightedBackgroundImage:nil backgroundColor:backgroundColor];
    
    return button;
}

/**
 UIButton：快速创建 button6：frame、title、titleColor、titleFont、image、backgroundImage
 
 @param frame frame description
 @param title title description
 @param titleColor titleColor description
 @param titleFont titleFont description
 @param image image description
 @param backgroundImage backgroundImage description
 @return button
 */
+ (instancetype)ba_buttonWithFrame:(CGRect)frame
                             title:(NSString * __nullable)title
                        titleColor:(UIColor * __nullable)titleColor
                         titleFont:(UIFont * __nullable)titleFont
                             image:(UIImage * __nullable)image
                   backgroundImage:(UIImage * __nullable)backgroundImage
{
    UIButton *button = [UIButton ba_buttonWithFrame:frame title:title selectedTitle:nil highlightedTitle:nil titleColor:titleColor selectedTitleColor:nil highlightedTitleColor:nil titleFont:titleFont image:image selectedImage:nil highlightedImage:nil backgroundImage:backgroundImage selectedBackgroundImage:nil highlightedBackgroundImage:nil backgroundColor:nil];
    
    return button;
}


/**
 UIButton：快速创建 button7：大汇总-点击事件、圆角
 
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
    UIButton *button = [UIButton ba_buttonWithFrame:frame title:title selectedTitle:selTitle highlightedTitle:nil titleColor:titleColor selectedTitleColor:nil highlightedTitleColor:nil titleFont:titleFont image:image selectedImage:selImage highlightedImage:nil backgroundImage:nil selectedBackgroundImage:nil highlightedBackgroundImage:nil backgroundColor:nil];
    [button ba_button_setButtonLayoutType:buttonLayoutType padding:padding];
    [button ba_button_setViewRectCornerType:viewRectCornerType viewCornerRadius:viewCornerRadius];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/**
 UIButton：快速创建 button8：大汇总-所有 normal、selected、highlighted 样式都有
 
 @param frame frame
 @param title title description
 @param selectedTitle selectedTitle description
 @param highlightedTitle highlightedTitle description
 @param titleColor titleColor description
 @param selectedTitleColor selectedTitleColor description
 @param highlightedTitleColor highlightedTitleColor description
 @param titleFont titleFont description
 @param image image description
 @param selectedImage selectedImage description
 @param highlightedImage highlightedImage description
 @param backgroundImage backgroundImage description
 @param selectedBackgroundImage selectedBackgroundImage description
 @param highlightedBackgroundImage highlightedBackgroundImage description
 @param backgroundColor backgroundColor description
 @return button
 */
+ (instancetype)ba_buttonWithFrame:(CGRect)frame
                             title:(NSString * __nullable)title
                     selectedTitle:(NSString * __nullable)selectedTitle
                  highlightedTitle:(NSString * __nullable)highlightedTitle
                        titleColor:(UIColor * __nullable)titleColor
                selectedTitleColor:(UIColor * __nullable)selectedTitleColor
             highlightedTitleColor:(UIColor * __nullable)highlightedTitleColor
                         titleFont:(UIFont * __nullable)titleFont
                             image:(UIImage * __nullable)image
                     selectedImage:(UIImage * __nullable)selectedImage
                  highlightedImage:(UIImage * __nullable)highlightedImage
                   backgroundImage:(UIImage * __nullable)backgroundImage
           selectedBackgroundImage:(UIImage * __nullable)selectedBackgroundImage
        highlightedBackgroundImage:(UIImage * __nullable)highlightedBackgroundImage
                   backgroundColor:(UIColor * __nullable)backgroundColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    [button ba_buttonSetTitle:title selectedTitle:selectedTitle highlightedTitle:highlightedTitle];
    if (!titleColor)
    {
        titleColor = [UIColor blackColor];
    }
    [button ba_buttonSetTitleColor:titleColor selectedTitleColor:selectedTitleColor highlightedTitleColor:highlightedTitleColor disabledTitleColor:nil];
    button.titleLabel.font = titleFont ? titleFont : [UIFont systemFontOfSize:15.0f];
    
    [button ba_buttonSetImage:image selectedImage:selectedImage highlightedImage:highlightedImage disabledImage:nil];
    
    [button ba_buttonSetBackgroundImage:backgroundImage selectedBackgroundImage:selectedBackgroundImage highlightedBackgroundImage:highlightedBackgroundImage];
    
    [button ba_buttonSetBackgroundColor:backgroundColor];
    
    return button;
}

/**
 UIButton：快速创建一个纯文字 button

 @param frame frame description
 @param title title description
 @param font font description
 @param horizontalAlignment horizontalAlignment description
 @param verticalAlignment verticalAlignment description
 @param contentEdgeInsets contentEdgeInsets description
 @param target target description
 @param action action description
 @param normalStateColor normalStateColor description
 @param highlightedStateColor highlightedStateColor description
 @param disabledStateColor disabledStateColor description
 @return UIButton
 */
+ (UIButton *)ba_buttonLabelButtonWithFrame:(CGRect)frame
                                      title:(NSString *)title
                                       font:(UIFont *)font
                        horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                          verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                          contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                                     target:(id)target
                                     action:(SEL)action
                           normalTitleColor:(UIColor *)normalStateColor
                      highlightedTitleColor:(UIColor *)highlightedStateColor
                         disabledTitleColor:(UIColor *)disabledStateColor
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    
    button.contentHorizontalAlignment = horizontalAlignment;
    button.contentVerticalAlignment   = verticalAlignment;
    button.contentEdgeInsets          = contentEdgeInsets;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button ba_buttonSetTitleColor:normalStateColor selectedTitleColor:nil highlightedTitleColor:highlightedStateColor disabledTitleColor:disabledStateColor];
    
    return button;
}

/**
 UIButton：快速创建一个纯图片 button

 @param frame frame description
 @param horizontalAlignment horizontalAlignment description
 @param verticalAlignment verticalAlignment description
 @param contentEdgeInsets contentEdgeInsets description
 @param normalImage normalImage description
 @param highlightImage highlightImage description
 @param disabledImage disabledImage description
 @param target target description
 @param action action description
 @return UIButton
 */
+ (UIButton *)ba_buttonImageButtonWithFrame:(CGRect)frame
                        horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                          verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                          contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                                normalImage:(UIImage *)normalImage
                             highlightImage:(UIImage *)highlightImage
                              disabledImage:(UIImage *)disabledImage
                                     target:(id)target
                                     action:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    
    button.contentHorizontalAlignment = horizontalAlignment;
    button.contentVerticalAlignment   = verticalAlignment;
    button.contentEdgeInsets          = contentEdgeInsets;
    
    [button ba_buttonSetImage:normalImage selectedImage:nil highlightedImage:highlightImage disabledImage:disabledImage];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return button;
}

#pragma mark - 自定义：button
/**
 UIButton：自定义 button backgroundColor
 
 @param backgroundColor backgroundColor
 */
- (void)ba_buttonSetBackgroundColor:(UIColor * __nullable)backgroundColor
{
    if (backgroundColor)
    {
        self.backgroundColor = backgroundColor;
    }
}

/**
 UIButton：backgroundColor、normalStateColor、highlightedStateColor、disabledStateColor

 @param normalStateColor normalStateColor description
 @param highlightedStateColor highlightedStateColor description
 @param disabledStateColor disabledStateColor description
 */
- (void)ba_buttonBackgroundColorWithNormalStateColor:(UIColor *)normalStateColor
                               highlightedStateColor:(UIColor *)highlightedStateColor
                                  disabledStateColor:(UIColor *)disabledStateColor
{
    if (normalStateColor)
    {
        [self setBackgroundImage:[UIImage ba_image_Color:normalStateColor size:CGSizeMake(5, 5)] forState:UIControlStateNormal];
    }
    
    if (highlightedStateColor)
    {
        [self setBackgroundImage:[UIImage ba_image_Color:highlightedStateColor size:CGSizeMake(5, 5)] forState:UIControlStateHighlighted];
    }
    
    if (disabledStateColor)
    {
        [self setBackgroundImage:[UIImage ba_image_Color:disabledStateColor size:CGSizeMake(5, 5)] forState:UIControlStateDisabled];
    }
}

/**
 UIButton：自定义 button backgroundImage、selectedBackgroundImage、highlightedBackgroundImage
 
 @param backgroundImage backgroundImage
 @param selectedBackgroundImage selectedBackgroundImage
 @param highlightedBackgroundImage highlightedBackgroundImage
 */
- (void)ba_buttonSetBackgroundImage:(UIImage * __nullable)backgroundImage
            selectedBackgroundImage:(UIImage * __nullable)selectedBackgroundImage
         highlightedBackgroundImage:(UIImage * __nullable)highlightedBackgroundImage
{
    if (backgroundImage)
    {
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    
    if (selectedBackgroundImage)
    {
        [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    }
    if (highlightedBackgroundImage)
    {
        [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    }
}

/**
 UIButton：自定义 button image、selectedImage、highlightedImage、disabledImage
 
 @param image image
 @param selectedImage selectedImage
 @param highlightedImage highlightedImage
 @param disabledImage disabledImage
 */
- (void)ba_buttonSetImage:(UIImage * __nullable)image
            selectedImage:(UIImage * __nullable)selectedImage
         highlightedImage:(UIImage * __nullable)highlightedImage
            disabledImage:(UIImage * __nullable)disabledImage
{
    if (image)
    {
        [self setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage)
    {
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
    if (highlightedImage)
    {
        [self setImage:highlightedImage forState:UIControlStateHighlighted];
    }
}

/**
 UIButton：自定义 button title、selectedTitle、highlightedTitle
 
 @param title title
 @param selectedTitle selectedTitle
 @param highlightedTitle highlightedTitle
 */
- (void)ba_buttonSetTitle:(NSString * __nullable)title
            selectedTitle:(NSString * __nullable)selectedTitle
         highlightedTitle:(NSString * __nullable)highlightedTitle
{
    [self setTitle:title forState:UIControlStateNormal];
    if (selectedTitle)
    {
        [self setTitle:selectedTitle forState:UIControlStateSelected];
    }
    else
    {
        [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
    }
}

/**
 UIButton：自定义 button titleColor、selectedTitleColor、highlightedTitleColor、disabledTitleColor
 
 @param titleColor titleColor
 @param selectedTitleColor selectedTitleColor
 @param highlightedTitleColor highlightedTitleColor
 @param disabledTitleColor disabledTitleColor
 */
- (void)ba_buttonSetTitleColor:(UIColor * __nullable)titleColor
            selectedTitleColor:(UIColor * __nullable)selectedTitleColor
         highlightedTitleColor:(UIColor * __nullable)highlightedTitleColor
            disabledTitleColor:(UIColor * __nullable)disabledTitleColor
{
    if (titleColor)
    {
        [self setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (selectedTitleColor)
    {
        [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    if (highlightedTitleColor)
    {
        [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
    }
    if (disabledTitleColor)
    {
        [self setTitleColor:disabledTitleColor forState:UIControlStateDisabled];
    }
}

/**
 UIButton：自定义 button 字体、大小
 
 @param fontName fontName
 @param size size
 */
- (void)ba_buttonSetTitleFontName:(NSString *)fontName
                             size:(CGFloat)size
{
    [self.titleLabel setFont:[UIFont fontWithName:fontName size:size]];
}

/**
 UIButton：自定义 button 点击事件，默认：UIControlEventTouchUpInside
 
 @param target target
 @param tag tag
 @param action action
 */
- (void)ba_buttonAddTarget:(nullable id)target
                       tag:(NSInteger)tag
                    action:(SEL)action
{
    self.tag = tag;
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

///**
// UIButton：自定义 button 点击事件 block 返回，默认：UIControlEventTouchUpInside
// 
// @param actionBlock actionBlock description
// */
//- (void)ba_buttonTouchActionBlock:(BAKit_UIButtonActionBlock)actionBlock
//{
//    [self addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//}

- (void)handleButtonAction:(UIButton *)sender
{
    if (self.ba_buttonActionBlock)
    {
        self.ba_buttonActionBlock(sender);
    }
}

/**
 UIButton：快速设置 button 的布局样式 和 间距
 
 @param type button 的布局样式
 @param padding 文字与图片之间的间距
 */
- (void)ba_button_setButtonLayoutType:(BAKit_ButtonLayoutType)type padding:(CGFloat)padding
{
    self.ba_buttonLayoutType = type;
    self.ba_padding = padding;
}

/**
 UIButton：快速切圆角，注意：文字、字体大小、图片等设置一定要在设置 ba_button_setButtonLayoutType 之前设置，要不然计算会以默认字体大小计算，导致位置偏移，如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 */
- (void)ba_button_setViewRectCornerType:(BAKit_ViewRectCornerType)type viewCornerRadius:(CGFloat)viewCornerRadius
{
    [self ba_view_setViewRectCornerType:type viewCornerRadius:viewCornerRadius];
}

/**
 UIButton：快速切圆角，带边框、边框颜色，如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效
 
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

/**
 UIButton：title 位置

 @param horizontalAlignment horizontalAlignment description
 @param verticalAlignment verticalAlignment description
 @param contentEdgeInsets contentEdgeInsets description
 */
- (void)ba_buttonTitleLabelHorizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                              verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                              contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    self.contentHorizontalAlignment = horizontalAlignment;
    self.contentVerticalAlignment   = verticalAlignment;
    self.contentEdgeInsets          = contentEdgeInsets;
}

/**
 UIButton：给 Button 添加点击音效，注意，此方法不带播放结束回调，如果需要播放结束回调，请将 .m 文件中的 C 函数（soundCompleteCallBack）回调复制到播放按钮的.m 里，在里面做相关处理即可
 
 @param name 音乐文件名称
 @param isNeedShock 是否播放音效并震动
 */
- (void)ba_buttonPlaySoundEffectWithFileName:(NSString *)name
                                 isNeedShock:(BOOL)isNeedShock
{
    [self ba_viewPlaySoundEffectWithFileName:name isNeedShock:isNeedShock];
}

#pragma mark - setter / getter
- (void)setBa_buttonLayoutType:(BAKit_ButtonLayoutType)ba_buttonLayoutType
{
    BAKit_Objc_setObj(@selector(ba_buttonLayoutType), @(ba_buttonLayoutType));
    [self setupBAButtonLayout];
}

- (BAKit_ButtonLayoutType)ba_buttonLayoutType
{
    return [BAKit_Objc_getObj integerValue];
}

- (void)setBa_padding:(CGFloat)ba_padding
{
    BAKit_Objc_setObj(@selector(ba_padding), @(ba_padding));
    [self setupBAButtonLayout];
}

- (CGFloat)ba_padding
{
    return [BAKit_Objc_getObj floatValue];
}

- (void)setBa_padding_inset:(CGFloat)ba_padding_inset
{
    BAKit_Objc_setObj(@selector(ba_padding_inset), @(ba_padding_inset));
    [self setupBAButtonLayout];
}

- (CGFloat)ba_padding_inset
{
    return [BAKit_Objc_getObj floatValue];
}

- (void)setBa_buttonActionBlock:(BAKit_UIButtonActionBlock)ba_buttonActionBlock
{
    [self addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    BAKit_Objc_setObj(@selector(ba_buttonActionBlock), ba_buttonActionBlock);
}

- (BAKit_UIButtonActionBlock)ba_buttonActionBlock
{
    return BAKit_Objc_getObj;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setupBAButtonLayout];
}

@end

