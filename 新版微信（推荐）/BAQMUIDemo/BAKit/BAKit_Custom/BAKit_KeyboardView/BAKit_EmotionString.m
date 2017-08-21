//
//  BAKit_EmotionString.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/22.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAKit_EmotionString.h"

@implementation BAKit_EmotionString

+ (NSMutableAttributedString *)ba_getEmotionMutableAttributedStringWithContent:(NSString *)content
{
    // NSLog(@"你点击的表情：%ld, %@, %@, %@", index, emotion.image, emotion.identifier, emotion.displayName);
    // 你点击的表情：27, <UIImage: 0x170098b50> size {24, 24} orientation 0 scale 2.000000, scale = 2, smiley_27, [流汗]
    // 匹配表情文字
    NSString *pattern = @"\\[\\w+\\]";
    
    NSArray *resultArr = [content ba_regularMachesWithPattern:pattern];
    if (!resultArr) return nil;
    
    NSMutableAttributedString *attrContent = [[NSMutableAttributedString alloc]initWithString:content];
    NSUInteger lengthDetail = 0;
    // 遍历所有的result 取出range
    for (NSTextCheckingResult *result in resultArr) {
        // 取出图片名
        NSString *imageName = [content substringWithRange:NSMakeRange(result.range.location + 1, result.range.length - 2)];
        imageName = [NSString stringWithFormat:@"[%@]", imageName];
        // 创建AttributeString, 来包装图片
        BAKit_EmotionTextAttachment *attachment = [[BAKit_EmotionTextAttachment alloc]initEmotionTextAttachmentWithEmotionWithDisplayName:imageName];
        // 将附近包装到 NSAttributedString中
        NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:attachment];
        // 图片附件的文本长度是1
//        NSLog(@"%zd",imageString.length);
        
        NSUInteger length = attrContent.length;
        NSRange newRange = NSMakeRange(result.range.location - lengthDetail, result.range.length);
        [attrContent replaceCharactersInRange:newRange withAttributedString:imageString];
        
        lengthDetail += length - attrContent.length;
    }
    return attrContent;
}

@end
