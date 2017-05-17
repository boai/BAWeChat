//
//  BATimeLineContentView.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineContentView.h"
#import "BATimeLineViewModel.h"
#import "BATimeLineModel.h"
#import "BAUser.h"

#import "BATimeLinePhotoView.h"
#import "BATimeLineCommentView.h"
#import "BATimeLineOperationMenuView.h"


#import "MLLabel.h"
#import "MLLinkLabel.h"
#import "NSString+MLExpression.h"
#import "NSAttributedString+MLExpression.h"
#import "MLTextAttachment.h"
#import "NSString+MLLabel.h"



@interface BATimeLineContentView ()

/*! 头像 */
@property (nonatomic, strong) YYAnimatedImageView *iconImageView;

/*! 昵称 */
@property (nonatomic, strong)  UILabel *nameLabel;

/*! 来源 */
@property (nonatomic, strong) UILabel *sourceLabel;

/*! 正文 */
@property (nonatomic, strong) MLLinkLabel *contentLabel;

/*! 时间 */
@property (nonatomic, strong) UILabel *timeLabel;

/*! 点赞和评论按钮 */
@property (nonatomic, strong) UIButton *operationButton;

/*! 九宫格图片 */
@property (nonatomic, strong) BATimeLinePhotoView *photoView;

/*! 评论 View */
@property (nonatomic, strong) BATimeLineCommentView *commentView;


@end

@implementation BATimeLineContentView


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
    [BAKit_NotiCenter addObserver:self selector:@selector(handleOperationButtonNotification:) name:kNotioKey_TimeLineOperationButtonClicked object:nil];

    self.userInteractionEnabled = YES;
    self.iconImageView.hidden = NO;
    self.nameLabel.hidden = NO;
    self.sourceLabel.hidden = NO;
    self.contentLabel.hidden = NO;
    self.timeLabel.hidden = NO;
    self.operationButton.hidden = NO;
    self.operationMenuView.hidden = NO;
    self.operationMenuView.showOperationMenuView = NO;
    self.photoView.hidden = NO;
    self.commentView.hidden = NO;

    
}


#pragma mark - custom method
- (void)setupFrame
{
    _iconImageView.frame = _timeLineViewModel.iconImageViewFrame;
    _nameLabel.frame = _timeLineViewModel.nameLabelFrame;
    _sourceLabel.frame = _timeLineViewModel.sourceLabelFrame;
    _contentLabel.frame = _timeLineViewModel.contentLabelFrame;
    _timeLabel.frame = _timeLineViewModel.timeLabelFrame;
    _operationButton.frame = _timeLineViewModel.operationButtonFrame;
    _operationButton.centerY = _timeLabel.centerY;
    
    self.operationMenuView.frame = CGRectFlatMake(self.operationButton.left - 120, 0, 120, _operationButton.height);
    self.operationMenuView.centerY = self.operationButton.centerY;
    
    if (_timeLineViewModel.model.pic_urls.count > 0)
    {
        self.photoView.hidden = NO;
        _photoView.frame = _timeLineViewModel.photoViewFrame;
    }
    else
    {
        self.photoView.hidden = YES;
    }
    if (_timeLineViewModel.model.comments.count > 0)
    {
        self.commentView.hidden = NO;
        _commentView.frame = _timeLineViewModel.commentViewFrame;
    }
    else
    {
        self.commentView.hidden = YES;
    }
}

- (void)setupData
{
    BATimeLineModel *model = _timeLineViewModel.model;
    [self.photoView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.commentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    
    NSURL *iconUrl = [NSURL URLWithString:model.user.user_Image_url];
    [_iconImageView yy_setImageWithURL:iconUrl placeholder:BAKit_DefaultUserImage options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];

    _nameLabel.text = model.user.user_Name;
    _sourceLabel.text = model.source;
    
    /*! 测试不自动检测type，实际情况一般是检测，但是如果号码和库的原本正则逻辑不一致的话就需要在回调里自己去对Other类型的做处理了 */
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"\\[tel:(\\d{5,11})\\]" options:kNilOptions error:nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weak_self.contentLabel.attributedText = [model.content linkAttributedStringWithLinkRegex:regex groupIndexForDisplay:1 groupIndexForValue:1];
//        });
//    });
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"\\[tel:(\\d{5,11})\\]" options:kNilOptions error:nil];
    self.contentLabel.attributedText = [model.content linkAttributedStringWithLinkRegex:regex groupIndexForDisplay:1 groupIndexForValue:1];
//    self.contentLabel.text = model.content;
    if (model.pic_urls.count > 0)
    {
        self.photoView.hidden = NO;
        self.photoView.timeLineViewModel = _timeLineViewModel;
    }
    else
    {
        self.photoView.hidden = YES;
    }
    
    if (model.comments.count > 0)
    {
        self.commentView.hidden = NO;
        self.commentView.timeLineViewModel = _timeLineViewModel;
    }
    else
    {
        self.commentView.hidden = YES;
    }

    NSDateFormatter *formatter       = [NSDateFormatter ba_setupDateFormatterWithYMDHMS];
    NSDate *date                     = [formatter dateFromString:model.created_time];
    self.timeLabel.text              = [date ba_dateFormattedWithDate];
}

