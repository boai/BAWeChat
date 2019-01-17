//
//  BATimeLineCommentView.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineCommentView.h"
#import "BATimeLineModel.h"
#import "BATimeLineViewModel.h"
//#import "BAUser.h"

#import "BATimeLineCommentCell.h"

#import "MLLabel.h"
#import "MLLinkLabel.h"
#import "NSString+MLExpression.h"
#import "NSAttributedString+MLExpression.h"
#import "MLTextAttachment.h"
#import "NSString+MLLabel.h"


@interface BATimeLineCommentView ()

@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation BATimeLineCommentView

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
//    self.userInteractionEnabled = YES;
    self.backgroundColor = BAKit_Color_Gray_11;

}
-(void)layoutSubviews{
    
}
#pragma mark - custom method
- (void)setupFrame
{
    
}

- (void)setupData
{
    long originalLabelsCount = self.dataArray.count;
    
    if (self.dataArray == 0)
    {
        
    }
    else
    {
        UIView *lastTopView = nil;

        for (int i = 0; i < originalLabelsCount; i ++)
        {
            MLLinkLabel *label = [MLLinkLabel new];
            label.userInteractionEnabled = YES;
            label.font = BAKit_Font_systemFontOfSize_13;
            label.textColor     = BAKit_Color_Gray_7;
            label.textAlignment = NSTextAlignmentJustified;
            label.linkTextAttributes = @{NSForegroundColorAttributeName : BAKit_Color_ThemBlue};
            label.dataDetectorTypes = MLDataDetectorTypeAll;
            label.allowLineBreakInsideLinks = YES;
            label.linkTextAttributes = nil;
            label.activeLinkTextAttributes = nil;
            
            [label setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
                NSString *tips = [NSString stringWithFormat:@"Click\nlinkType:%ld\nlinkText:%@\nlinkValue:%@",(unsigned long)link.linkType,linkText,link.linkValue];
                if (link.linkType == MLLinkTypePhoneNumber)
                {
                    [BAKit_Helper ba_helperTelWithPhoneNumber:link.linkValue];
                    return;
                }
                else if (link.linkType == MLLinkTypeURL)
                {
                    if ([BAKit_RegularExpression ba_regularIsUrl:link.linkValue])
                    {
                        [BAKit_Helper ba_helperGotoSafariBrowserWithURL:link.linkValue];
                        return;
                    }
                }
                
                BAKit_ShowAlertWithMsg(tips);
            }];
            
            BAKit_WeakSelf
            [label addLongPressGestureRecognizer:^(UILongPressGestureRecognizer *longGesture) {
                
                [[longGesture addBeganOpertation:^(UIGestureRecognizer *gesture) {
                    NSLog(@"长按开始");
                    [weak_self longPressCopyWithGesture:gesture];
                }] addChangedOpertation:^(UIGestureRecognizer *gesture) {
                    NSLog(@"长按结束");
                }];
            }];
            label.numberOfLines = 0;

            BATimeLineCommentModel *model = self.dataArray[i];
            
            NSString *text = model.firstUser.user_Name;
            NSString *text2 = model.firstUser.user_Name;
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：", model.firstUser.user_Name]];
            if (model.secondUser.user_Name.length)
            {
                text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUser.user_Name]];
                text2 = [text2 stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUser.user_Name]];
            }
            if (model.attributedContent)
            {
                [attributedString appendAttributedString:model.attributedContent];
            }
            else
            {
                text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentContent]];
            }
            
            NSMutableAttributedString *attributedContent = [self generateAttributedStringWithCommentItemModel:model text:text];
//            NSMutableAttributedString *attributedContent2 = [self generateAttributedStringWithCommentItemModel:model text2:text2];

            if (model.attributedContent)
            {
                label.attributedText = attributedString;
            }
            else
            {
                label.attributedText = attributedContent;
            }

            /*! 发表内容 */
            CGFloat commentLabel_x = 0;
            CGFloat commentLabel_y = 5;
            CGSize commentLabel_size = CGSizeZero;
            if (model.attributedContent)
            {
                commentLabel_size = BAKit_LabelSizeWithMutableAttributedStringAndWidthAndFont(attributedString, BAKit_Margin_Content_width, BAKit_Font_systemFontOfSize_13);
            }
            else
            {
                commentLabel_size = BAKit_LabelSizeWithTextAndWidthAndFont(text, BAKit_Margin_Content_width, BAKit_Font_systemFontOfSize_13);
            }
            CGFloat commentLabel_h = commentLabel_size.height;
            if (i != 0)
            {
                commentLabel_y += CGRectGetMaxY(lastTopView.frame);
            }

            label.frame = CGRectMake(commentLabel_x, commentLabel_y, BAKit_Margin_Content_width, commentLabel_h);
            
            [self addSubview:label];
            lastTopView = label;
        }
    }
}

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(BATimeLineCommentModel *)model text:(NSString *)text
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attString setAttributes:@{NSLinkAttributeName : model.firstUser.user_Id} range:[text rangeOfString:model.firstUser.user_Name]];
    
    if (model.secondUser.user_Name)
    {
        if ([model.firstUser.user_Name containsString:model.secondUser.user_Name])
        {
            [attString setAttributes:@{NSLinkAttributeName : model.secondUser.user_Id} range:[text rangeOfString:model.secondUser.user_Name options:NSBackwardsSearch]];
        }
        else
        {
            [attString setAttributes:@{NSLinkAttributeName : model.secondUser.user_Id} range:[text rangeOfString:model.secondUser.user_Name]];
        }
    }
    return attString;
}

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(BATimeLineCommentModel *)model text2:(NSString *)text2
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text2];
    [attString setAttributes:@{NSLinkAttributeName : model.firstUser.user_Id} range:[text2 rangeOfString:model.firstUser.user_Name]];
    if (model.secondUser.user_Name)
    {
        [attString setAttributes:@{NSLinkAttributeName : model.secondUser.user_Id} range:[text2 rangeOfString:model.secondUser.user_Name]];
    }
    [attString appendAttributedString:model.attributedContent];
    return attString;
}

#pragma mark - 长按复制
- (void)longPressCopyWithGesture:(UIGestureRecognizer *)gesture
{
    [self becomeFirstResponder];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(handleMenuCopyItemAction:)];
    UIMenuItem *collectionItem = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(handleMenuCollectionItemAction:)];
    menuController.menuItems = @[copyItem, collectionItem];
    [menuController setTargetRect:gesture.view.frame inView:gesture.view.superview];
    [menuController setMenuVisible:YES animated:YES];
    [UIMenuController sharedMenuController].menuItems=nil;
}

- (void)handleMenuCopyItemAction:(UIMenuItem *)menuItem
{
    NSString *tips = [NSString stringWithFormat:@"已复制到粘贴板！"];
//    BAKit_CopyContent(self.contentLabel.text);
    BAKit_ShowAlertWithMsg(tips);
}

- (void)handleMenuCollectionItemAction:(UIMenuItem *)menuItem
{
    NSString *tips = [NSString stringWithFormat:@"已收藏！"];
    //    BAKit_CopyContent(self.contentLabel.text);
    BAKit_ShowAlertWithMsg(tips);
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(handleMenuCopyItemAction:))
    {
        return YES;
    }
    else if (action == @selector(handleMenuCollectionItemAction:))
    {
        return YES;
    }
    return NO;
}

#pragma mark - setter / getter
- (void)setTimeLineViewModel:(BATimeLineViewModel *)timeLineViewModel
{
    _timeLineViewModel = timeLineViewModel;
    self.dataArray = _timeLineViewModel.model.comments;

    [self setupFrame];
    [self setupData];
}


@end
