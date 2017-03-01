//
//  BATimeLineViewModel.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineViewModel.h"
#import "BATimeLineModel.h"
#import "BAUser.h"

@implementation BATimeLineViewModel
{
    CGFloat photo_h;
}

- (void)setModel:(BATimeLineModel *)model
{
    _model = model;
    
    [self setUpContentFrame];
    [self setUpCommentFrame];

    _cellHeight = CGRectGetMaxY(_commentViewFrame) + kMargin_10;
}

- (void)setUpContentFrame
{
    /*! 头像 */
    CGFloat image_x = kMargin_10;
    CGFloat image_y = kMargin_10;
    CGFloat image_wh = kUserImage_Size;
    _iconImageViewFrame = CGRectMake(image_x, image_y, image_wh, image_wh);
    
    /*! 昵称 */
    CGFloat name_x = CGRectGetMaxX(_iconImageViewFrame) + kMargin_5;
    CGFloat name_y = image_y;
    CGSize name_size = BAKit_LabelSizeWithTextAndFont(_model.user.user_Name, kTimeLineNameFont);
    _nameLabelFrame = (CGRect){{name_x, name_y}, name_size};
    
    /*! 来源 */
    CGFloat source_x = name_x;
    CGFloat source_y = CGRectGetMaxY(_nameLabelFrame) + kMargin_5;
    CGSize source_size = BAKit_LabelSizeWithTextAndFont(_model.source, kTimeLineSourceFont);
    _sourceLabelFrame = (CGRect){{source_x, source_y}, source_size};
    
    /*! 发表内容 */
    CGFloat content_x = image_x;
    CGFloat content_y = CGRectGetMaxY(_iconImageViewFrame) + kMargin_10;
    CGSize content_size = BAKit_LabelSizeWithTextAndWidthAndFont(_model.content, kContent_width, kTimeLineContentFont);
    _contentLabelFrame = CGRectMake(content_x, content_y, kContent_width, content_size.height+10);
    
    /*! 图片 View 的 frame */
    CGFloat photo_x = image_x;
    CGFloat photo_y = CGRectGetMaxY(_contentLabelFrame) + kMargin_10;
    CGFloat photo_w = 0;
    CGFloat item_height = 0;
    
    if (self.model.pic_urls.count > 0)
    {
        
        if (self.model.pic_urls.count == 1)
        {
            NSString *photo = (self.model.pic_urls).firstObject;
            
            UIImage *image;
            CGSize imageSize = CGSizeZero;

            if ([BAKit_Helper ba_helperURLIsMp4WithUrl:photo])
            {
                image = BAKit_DefaultVideoImage;
                imageSize = image.size;
            }
            else
            {
                imageSize = [UIImage ba_imageGetImageSizeWithURL:photo];
            }

            CGFloat image_w = imageSize.width;
            CGFloat image_h = imageSize.height;
            
            if (image_w > kContent_width)
            {
                UIImage *image2 = [image ba_imageScaleToWidth:kContent_width];
                imageSize = image2.size;
                
                if (!image2)
                {
                    image_w = kContent_width * 0.68;
                    image_h = image_h / image_w * 120;
                }
                else
                {
                    image_w = kContent_width * 0.68;
                    image_h = imageSize.height;
                }
            }
            
            if (image_h > image_w)
            {
                image_w = image_w / image_h * kContent_width;
                image_h = image_h / image_h * kContent_width;
            }

            photo_w = image_w;
            photo_h = image_h;
        }
        else
        {
            NSInteger columnCount = [self columnCountWithNum:self.model.pic_urls.count];
            item_height = kContent_width/3;
            photo_w = kContent_width;
            photo_h = columnCount * (item_height + kMargin_5);
        }
    }
    else
    {
        photo_h = 0;
    }
    _photoViewFrame = CGRectMake(photo_x, photo_y, photo_w, photo_h);
    
    /*! 时间 */
    CGFloat time_x = content_x;
    CGFloat time_y = CGRectGetMaxY(_photoViewFrame) + kMargin_5;
    CGSize time_size = BAKit_LabelSizeWithTextAndFont(_model.created_time, kTimeLineTimeFont);
    _timeLabelFrame = (CGRect){{time_x, time_y}, time_size};
    
    /*! 点赞和评论按钮 */
    CGFloat operationButton_x = SCREEN_WIDTH - 25 - 10;
    CGFloat operationButton_y = time_y;
    CGSize operationButton_size = CGSizeMake(25, 25);
    _operationButtonFrame = (CGRect){{operationButton_x, operationButton_y}, operationButton_size};
    
    /*! 原创朋友圈的 frame */
    CGFloat origin_x = 0;
    CGFloat origin_y = 0;
    CGFloat origin_w = SCREEN_WIDTH;
    CGFloat origin_h = CGRectGetMaxY(_timeLabelFrame);
    _originalContentViewFrame = CGRectMake(origin_x, origin_y, origin_w, origin_h);
    
}

- (void)setUpCommentFrame
{
    /*! 评论 View 的 frame */
    CGFloat commentView_x = kMargin_10;
    CGFloat commentView_y = CGRectGetMaxY(_originalContentViewFrame) + kMargin_10;
    
    NSArray *commentArray = self.model.comments;
    CGFloat commentView_h = 0;
    if (commentArray == 0)
    {

    }
    else
    {
        for (int i = 0; i < commentArray.count; i ++)
        {
            BATimeLineCommentModel *model = commentArray[i];
            
            NSString *text = model.firstUser.user_Name;
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：", model.firstUser.user_Name]];
            if (model.secondUser.user_Name.length) {
                text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUser.user_Name]];
            }
            if (model.attributedContent)
            {
                [attributedString appendAttributedString:model.attributedContent];
            }
            else
            {
                text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentContent]];
            }
            /*! 评论 Label 的 frame */
            CGFloat commentLabel_x = 0;
            CGFloat commentLabel_y = 0;
            CGSize commentLabel_size = CGSizeZero;
            if (model.attributedContent)
            {
                commentLabel_size = BAKit_LabelSizeWithMutableAttributedStringAndWidthAndFont(attributedString, kContent_width, kTimeLineCommentFont);
            }
            else
            {
                commentLabel_size = BAKit_LabelSizeWithTextAndWidthAndFont(text, kContent_width, kTimeLineCommentFont);
            }
            _commentLabelFrame = CGRectMake(commentLabel_x, commentLabel_y, kContent_width, commentLabel_size.height);
            
            commentView_h += CGRectGetHeight(_commentLabelFrame);
            commentView_h += 5;
            if (i == commentArray.count - 1)
            {
                commentView_h += 5;
            }
        }
    }

    _commentViewFrame = CGRectMake(commentView_x, commentView_y, kContent_width, commentView_h);
    
}

- (NSInteger)columnCountWithNum:(NSInteger)count
{
    NSUInteger i = 0;
    if (count % 3 == 0)
    {
        i = count / 3;
    }
    else
    {
        i = count / 3 + 1;
    }
    return i;
}



@end