- (void)handleCopyAction
{
    NSString *tips = [NSString stringWithFormat:@"已复制到粘贴板！"];
    BAKit_CopyContent(self.timeLineViewModel.model.content);
    BAKit_ShowAlertWithMsg(tips);
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
    BAKit_CopyContent(self.contentLabel.text);
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

- (void)handleOperationButtonAction:(UIButton *)sender
{
//    NSLog(@"你点击了评论按钮！");
    [self postOperationButtonClickedNotification];
    self.operationMenuView.showOperationMenuView = !self.operationMenuView.isShowOperationMenuView;
}

- (void)handleOperationButtonNotification:(NSNotification *)notification
{
    UIButton *button = [notification object];
    if (button != self.operationButton && self.operationMenuView.isShowOperationMenuView)
    {
        self.operationMenuView.showOperationMenuView = NO;
    }
}

- (void)postOperationButtonClickedNotification
{
    [BAKit_NotiCenter postNotificationName:kNotioKey_TimeLineOperationButtonClicked object:self.operationButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self postOperationButtonClickedNotification];
    if (self.operationMenuView.isShowOperationMenuView)
    {
        self.operationMenuView.showOperationMenuView = NO;
    }
}


#pragma mark - setter / getter
- (void)setTimeLineViewModel:(BATimeLineViewModel *)timeLineViewModel
{
    _timeLineViewModel = timeLineViewModel;

    [self setupFrame];
    [self setupData];
}

- (YYAnimatedImageView *)iconImageView {
	if(_iconImageView == nil) {
		_iconImageView = [[YYAnimatedImageView alloc] init];
        [_iconImageView ba_setBordersWithColor:BAKit_Color_Green andCornerRadius:BAKit_Margin_UserImage_Size/2 andWidth:1.0f];
        [self addSubview:_iconImageView];
	}
	return _iconImageView;
}

- (UILabel *)nameLabel {
	if(_nameLabel == nil) {
		_nameLabel = [[UILabel alloc] init];
        _nameLabel.font = BAKit_FontSystem_15;
        self.nameLabel.textColor = BAKit_Color_Gray_6;
//        self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_nameLabel];
	}
	return _nameLabel;
}

- (UILabel *)timeLabel {
	if(_timeLabel == nil) {
		_timeLabel = [[UILabel alloc] init];
        _timeLabel.font = BAKit_FontSystem_12;
        self.timeLabel.textColor     = BAKit_Color_Gray_8;
//        self.timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_timeLabel];
	}
	return _timeLabel;
}

- (MLLinkLabel *)contentLabel {
	if(_contentLabel == nil) {
		_contentLabel = [[MLLinkLabel alloc] init];
        self.contentLabel.textColor     = BAKit_Color_Gray_6;
        self.contentLabel.backgroundColor = BAKit_Color_Gray_10;
        self.contentLabel.userInteractionEnabled = YES;
        self.contentLabel.font = BAKit_FontSystem_13;

//        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentLabel.textAlignment = NSTextAlignmentJustified;
        self.contentLabel.linkTextAttributes = @{NSForegroundColorAttributeName : BAKit_Color_ThemBlue};
        self.contentLabel.dataDetectorTypes = MLDataDetectorTypeAll;
        self.contentLabel.allowLineBreakInsideLinks = YES;
        self.contentLabel.linkTextAttributes = nil;
        self.contentLabel.activeLinkTextAttributes = nil;
        
        [self.contentLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
            NSString *tips = [NSString stringWithFormat:@"Click\nlinkType:%ld\nlinkText:%@\nlinkValue:%@",(unsigned long)link.linkType,linkText,link.linkValue];
            if (link.linkType == MLLinkTypePhoneNumber || [link.linkValue isEqualToString:@"10010"])
            {
                [BAKit_Helper ba_helperTelWithPhoneNumber:link.linkValue];
                return;
            }
            else if (link.linkType == MLLinkTypeURL)
            {
                if ([BAKit_RegularExpression ba_regularIsUrl:link.linkValue])
                {
                    [BAKit_Helper ba_ba_helperGotoSafariBrowserWithURL:link.linkValue];
                    return;
                }
            }
            
            BAKit_ShowAlertWithMsg(tips);
        }];
        
        BAKit_WeakSelf
        [_contentLabel addLongPressGestureRecognizer:^(UILongPressGestureRecognizer *longGesture) {
            
            [[longGesture addBeganOpertation:^(UIGestureRecognizer *gesture) {
                NSLog(@"长按开始");
                [weak_self longPressCopyWithGesture:gesture];
            }] addChangedOpertation:^(UIGestureRecognizer *gesture) {
                NSLog(@"长按结束");
            }];
        }];
        self.contentLabel.numberOfLines = 0;

        [self addSubview:_contentLabel];
	}
	return _contentLabel;
}

- (UILabel *)sourceLabel {
	if(_sourceLabel == nil) {
		_sourceLabel = [[UILabel alloc] init];
        _sourceLabel.font = BAKit_FontSystem_12;
        self.sourceLabel.textColor = BAKit_Color_Gray_8;
//        self.sourceLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_sourceLabel];
	}
	return _sourceLabel;
}

- (UIButton *)operationButton {
    if(_operationButton == nil) {
        _operationButton = [[UIButton alloc] init];
        [_operationButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [_operationButton setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];

        [_operationButton addTarget:self action:@selector(handleOperationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.operationButton];
    }
    return _operationButton;
}

- (BATimeLinePhotoView *)photoView {
	if(_photoView == nil) {
		_photoView = [[BATimeLinePhotoView alloc] init];
        [self addSubview:_photoView];
	}
	return _photoView;
}

- (BATimeLineCommentView *)commentView {
	if(_commentView == nil) {
		_commentView = [[BATimeLineCommentView alloc] init];
        [self addSubview:_commentView];
	}
	return _commentView;
}

- (BATimeLineOperationMenuView *)operationMenuView {
	if(_operationMenuView == nil) {
		_operationMenuView = [[BATimeLineOperationMenuView alloc] init];
        
        [self addSubview:self.operationMenuView];
	}
	return _operationMenuView;
}

@end
