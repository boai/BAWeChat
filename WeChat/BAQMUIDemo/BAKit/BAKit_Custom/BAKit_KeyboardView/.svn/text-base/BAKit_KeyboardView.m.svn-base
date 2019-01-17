//
//  BAKit_KeyboardView.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/20.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAKit_KeyboardView.h"

// 表情转义字符的长度（ /s占2个长度，xxx占3个长度，共5个长度 ）
#define BAKit_EmotionName_Len   5
#define BAKit_EmotionName_Head  @"[]"

@interface BAKit_KeyboardView ()<QMUITextViewDelegate>


/*!
 *  表情按钮
 */
@property (nonatomic, strong) QMUIButton *emotionButton;
/*!
 *  更多按钮
 */
@property (nonatomic, strong) QMUIButton *moreButton;
/*!
 *  表情 View
 */
@property (nonatomic, strong) UIView *emotionView;
@property (nonatomic, strong) QMUIQQEmotionManager *qqEmotionManager;

/*!
 *  更多 View
 */
@property (nonatomic, strong) UIView *moreView;
@property (nonatomic, strong) QMUIButton *photoButton;
@property (nonatomic, strong) QMUIButton *cameraButton;
@property (nonatomic, strong) QMUIButton *locationButton;
@property (nonatomic, strong) QMUIButton *videoButton;


@property (nonatomic,assign) CGRect keyBoardRect;
@property (nonatomic,assign) double duration;

@property (nonatomic, assign) CGFloat textViewMinimumHeight;
@property (nonatomic, assign) CGFloat textViewMaximumHeight;

@end

@implementation BAKit_KeyboardView

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
    self.backgroundColor = BAKit_Color_Gray_10;
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = BAKit_Color_Gray_8.CGColor;

    self.emotionView.hidden = NO;
    self.moreView.hidden = YES;

//    self.showMoreButton = YES;
//    self.showEmotionButton = YES;
    
    self.textViewMinimumHeight = 30;
    self.textViewMaximumHeight = 60;
    
    [self ba_addNoti];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat self_w = self.frame.size.width;
    CGFloat self_h = self.height;
    CGFloat button_wh = 30;
    CGFloat textView_w = 0;

    if (!self.isShowEmotionButton || !self.isShowMoreButton)
    {
        if (!self.isShowEmotionButton && !self.isShowMoreButton)
        {
            textView_w = self_w - 2 * BAKit_Margin_10;
            self.emotionButton.hidden = YES;
            self.moreButton.hidden = YES;
        }
        else if (!self.isShowEmotionButton )
        {
            textView_w = self_w - 3 * BAKit_Margin_10 - button_wh;
            self.emotionButton.hidden = YES;
            self.moreButton.hidden = NO;
        }
        else if (!self.isShowMoreButton)
        {
            textView_w = self_w - 3 * BAKit_Margin_10 - button_wh;
            self.emotionButton.hidden = NO;
            self.moreButton.hidden = YES;
        }
    }
    else
    {
        textView_w = self_w - 4 * BAKit_Margin_10 - 2 * button_wh;
        self.emotionButton.hidden = NO;
        self.moreButton.hidden = NO;
    }
    
