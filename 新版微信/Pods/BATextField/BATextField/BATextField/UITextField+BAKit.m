//
//  UITextField+BAKit.m
//  BAQMUIDemo
//
//  Created by boai on 2017/5/31.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "UITextField+BAKit.h"
#import "BAKit_ConfigurationDefine.h"

@implementation UITextField (BAKit)

/**
 判断 UITextField 输入的是否为空

 @return YES，NO
 */
- (BOOL)ba_textField_isEmpty
{
    return (self == nil || self.text == nil || [self.text isEqualToString:@""]);
}

/**
 选中所有文字
 */
- (void)ba_textField_selectAllText
{
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

/**
 当前选中的字符串范围
 
 @return NSRange
 */
- (NSRange)ba_textField_selectedRange
{
    UITextPosition *beginPosition = self.beginningOfDocument;
    
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    NSInteger location = [self offsetFromPosition:beginPosition toPosition:selectionStart];
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

/**
 选中指定范围的文字
 
 @param range NSRange 范围
 */
- (void)ba_textField_setSelectedRange:(NSRange)range
{
    UITextPosition *beginPosition = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginPosition offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:startPosition offset:NSMaxRange(range)];
    
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

- (void)handleTextFieldTextDidChangeAction
{
    NSString *toBeginString = self.text;
    // 获取高亮部分
    UITextRange *selectRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    // 在 iOS 7下, position 对象总是不为 nil
    if ((!position || !selectRange) && (self.ba_maxLength > 0 && toBeginString.length > self.ba_maxLength && [self isFirstResponder]))
    {
        NSRange rangeIndex = [toBeginString rangeOfComposedCharacterSequenceAtIndex:self.ba_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeginString substringToIndex:self.ba_maxLength];
        }
        else
        {
            NSRange tempRange = [toBeginString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.ba_maxLength)];
            NSInteger tempLength;
            if (tempRange.length > self.ba_maxLength)
            {
                tempLength = tempRange.length - rangeIndex.length;
            }
            else
            {
                tempLength = tempRange.length;
            }
            self.text = [toBeginString substringWithRange:NSMakeRange(0, tempLength)];
        }
    }
}

#pragma mark - setter / getter
- (void)setBa_placeholderColor:(UIColor *)ba_placeholderColor
{
    BAKit_Objc_setObj(@selector(ba_placeholderColor), ba_placeholderColor);
    [self setValue:ba_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)ba_placeholderColor
{
    return BAKit_Objc_getObj;
}

- (void)setBa_placeholderFont:(UIFont *)ba_placeholderFont
{
    BAKit_Objc_setObj(@selector(ba_placeholderFont), ba_placeholderFont);
    [self setValue:ba_placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

- (UIFont *)ba_placeholderFont
{
    return BAKit_Objc_getObj;
}

- (void)setBa_maxLength:(NSInteger)ba_maxLength
{
    BAKit_Objc_setObj(@selector(ba_maxLength), @(ba_maxLength));
    [self addTarget:self action:@selector(handleTextFieldTextDidChangeAction) forControlEvents:UIControlEventEditingChanged];
}

- (NSInteger)ba_maxLength
{
  return [BAKit_Objc_getObj integerValue];
}

@end
