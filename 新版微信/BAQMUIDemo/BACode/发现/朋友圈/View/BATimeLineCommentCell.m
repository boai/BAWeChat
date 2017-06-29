//
//  BATimeLineCommentCell.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/15.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineCommentCell.h"
#import "BATimeLineModel.h"
#import "BATimeLineCommentViewModel.h"
#import "BAUser.h"

@interface BATimeLineCommentCell ()

@property(nonatomic, strong) UILabel *commentLabel;

@end

@implementation BATimeLineCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    self.commentLabel.hidden = NO;
}

#pragma mark - custom method
- (void)setupFrame
{
    _commentLabel.frame = _commentViewModel.commentLabelFrame;
}

- (void)setupData
{
    NSString *comment = @"";
    BATimeLineCommentModel *model = _commentViewModel.model;
    if (BAKit_stringIsBlank(model.secondUser.user_Name))
    {
        comment = [NSString stringWithFormat:@"%@：%@", model.firstUser.user_Name, model.commentContent];
    }
    else
    {
        comment = [NSString stringWithFormat:@"%@回复%@：%@", model.secondUser.user_Name, model.firstUser.user_Name, model.commentContent];
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:comment];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(0, model.firstUser.user_Name.length)];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(model.firstUser.user_Name.length + 2, model.secondUser.user_Name.length)];
    self.commentLabel.attributedText = text;
}

#pragma mark - setter / getter

- (void)setCommentViewModel:(BATimeLineCommentViewModel *)commentViewModel
{
    _commentViewModel = commentViewModel;
    
    [self setupFrame];
    [self setupData];
}

- (UILabel *)commentLabel {
	if(_commentLabel == nil) {
		_commentLabel = [[UILabel alloc] init];
        self.commentLabel.font = BAKit_Font_systemFontOfSize_13;
        [self.contentView addSubview:self.commentLabel];
	}
	return _commentLabel;
}

@end
