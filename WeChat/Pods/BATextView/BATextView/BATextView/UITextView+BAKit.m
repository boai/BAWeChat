//
//  UITextView+BAKit.m
//  BAQMUIDemo
//
//  Created by boai on 2017/5/31.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "UITextView+BAKit.h"
#import <objc/runtime.h>

#import "BAKit_ConfigurationDefine.h"


@interface UITextView ()

/**
 存储最后一次改变高度后的值
 */
@property(nonatomic, assign) CGFloat ba_lastHeight;

/**
 判断是否是 placeHolder
 */
@property(nonatomic, assign) BOOL ba_isNotPlaceHolder;

@property(nonatomic, strong) NSString *ba_PlaceHolderTemp;


@end

@implementation UITextView (BAKit)

+ (void)load
{
    BAKit_Objc_exchangeMethodAToB(NSSelectorFromString(@"dealloc"),
                                  @selector(ba_textView_dealloc));
}

#pragma mark - custom method

- (void)ba_textViewWithDelegate:(id <UITextViewDelegate>)delegate
{
    self.delegate = delegate;
}

- (BOOL)ba_textView_isEmpty
{
    return (self == nil || self.text == nil || self.text.length <= 0 || [self.text isEqualToString:@""] || !self.ba_isNotPlaceHolder);
}

- (void)ba_textView_addNoti
{
    [self ba_removeNoti];
    
    [BAKit_NotiCenter addObserver:self selector:@selector(handleDidBeginEditingNotificationAction:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [BAKit_NotiCenter addObserver:self selector:@selector(handleDidEndEditingNotificationAction:) name:UITextViewTextDidEndEditingNotification object:nil];
    
//    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
//    // 这些属性改变时，都要作出一定的改变，尽管已经监听了TextDidChange的通知，也要监听text属性，因为通知监听不到setText：
//    NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
//    
//    // 监听属性
//    for (NSString *property in propertys)
//    {
//        [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
//    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if (self.ba_textView_ShouldChangeTextInRangeBlock)
    {
        self.ba_textView_ShouldChangeTextInRangeBlock(textView, range, text);
    }
    
    if (self == textView)
    {
    //      关联词不执行textViewDidChange,统一在该方法提前返回字符数
        if (self.ba_textView_WordDidChangedBlock)
        {
            self.ba_textView_WordDidChangedBlock(textView.text);
        }
        
    //    删除或者其他操作
        if ([text isEqual:@""] && range.length >= 1) {
            return YES;
        }
        
        UITextRange * selectedRange = [textView markedTextRange];
//        获取高亮部分
        UITextPosition * position = [textView positionFromPosition:selectedRange.start offset:0];
//        如果有高亮且当前字数开始位置小于最大限制时允许输入
        if (selectedRange && position) {
            NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
            NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
            NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
            if (offsetRange.location < self.ba_maxWordLimitNumber) {
                return YES;
            }else{
                return NO;
            }
        }
        
        NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
        NSInteger caninputlen = self.ba_maxWordLimitNumber - comcatstr.length;
        if (caninputlen >= 0){
            return YES;
        }else{
            NSInteger len = text.length + caninputlen;
            //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
            NSRange rg = {0, MAX(len, 0)};
            if (rg.length > 0){
                NSString *s = @"";
                //判断是否只普通的字符或asc码(对于中文和表情返回NO)
                BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
                if (asc) {
                    s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
                }else{
                    s = [self enumerateSubstring:text to:rg.length];
                    
                }
                //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
                [textView setText:[textView.text  stringByReplacingCharactersInRange:range withString:s]];
                //既然是超出部分截取了，哪一定是最大限制了。字数限制label显示
//                NSString * testStr = [NSString stringWithFormat:@"%d/%ld",0, self.ba_maxWordLimitNumber];
//                NSLog(@"%@",testStr);
            }
            return NO;
        }
    }
    
    return NO;
}

- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%s",__func__);
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum >self.ba_maxWordLimitNumber){
//        NSString *s = [nsTextContent substringToIndex:self.ba_maxWordLimitNumber];
        [textView setText:[self enumerateSubstring:nsTextContent to:self.ba_maxWordLimitNumber]];
    }
    //不让显示负数,字数label
//    NSString * testStr = [NSString stringWithFormat:@"%ld/%ld", MAX(0, self.ba_maxWordLimitNumber - existTextNum), self.ba_maxWordLimitNumber];
    
//    if (self.ba_textView_WordDidChangedBlock)
//    {
//        self.ba_textView_WordDidChangedBlock(textView.text);
//    }
    
    // 计算高度，extern double ceil(double); 如果参数是小数，则求最小的整数但不小于本身.
    CGFloat current_textHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)].height);
    if (current_textHeight != self.ba_lastHeight)
    {
        CGFloat current_textViewHeight = current_textHeight >= self.ba_maxHeight ? self.ba_maxHeight : current_textHeight;
        
        if (current_textViewHeight >= self.ba_minHeight)
        {
            // 改变 textView 的高度
            CGRect new_frame = self.frame;
            if (current_textViewHeight > self.ba_maxHeight)
            {
                current_textViewHeight = self.ba_maxHeight;
            }
            
            new_frame.size.height = current_textViewHeight;
            self.frame = new_frame;
            
            if (self.ba_textView_HeightDidChangedBlock)
            {
                self.ba_textView_HeightDidChangedBlock(current_textViewHeight);
            }
            self.ba_lastHeight = current_textViewHeight;
            [self ba_scrollToBottomAnimated:NO];
        }
    }
}