//    CGSize textViewSize = [self.commentTextView sizeThatFits:CGSizeMake(textView_w, CGFLOAT_MAX)];
//    self.commentTextView.frame = CGRectMake(BAKit_Margin_10, 5, textView_w, fminf(self.textViewMaximumHeight, fmaxf(textViewSize.height, self.textViewMinimumHeight)));
    
    self.commentTextView.frame = CGRectMake(BAKit_Margin_10, 7, textView_w, self.textViewMinimumHeight);
    self.emotionButton.frame = CGRectMake(CGRectGetMaxX(self.commentTextView.frame) + BAKit_Margin_10, self_h - 7 - button_wh , button_wh, button_wh);
    if (self.isShowEmotionButton && self.isShowMoreButton)
    {
        self.moreButton.frame = CGRectMake(CGRectGetMaxX(self.emotionButton.frame) + BAKit_Margin_10,  self_h - 7 - button_wh, button_wh, button_wh);
    }
    else
    {
        if (self.isShowMoreButton)
        {
            self.moreButton.frame = CGRectMake(CGRectGetMaxX(self.commentTextView.frame) + BAKit_Margin_10,  self_h - 7 - button_wh, button_wh, button_wh);
        }
    }
    self.emotionButton.centerY = self.commentTextView.centerY;
    self.moreButton.centerY = self.commentTextView.centerY;
    
    self.emotionView.frame = CGRectMake(0, SCREEN_HEIGHT - BAKit_Margin_EmotionViewHeight, SCREEN_WIDTH, BAKit_Margin_EmotionViewHeight);
    self.qqEmotionManager.emotionView.frame = self.emotionView.bounds;
    self.moreView.frame = CGRectMake(0, SCREEN_HEIGHT - BAKit_Margin_EmotionViewHeight, SCREEN_WIDTH, BAKit_Margin_EmotionViewHeight);
    
    
    button_wh = 60;
    NSInteger rowItemNum = 4;
    NSInteger allItemNum = 4;

    CGFloat margin_w = (self.moreView.width - rowItemNum * button_wh) / 5;
    CGFloat button_x = 0;
    CGFloat button_y = (self.moreView.height - 2 * button_wh) / 3;
    
    

    for (NSInteger i = 0; i < allItemNum; i ++)
    {
        button_x = (button_wh + margin_w) * i + margin_w;
        
        switch (i) {
            case 0:
                self.photoButton.frame = CGRectMake(button_x, button_y, button_wh, button_wh);
                break;
            case 1:
                self.cameraButton.frame = CGRectMake(button_x, button_y, button_wh, button_wh);
                break;
            case 2:
                self.locationButton.frame = CGRectMake(button_x, button_y, button_wh, button_wh);
                break;
            case 3:
                self.videoButton.frame = CGRectMake(button_x, button_y, button_wh, button_wh);
                break;
                
            default:
                break;
        }
    }
    
}

