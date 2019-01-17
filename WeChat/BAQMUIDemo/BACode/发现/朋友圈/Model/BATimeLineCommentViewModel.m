//
//  BATimeLineCommentViewModel.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/16.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineCommentViewModel.h"
#import "BATimeLineModel.h"
#import "BAUser.h"

@implementation BATimeLineCommentViewModel

- (void)setModel:(BATimeLineCommentModel *)model
{
    _model = model;
    
    [self setUpCommentViewFrame];
    
    _cellHeight = CGRectGetMaxY(_commentLabelFrame);
}

- (void)setUpCommentViewFrame
{
    NSString *comment = @"";
    
    if (BAKit_stringIsBlank(_model.secondUser.user_Name))
    {
        comment = [NSString stringWithFormat:@"%@：%@", _model.firstUser.user_Name, _model.commentContent];
    }
    else
    {
        comment = [NSString stringWithFormat:@"%@回复%@：%@", _model.secondUser.user_Name, _model.firstUser.user_Name, _model.commentContent];
    }
    
    /*! 发表内容 */
    CGFloat commentLabel_x = BAKit_Margin_10;
    CGFloat commentLabel_y = BAKit_Margin_10;
    CGSize commentLabel_size = BAKit_LabelSizeWithTextAndWidthAndFont(comment, BAKit_Margin_Content_width, BAKit_Font_systemFontOfSize_13);
    _commentLabelFrame = CGRectMake(commentLabel_x, commentLabel_y, BAKit_Margin_Content_width, commentLabel_size.height + 10);
}

@end
