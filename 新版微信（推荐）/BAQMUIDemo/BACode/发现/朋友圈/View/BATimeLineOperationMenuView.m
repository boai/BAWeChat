//
//  BATimeLineOperationMenuView.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/17.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineOperationMenuView.h"

@implementation BATimeLineOperationMenuView
{
    QMUIButton *_likeButton;
    UIView     *_centerLine;
    QMUIButton *_commentButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    self.userInteractionEnabled = YES;
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    self.backgroundColor = UIColorMakeWithRGBA(69, 75, 76, 1.0f);
    _likeButton = [BAUIHelper ba_uiHelper_creatButtonWithTitle:@"赞" selTitle:@"取消" titleColor:UIColorWhite titleFontSize:14 image:UIImageMake(@"AlbumLike") selImage:UIImageMake(@"AlbumLike") target:self selector:@selector(handleLikeButtonAction)];
    
    _commentButton = [BAUIHelper ba_uiHelper_creatButtonWithTitle:@"评论" selTitle:@"" titleColor:UIColorWhite titleFontSize:14 image:UIImageMake(@"AlbumComment") selImage:UIImageMake(@"AlbumComment") target:self selector:@selector(handleCommentButtonAction)];
    
    _centerLine = [UIView new];
    _centerLine.backgroundColor = UIColorSeparator;
    
    [self addSubview:_likeButton];
    [self addSubview:_centerLine];
    [self addSubview:_commentButton];
}

#pragma mark - custom Mothod
- (void)handleLikeButtonAction
{
    if (self.likedButtonActionBlock)
    {
        self.likedButtonActionBlock();
    }
    self.showOperationMenuView = NO;
}

- (void)handleCommentButtonAction
{
    if (self.commentButtonActionBlock)
    {
        self.commentButtonActionBlock();
    }
    self.showOperationMenuView = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat button_width = self.bounds.size.width / 2;
    CGFloat button_height = 25;
    CGFloat margin = 5;
    _likeButton.frame = CGRectMake(0, 0, button_width, button_height);
    _centerLine.frame = CGRectMake(_likeButton.right, margin, 1, self.bounds.size.height - margin * 2);
    _commentButton.frame = CGRectMake(_centerLine.right, 0, button_width, button_height);
}

- (void)setShowOperationMenuView:(BOOL)showOperationMenuView
{
    _showOperationMenuView = showOperationMenuView;
    
    BAKit_WeakSelf
    [UIView animateWithDuration:0.2f animations:^{
        if (!showOperationMenuView)
        {
            weak_self.hidden = YES;
        }
        else
        {
            weak_self.hidden = NO;
        }
        [weak_self.superview layoutSubviews];
    }];
}




@end