/**
 *  遍历截取字符串方法
 *
 *  @param originString       截取前的字符串
 *  @param toIndex      截取到什么位置
 *  @return 截取之后的字符串
 */
- (NSString *)enumerateSubstring:(NSString *)originString to:(NSUInteger)toIndex{
    //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
    __block NSInteger idx =0;
    __block NSString  *subsequentString = @"";//截取出的字串
    //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
    [originString enumerateSubstringsInRange:NSMakeRange(0, [originString length])
                                      options:NSStringEnumerationByComposedCharacterSequences
                                   usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange,BOOL* stop) {
                                       idx += substringRange.length;
                                       if (idx >= toIndex) {
                                           *stop = YES;//取出所需要就break，提高效率
                                           return ;
                                       }
                                       subsequentString = [subsequentString stringByAppendingString:substring];
                                       
                                   }];
    return subsequentString;
}

#pragma mark - 通知事件处理
- (void)handleDidBeginEditingNotificationAction:(NSNotification *)notification
{
    if (![self isEqual:notification.object]) {
//        通知会接收到所有的textview发来的通知，因此需要过滤
        return;
    }
    // 开始编辑时判断，如果内容字符是 placeholder 则清空，如果不是则保留         by 张浩
    // 3.如果此时 ba_text 为空并且 text == placeholder 则说明是 placeholder。否则就说明是用户输入文本
    if ([self.text isEqualToString:self.ba_placeholder]
        && [self isFirstResponder]
        && (self.ba_text == nil || [self.ba_text isEqualToString:@""]) )
    {
        //        NSLog(@"%s，开始编辑", __func__);
        self.text = @"";
        self.font = self.ba_textFont;
        self.textColor = self.ba_textColor;
//        self.ba_isNotPlaceHolder = YES;
    }
}

- (void)handleDidEndEditingNotificationAction:(NSNotification *)notification
{
    if (![self isEqual:notification.object]) {
//        通知会接收到所有的textview发来的通知，因此需要过滤
        return;
    }
    // 1.先将text接出来
    self.ba_text = self.text;
    //    NSLog(@"%s %@", __func__, self.ba_text);
    // 2.如果是没有则显示 placeholder，并且此时 ba_text 为空
    if (self.text.length == 0)
    {
        //        NSLog(@"%s，结束编辑", __func__);
        self.text = self.ba_placeholder;
        self.font = self.ba_placeholderFont;
        self.textColor = self.ba_placeholderColor;
    }
}

