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
 UITextField：首先设置代理
 
 @param delegate delegate description
 */
- (void)ba_textField_setDelegate:(id<UITextViewDelegate>)delegate
{
    self.delegate = delegate;
}

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

#pragma mark - UITextField delegate
// textField.text 输入之前的值 string 输入的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textField.keyboardType = UIKeyboardTypeDecimalPad;

    if ([textField.text rangeOfString:@"."].location == NSNotFound)
    {
        self.ba_isHaveDecimalPoint = NO;
    }
    
//    NSInteger number2 = self.ba_maxDecimalPointNumber;
    BOOL isHaveDecimalPoint = self.ba_isHaveDecimalPoint;

    if ([string length] > 0)
    {
        // 当前输入的字符
        unichar single = [string characterAtIndex:0];
        
        if ((single >= '0' && single <= '9') || single == '.')
        {
            // 数据格式正确
            // 首字母不能为 0 和 小数点
            if([textField.text length] == 0)
            {
                if(single == '.')
                {
                    NSLog(@"亲，第一个数字不能为小数点");
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                
                if (!self.ba_isFirstNumberZero)
                {
                    if (single == '0')
                    {
                        NSLog(@"亲，第一个数字不能为0");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                
            }
            
            // 输入的字符是否是小数点
            if (single == '.')
            {
                // text 中还没有小数点
                if(!isHaveDecimalPoint)
                {
                    self.ba_isHaveDecimalPoint = YES;
                    return YES;
                }
                else
                {
                    NSLog(@"亲，您已经输入过小数点了");
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDecimalPoint)
                {
                    //存在小数点
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= self.ba_maxDecimalPointNumber)
                    {
                        return YES;
                    }
                    else
                    {
                        NSLog(@"亲，您最多输入两位小数");
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }
        else
        {
            // 输入的数据格式不正确
            NSLog(@"亲，您输入的格式不正确");
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
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

- (void)setBa_maxDecimalPointNumber:(NSInteger)ba_maxDecimalPointNumber
{
    self.keyboardType = UIKeyboardTypeDecimalPad;
    BAKit_Objc_setObj(@selector(ba_maxDecimalPointNumber), @(ba_maxDecimalPointNumber));
}

- (NSInteger)ba_maxDecimalPointNumber
{
    return [BAKit_Objc_getObj integerValue];
}

- (void)setBa_isHaveDecimalPoint:(BOOL)ba_isHaveDecimalPoint
{
    BAKit_Objc_setObj(@selector(ba_isHaveDecimalPoint), @(ba_isHaveDecimalPoint));
}

- (BOOL)ba_isHaveDecimalPoint
{
    return [BAKit_Objc_getObj boolValue];
}

- (void)setBa_isFirstNumberZero:(BOOL)ba_isFirstNumberZero
{
    BAKit_Objc_setObj(@selector(ba_isFirstNumberZero), @(ba_isFirstNumberZero));
}

- (BOOL)ba_isFirstNumberZero
{
    return [BAKit_Objc_getObj boolValue];
}



@end
