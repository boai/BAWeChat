//
//  BAKit_EmotionTextAttachment.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/22.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAKit_EmotionTextAttachment.h"

@implementation BAKit_EmotionTextAttachment

- (instancetype)initEmotionTextAttachmentWithImage:(UIImage *)image
{
    if (self = [super init])
    {
        self.image = image;
    }
    return self;
}

- (instancetype)initEmotionTextAttachmentWithEmotionWithDisplayName:(NSString *)displayName
{
    if (self = [super init])
    {
        self.image = [self imageForEmotionWithDisplayName:displayName];
    }
    return self;
}

- (UIImage *)imageForEmotionWithDisplayName:(NSString *)displayName
{
    for (QMUIEmotion *emotion in [QMUIQQEmotionManager emotionsForQQ])
    {
        if ([displayName isEqualToString:emotion.displayName])
        {
            return emotion.image;
        }
    }
    return nil;
}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0, -lineFrag.size.height * 0.2, lineFrag.size.height, lineFrag.size.height);
}

@end