/**
 快速设定自动布局
 
 @param maxHeight 最大高度
 @param minHeight 最小高度
 @param block BAKit_TextView_HeightDidChangedBlock
 */
- (void)ba_textView_autoLayoutWithMaxHeight:(CGFloat)maxHeight
                                  minHeight:(CGFloat)minHeight
                                      block:(BAKit_TextView_HeightDidChangedBlock)block
{
    self.ba_maxHeight = maxHeight;
    self.ba_minHeight = minHeight;
    self.ba_textView_HeightDidChangedBlock = block;
}

/**
 快速设定最大字数限制返回当前字数
 
 @param limitNumber 最大字数限制
 @param block BAKit_TextView_WordDidChangedBlock
 */
- (void)ba_textView_wordLimitWithMaxWordLimitNumber:(NSInteger)limitNumber
                                              block:(BAKit_TextView_WordDidChangedBlock)block
{
    self.ba_maxWordLimitNumber = limitNumber;
    self.ba_textView_WordDidChangedBlock = block;
}

- (void)ba_scrollToBottomAnimated:(BOOL)animated
{
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)ba_textView_dealloc
{
    [self ba_removeNoti];
}

- (void)ba_removeNoti
{
    [BAKit_NotiCenter removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [BAKit_NotiCenter removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
    [BAKit_NotiCenter removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)ba_textView_default
{
    if (!self.ba_maxHeight)
    {
        self.ba_maxHeight = CGFLOAT_MAX;
    }
    if (!self.ba_textFont)
    {
        self.ba_textFont = [UIFont systemFontOfSize:15];
    }
    if (!self.ba_textColor)
    {
        self.ba_textColor = [UIColor blackColor];
    }
//    self.textContainerInset = UIEdgeInsetsMake(5, 0, 5, 15);
    [self ba_textView_addNoti];
}

- (void)setBa_text:(NSString *)ba_text
{
    BAKit_Objc_setObj(@selector(ba_text), ba_text);
    self.text = ba_text;
    self.textColor = self.ba_textColor;
    self.font = self.ba_textFont;
    [self ba_textView_default];
}

- (NSString *)ba_text
{
    return BAKit_Objc_getObj;
}

#pragma mark - setter / getter
- (void)setBa_placeholder:(NSString *)ba_placeholder
{
    BAKit_Objc_setObj(@selector(ba_placeholder), ba_placeholder);
    if (self.ba_isNotPlaceHolder)
    {
        NSLog(@"self.ba_tex:%@",self.ba_text);
        if (!self.ba_text)
        {
            self.text = self.ba_placeholder;
            [self ba_textView_default];
        }
    }
}

- (NSString *)ba_placeholder
{
    return BAKit_Objc_getObj;
}

- (void)setBa_placeholderColor:(UIColor *)ba_placeholderColor
{
    BAKit_Objc_setObj(@selector(ba_placeholderColor), ba_placeholderColor);
    if (self.ba_isNotPlaceHolder)
    {
        if (!self.ba_text)
        {
            self.textColor = self.ba_placeholderColor;
            [self ba_textView_default];
        }
    }
}

- (UIColor *)ba_placeholderColor
{
    return BAKit_Objc_getObj;
}

- (void)setBa_placeholderFont:(UIFont *)ba_placeholderFont
{
    BAKit_Objc_setObj(@selector(ba_placeholderFont), ba_placeholderFont);
    if (self.ba_isNotPlaceHolder)
    {
        if (!self.ba_text)
        {
            self.font = self.ba_placeholderFont;
            [self ba_textView_default];
        }
        
    }
}

- (UIFont *)ba_placeholderFont
{
    return BAKit_Objc_getObj;
}

- (void)setBa_maxHeight:(CGFloat)ba_maxHeight
{
    BAKit_Objc_setObj(@selector(ba_maxHeight), @(ba_maxHeight));
    [self ba_textView_default];
}

- (CGFloat)ba_maxHeight
{
    return [BAKit_Objc_getObj floatValue];
}

- (void)setBa_minHeight:(CGFloat)ba_minHeight
{
    BAKit_Objc_setObj(@selector(ba_minHeight), @(ba_minHeight));
    [self ba_textView_default];
}

- (CGFloat)ba_minHeight
{
    return [BAKit_Objc_getObj floatValue];
}

- (void)setBa_lastHeight:(CGFloat)ba_lastHeight
{
    BAKit_Objc_setObj(@selector(ba_lastHeight), @(ba_lastHeight));
}

- (CGFloat)ba_lastHeight
{
    return [BAKit_Objc_getObj floatValue];
}

- (void)setBa_textView_HeightDidChangedBlock:(BAKit_TextView_HeightDidChangedBlock)ba_textView_HeightDidChangedBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_textView_HeightDidChangedBlock), ba_textView_HeightDidChangedBlock);
    [self ba_textView_default];
}

