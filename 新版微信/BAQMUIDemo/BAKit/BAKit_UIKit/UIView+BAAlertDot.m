//
//  UIView+BAAlertDot.m
//  BAQMUIDemo
//
//  Created by boai on 2017/5/4.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "UIView+BAAlertDot.h"

@implementation UIView (BAAlertDot)

#pragma mark -- 基本方法

/** 添加一个提示小圆点到调用此方法的view上（默认在父view右上方显示，距离父view上0右0，可以传递float类型的参数topOffset、rightOffset调整小圆点位置） */
- (void)ba_alertDot_showWithDotSize:(CGSize)size
                          topOffset:(CGFloat)topOffset
                        rightOffset:(CGFloat)rightOffset
{
    UIButton *dot = [self ba_alertDot_button];
    
    if (!dot.superview)
    {
        [self addSubview:dot];
        dot.backgroundColor = [UIColor redColor];
    }
    
    dot.width = size.width;
    dot.height = size.height;
    dot.left = self.width - dot.width - rightOffset;
    dot.top = topOffset;
    
    if (self.ba_alertDot_maxHeight > 0 && dot.height > self.ba_alertDot_maxHeight)
    {
        dot.height = self.ba_alertDot_maxHeight;
    }
    
    dot.layer.cornerRadius = dot.height * 0.5;
    dot.clipsToBounds = YES;
    
    dot.hidden = NO;
    [self bringSubviewToFront:dot];
}

/** 添加一个提示小圆点到调用此方法的view上（默认在父view右上方显示，距离父view上0右0，可以传递float类型的参数topOffset、rightOffset调整小圆点位置） */
- (void)ba_alertDot_showWithText:(NSString *)text
                    textFontSize:(CGFloat)fontSize
                       topOffset:(CGFloat)topOffset
                     rightOffset:(CGFloat)rightOffset
{
    self.ba_alertDot_text = text;
    self.ba_alertDot_button.titleLabel.font = BAKit_FontSystem_10;
    [self ba_alertDot_showWithDotSize:[self sizeWithText:text fontSize:fontSize] topOffset:topOffset rightOffset:rightOffset];
}

/** 删除view上的提示小圆点 */
- (void)ba_alertDot_hide
{
    UIView *view = [self ba_alertDot_button];
    view.hidden = YES;
}

- (BOOL)ba_isShowingAlertDot
{
    return self.ba_alertDot_button.superview != nil;
}

- (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)fontSize
{
    CGSize size = BAKit_LabelSizeWithTextAndFont(text, self.ba_alertDot_button.titleLabel.font);
    size.width += fontSize * 0.6;
    CGFloat wh = MAX(size.height, size.width);
    if (wh < 8)
    {
        wh = 8;
    }
    size.height = wh;
    size.width = wh;
    return size;
}

#pragma mark - setter / getter

/** 返回提示小圆点（UIButton类型） */
- (UIButton *)ba_alertDot_button
{
    return self.model.ba_alertDot_button;
}

- (UIColor *)ba_alertDot_color
{
    return [self ba_alertDot_button].backgroundColor;
}

- (void)setBa_alertDot_color:(UIColor *)ba_alertDot_color
{
    [[self ba_alertDot_button] setBackgroundColor:ba_alertDot_color];
}

- (NSString *)ba_alertDot_text
{
    return self.ba_alertDot_button.currentTitle;
}

- (void)setBa_alertDot_text:(NSString *)ba_alertDot_text
{
    [[self ba_alertDot_button] setTitle:ba_alertDot_text forState:UIControlStateNormal];
}

- (UIColor *)ba_alertDot_textColor
{
    return self.ba_alertDot_button.titleLabel.textColor;
}

- (void)setBa_alertDot_textColor:(UIColor *)ba_alertDot_textColor
{
    [[self ba_alertDot_button] setTitleColor:ba_alertDot_textColor forState:UIControlStateNormal];
}

- (void)setBa_alertDot_maxHeight:(CGFloat)ba_alertDot_maxHeight
{
    self.model.ba_alertDot_maxHeight = ba_alertDot_maxHeight;
}

- (CGFloat)ba_alertDot_maxHeight
{
    return self.model.ba_alertDot_maxHeight;
}



@end