#pragma mark - custom method
- (void)handleEmotionButtonAction:(UIButton *)button
{
    button.selected = !button.selected;
    [self.commentTextView resignFirstResponder];
    
    switch (button.tag) {
            case BATimeLineKeyboardViewTypeEmotionButton:
        {
            /*! 表情 */
            NSLog(@"你点击了表情按钮！");
            self.moreButton.selected = NO;
            if (button.selected)
            {
                self.inputViewType = BATimeLineKeyboardInputViewTypeEmotion;
                [self updateKeyboardViewAnimationWithRect:CGRectMake(0, SCREEN_HEIGHT - self.height - BAKit_Margin_EmotionViewHeight, SCREEN_WIDTH, self.height)
                                            inputViewType:BATimeLineKeyboardInputViewTypeEmotion];
            }
            else
            {
                self.inputViewType = BATimeLineKeyboardInputViewTypeNormal;
                [self updateKeyboardViewAnimationWithRect:CGRectMake(0, SCREEN_HEIGHT - self.height, SCREEN_WIDTH, self.height)
                                            inputViewType:BATimeLineKeyboardInputViewTypeNormal];
            }
        }
            
            break;
            
            case BATimeLineKeyboardViewTypeMoreButton:
        {
            /*! 更多 */
            NSLog(@"你点击了更多按钮！");
            self.emotionButton.selected = NO;
            if (button.selected)
            {
                self.inputViewType = BATimeLineKeyboardInputViewTypeMore;
                [self updateKeyboardViewAnimationWithRect:self.frame
                                            inputViewType:BATimeLineKeyboardInputViewTypeMore];
            }
            else
            {
                self.inputViewType = BATimeLineKeyboardInputViewTypeNormal;
                [self updateKeyboardViewAnimationWithRect:CGRectMake(0, SCREEN_HEIGHT - self.height, SCREEN_WIDTH, self.height)
                                            inputViewType:BATimeLineKeyboardInputViewTypeNormal];
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)ba_addNoti
{
    /*! 注册一个通知监听keyBoard位置的改变 */
    [BAKit_NotiCenter addObserver:self selector:@selector(handleKeyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [BAKit_NotiCenter addObserver:self selector:@selector(handleKeyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [BAKit_NotiCenter addObserver:self selector:@selector(handleKeyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)ba_showKeyboardView
{
    [self.commentTextView becomeFirstResponder];
}

- (void)ba_hideKeyboardView
{
    [self.commentTextView resignFirstResponder];
    self.emotionButton.selected = NO;
    self.moreButton.selected = NO;
}

- (void)handleKeyboardWillChangeFrameNotification:(NSNotification *)notification
{
//    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    
//    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//
//    // 设置底部约束的高度
//    CGFloat offset = SCREEN_HEIGHT - keyboardFrame.origin.y;

//    [self setNeedsLayout];
}

- (void)handleKeyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = notification.userInfo;
    self.duration  = [infoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.keyBoardRect  = [infoDic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    NSLog(@"显示键盘：%@", NSStringFromCGRect(self.keyBoardRect));
    switch (self.inputViewType) {
        case BATimeLineKeyboardInputViewTypeNormal:
        {
            [self updateKeyboardViewAnimationWithRect:CGRectMake(0, SCREEN_HEIGHT - self.keyBoardRect.size.height - self.height, SCREEN_WIDTH, self.height)
                                        inputViewType:self.inputViewType];
        }
            break;
            
        case BATimeLineKeyboardInputViewTypeEmotion:
        case BATimeLineKeyboardInputViewTypeMore:
        {
            [self updateKeyboardViewAnimationWithRect:CGRectMake(0, SCREEN_HEIGHT - self.height - BAKit_Margin_EmotionViewHeight, SCREEN_WIDTH, self.height)
                                        inputViewType:self.inputViewType];
        }
            break;
            
        default:
            break;
    }
}

- (void)handleKeyboardWillHideNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = notification.userInfo;
    self.duration = [infoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.keyBoardRect = [infoDic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    NSLog(@"隐藏键盘：%@", NSStringFromCGRect(self.keyBoardRect));
    [self updateKeyboardViewAnimationWithRect:CGRectMake(0, SCREEN_HEIGHT - self.height, SCREEN_WIDTH, self.height)
                                inputViewType:self.inputViewType];
}

- (void)handleEmotionViewSendButtonAction:(QMUIButton *)sender
{
    if (self.BATimeLineKeyboardViewReturnBlock)
    {
        NSLog(@"发送内容：%@", self.commentTextView.text);
        self.BATimeLineKeyboardViewReturnBlock(self.commentTextView.text);
        self.commentTextView.text = nil;
        self.qqEmotionManager.selectedRangeForBoundTextInput = NSMakeRange(0, 0);
    }
}

- (void)handleMoreViewButtonAction:(QMUIButton *)sender
{
    NSString *msg = @"";
    
    switch (sender.tag) {
        case BATimeLineKeyboardMoreViewTypePhotoButton:
        {
            msg = @"你点击了 相册 按钮！";
        }
            break;
            
        case BATimeLineKeyboardMoreViewTypeCameraButton:
        {
            msg = @"你点击了 拍照 按钮！";
        }
            break;
            
        case BATimeLineKeyboardMoreViewTypeLocationButton:
        {
            msg = @"你点击了 位置 按钮！";
        }
            break;
            
        case BATimeLineKeyboardMoreViewTypeVideoButton:
        {
            msg = @"你点击了 视频 按钮！";
        }
            break;
            
        default:
            break;
    }
    BAKit_ShowAlertWithMsg(msg);
}

- (void)updateKeyboardViewAnimationWithRect:(CGRect)rect
                              inputViewType:(BATimeLineKeyboardInputViewType)inputViewType
{
    self.frame = rect;
    BAKit_WeakSelf
    [UIView animateWithDuration:self.duration animations:^{
    
        switch (inputViewType) {
            case BATimeLineKeyboardInputViewTypeEmotion:
            {
                weak_self.commentTextView.inputView = weak_self.emotionView;
                [weak_self.commentTextView becomeFirstResponder];
            }
                break;
                
            case BATimeLineKeyboardInputViewTypeMore:
            {
                weak_self.moreView.hidden = NO;
                weak_self.commentTextView.inputView = weak_self.moreView;
                [weak_self.commentTextView becomeFirstResponder];
            }
                break;
                
            case BATimeLineKeyboardInputViewTypeNormal:
            {
                weak_self.commentTextView.inputView = nil;
                [weak_self.commentTextView becomeFirstResponder];
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - QMUITextViewDelegate
- (void)textView:(QMUITextView *)textView contentHeightAfterTextChanged:(CGFloat)height
{
    height = fminf(self.textViewMaximumHeight, self.textViewMinimumHeight);
    BOOL needsChangeHeight = CGRectGetHeight(textView.frame) != height;
    if (needsChangeHeight)
    {
        [self setNeedsLayout];
    }
}

- (void)textView:(QMUITextView *)textView didPreventTextChangeInRange:(NSRange)range replacementText:(NSString *)replacementText
{
    [QMUITips showWithText:[NSString stringWithFormat:@"文字不能超过 %@ 个字符", @(textView.maximumTextLength)] inView:[self getCurrentViewController].view hideAfterDelay:2.0];
    [self.commentTextView resignFirstResponder];
    self.emotionButton.selected = NO;
    self.moreButton.selected = NO;
    self.qqEmotionManager.selectedRangeForBoundTextInput = NSMakeRange(0, 0);

}

// 可以利用这个 delegate 来监听发送按钮的事件，当然，如果你习惯以前的方式的话，也可以继续在 textView:shouldChangeTextInRange:replacementText: 里处理
- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    if (self.BATimeLineKeyboardViewReturnBlock)
    {
        self.BATimeLineKeyboardViewReturnBlock(self.commentTextView.text);
        textView.text = nil;
        self.qqEmotionManager.selectedRangeForBoundTextInput = NSMakeRange(0, 0);
    }
    // return YES 表示这次 return 按钮的点击是为了触发“发送”，而不是为了输入一个换行符
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if (self.BATimeLineKeyboardViewReturnBlock)
        {
            self.BATimeLineKeyboardViewReturnBlock(self.commentTextView.text);
            textView.text = nil;
            self.qqEmotionManager.selectedRangeForBoundTextInput = NSMakeRange(0, 0);
        }
        return NO;
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    // 告诉 qqEmotionManager 输入框的光标位置发生变化，以保证表情插入在光标之后
    self.qqEmotionManager.selectedRangeForBoundTextInput = self.commentTextView.selectedRange;
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.qqEmotionManager.selectedRangeForBoundTextInput = self.commentTextView.selectedRange;
    [self endEditing:YES];
}

#pragma mark - setter / getter
- (QMUITextView *)commentTextView {
    if(_commentTextView == nil) {
        _commentTextView = [[QMUITextView alloc] init];
        
        self.commentTextView.font = UIFontMake(15);
        self.commentTextView.textColor = BAKit_Color_Black;
        [self.commentTextView ba_setBordersWithColor:BAKit_Color_Gray_9 andCornerRadius:5.0f andWidth:0.5f];
        self.commentTextView.returnKeyType = UIReturnKeySend;
        self.commentTextView.scrollEnabled = YES;
        self.commentTextView.delegate = self;
        self.commentTextView.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        
        self.commentTextView.autoResizable = YES;
        
        /*! 设置没有文字时return键不能点击 */
        self.commentTextView.enablesReturnKeyAutomatically = YES;
        
        // 限制可输入的字符长度
        self.commentTextView.maximumTextLength = 30;
        self.commentTextView.shouldResponseToProgrammaticallyTextChanges = YES;
        self.commentTextView.placeholder = @"添加评论：";
        
        [self addSubview:self.commentTextView];
    }
    return _commentTextView;
}

- (QMUIButton *)emotionButton {
    if(_emotionButton == nil) {
        _emotionButton = [BAUIHelper ba_uiHelper_creatButtonWithTitle:nil selTitle:nil titleColor:nil titleFontSize:0 image:BAKit_ImageName(@"emotion_button") selImage:BAKit_ImageName(@"keyboard_button") target:self selector:@selector(handleEmotionButtonAction:)];
        _emotionButton.tag = BATimeLineKeyboardViewTypeEmotionButton;
        
        [self addSubview:self.emotionButton];
    }
    return _emotionButton;
}

- (QMUIButton *)moreButton {
    if(_moreButton == nil) {
        _moreButton = [BAUIHelper ba_uiHelper_creatButtonWithTitle:nil selTitle:nil titleColor:nil titleFontSize:0 image:BAKit_ImageName(@"add_button") selImage:BAKit_ImageName(@"add_button") target:self selector:@selector(handleEmotionButtonAction:)];
        _moreButton.tag = BATimeLineKeyboardViewTypeMoreButton;
        
        [self addSubview:self.moreButton];
    }
    return _moreButton;
}

- (UIView *)emotionView {
    if(_emotionView == nil) {
        _emotionView = [[UIView alloc] init];
        self.qqEmotionManager = [[QMUIQQEmotionManager alloc] init];
        self.emotionView.backgroundColor = BAKit_Color_White;
        self.qqEmotionManager.boundTextView = self.commentTextView;
        self.qqEmotionManager.emotionView.qmui_borderPosition = QMUIBorderViewPositionTop;
        [self.qqEmotionManager.emotionView.sendButton addTarget:self action:@selector(handleEmotionViewSendButtonAction:)];

        [self.emotionView addSubview:self.qqEmotionManager.emotionView];
        
        [[self getCurrentViewController].view addSubview:self.emotionView];
    }
    return _emotionView;
}


- (UIView *)moreView {
    if(_moreView == nil) {
        _moreView = [[UIView alloc] init];
        self.moreView.backgroundColor = BAKit_Color_White;
        _photoButton = [BAUIHelper ba_uiHelper_creatButtonWithTitle:@"照片" selTitle:nil titleColor:BAKit_Color_Gray_6 titleFontSize:14.0f image:BAKit_ImageName(@"photo_button") selImage:nil target:self selector:@selector(handleMoreViewButtonAction:)];
        _cameraButton = [BAUIHelper ba_uiHelper_creatButtonWithTitle:@"拍照" selTitle:nil titleColor:BAKit_Color_Gray_6 titleFontSize:14.0f image:BAKit_ImageName(@"camera_button") selImage:nil target:self selector:@selector(handleMoreViewButtonAction:)];
        _locationButton = [BAUIHelper ba_uiHelper_creatButtonWithTitle:@"位置" selTitle:nil titleColor:BAKit_Color_Gray_6 titleFontSize:14.0f image:BAKit_ImageName(@"location_button") selImage:nil target:self selector:@selector(handleMoreViewButtonAction:)];
        _videoButton = [BAUIHelper ba_uiHelper_creatButtonWithTitle:@"视频" selTitle:nil titleColor:BAKit_Color_Gray_6 titleFontSize:14.0f image:BAKit_ImageName(@"video_button") selImage:nil target:self selector:@selector(handleMoreViewButtonAction:)];

        self.photoButton.imagePosition = QMUIButtonImagePositionTop;
        self.cameraButton.imagePosition = QMUIButtonImagePositionTop;
        self.locationButton.imagePosition = QMUIButtonImagePositionTop;
        self.videoButton.imagePosition = QMUIButtonImagePositionTop;
        
        self.photoButton.tag = BATimeLineKeyboardMoreViewTypePhotoButton;
        self.cameraButton.tag = BATimeLineKeyboardMoreViewTypeCameraButton;
        self.locationButton.tag = BATimeLineKeyboardMoreViewTypeLocationButton;
        self.videoButton.tag = BATimeLineKeyboardMoreViewTypeVideoButton;

        [self.moreView ba_addSubViewsWithArray:@[self.photoButton, self.cameraButton, self.locationButton, self.videoButton]];

        [[self getCurrentViewController].view addSubview:self.moreView];
    }
    return _moreView;
}


- (void)dealloc
{
//    [BAKit_NotiCenter removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}





@end