- (BAKit_TextView_HeightDidChangedBlock)ba_textView_HeightDidChangedBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_textFont:(UIFont *)ba_textFont
{
    BAKit_Objc_setObj(@selector(ba_textFont), ba_textFont);
    self.font = self.ba_textFont;
    [self ba_textView_default];
}

- (UIFont *)ba_textFont
{
    return BAKit_Objc_getObj;
}

- (void)setBa_textColor:(UIColor *)ba_textColor
{
    BAKit_Objc_setObj(@selector(ba_textColor), ba_textColor);
    if (!self.ba_isNotPlaceHolder)
    {
        self.textColor = ba_textColor;
        [self ba_textView_default];
    }
}

- (UIColor *)ba_textColor
{
    return BAKit_Objc_getObj;
}

- (void)setBa_maxWordLimitNumber:(NSInteger)ba_maxWordLimitNumber
{
    BAKit_Objc_setObj(@selector(ba_maxWordLimitNumber), @(ba_maxWordLimitNumber));
}

- (NSInteger)ba_maxWordLimitNumber
{
    return [BAKit_Objc_getObj integerValue];
}

- (void)setBa_textView_WordDidChangedBlock:(BAKit_TextView_WordDidChangedBlock)ba_textView_WordDidChangedBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_textView_WordDidChangedBlock), ba_textView_WordDidChangedBlock);
    [self ba_textView_default];
}

- (BAKit_TextView_WordDidChangedBlock)ba_textView_WordDidChangedBlock
{
    return BAKit_Objc_getObj;
}

- (void)setba_textView_ShouldChangeTextInRangeBlock:(BAKit_TextView_ShouldChangeTextInRangeBlock)ba_textView_ShouldChangeTextInRangeBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_textView_ShouldChangeTextInRangeBlock), ba_textView_ShouldChangeTextInRangeBlock);
}

- (BAKit_TextView_ShouldChangeTextInRangeBlock)ba_textView_ShouldChangeTextInRangeBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_isNotPlaceHolder:(BOOL)ba_isNotPlaceHolder
{
    BAKit_Objc_setObj(@selector(ba_isNotPlaceHolder), @(ba_isNotPlaceHolder));
}

- (BOOL)ba_isNotPlaceHolder
{
    if (self.ba_placeholder)
    {
        return YES;
    }
    return NO;
}

- (void)setBa_PlaceHolderTemp:(NSString *)ba_PlaceHolderTemp
{
    BAKit_Objc_setObj(@selector(ba_PlaceHolderTemp), ba_PlaceHolderTemp);
}

- (NSString *)ba_PlaceHolderTemp
{
    return BAKit_Objc_getObj;
}

@end
