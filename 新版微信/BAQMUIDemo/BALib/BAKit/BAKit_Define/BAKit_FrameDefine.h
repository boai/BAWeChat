//
//  BAKit_FrameDefine.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#ifndef BAKit_FrameDefine_h
#define BAKit_FrameDefine_h

#pragma mark - TimeLine
#define kMargin_5       5
#define kMargin_10      10
#define kMargin_15      15
#define kMargin_20      20
#define kMargin_25      25
#define kMargin_30      30
#define kMargin_35      35
#define kMargin_40      40

#define kContent_width (SCREEN_WIDTH - kMargin_10 * 2)
#define kEmotionViewHeight 232


#define kUserImage_Size 40

#pragma mark - 根据文字内容和大小返回 size
CG_INLINE CGSize
BAKit_LabelSizeWithTextAndFont(NSString *text, UIFont *font){
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGSize newSize = CGSizeMake(size.width, size.height);
    return newSize;
}

#pragma mark - 根据文字内容、宽度和字体返回 size
CG_INLINE CGSize
BAKit_LabelSizeWithTextAndWidthAndFont(NSString *text, CGFloat width, UIFont *font){
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
//    if (![text isKindOfClass:[NSString class]] || ![text isKindOfClass:[NSAttributedString class]])
//    {
//        NSLog(@"text 错误，此功能仅限 NSString / NSAttributedString 类型！");
//        return CGSizeZero;
//    }
    CGRect frame = [text boundingRectWithSize:size
                                      options:
                    NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading
                                   attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : style} context:nil];
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
    return newFrame.size;
}

CG_INLINE CGSize
BAKit_LabelSizeWithMutableAttributedStringAndWidthAndFont(NSMutableAttributedString *text, CGFloat width, UIFont *font){
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    //    if (![text isKindOfClass:[NSString class]] || ![text isKindOfClass:[NSAttributedString class]])
    //    {
    //        NSLog(@"text 错误，此功能仅限 NSString / NSAttributedString 类型！");
    //        return CGSizeZero;
    //    }
    CGRect frame = [[text copy] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading context:nil];
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
    return newFrame.size;
}

#pragma mark - 根据文字内容、高度和字体返回 宽度
CG_INLINE CGFloat
BAKit_LabelWidthWithTextAndFont(NSString *text, CGFloat height, UIFont *font){
    CGSize size = CGSizeMake(MAXFLOAT, height);
    NSDictionary *attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
    
    return frame.size.width;
}

#pragma mark - UITableView
#pragma mark UITableView 分割线设置
CG_INLINE void
BAKit_UITableViewSetSeparatorInset(id tableView, UIColor *color, UIEdgeInsets separatorInset)
{
    BOOL isTabelViewClass = [tableView isKindOfClass:[UITableView class]];
    if (!isTabelViewClass)
    {
        NSLog(@"分割线设置错误，此功能仅限 UITableView 类型！");
        return ;
    }

    [tableView setSeparatorColor:color];
    [tableView setSeparatorInset:separatorInset];
}

#endif /* BAKit_FrameDefine_h */
