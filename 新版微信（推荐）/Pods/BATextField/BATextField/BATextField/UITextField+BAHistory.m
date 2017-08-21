//
//  UITextField+BAHistory.m
//  BAKit
//
//  Created by boai on 2017/6/10.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UITextField+BAHistory.h"
#import "BAKit_ConfigurationDefine.h"
#import "UIView+BAFrame.h"
#import "BAKit_UserDefaults.h"

static CGFloat const kBAAnimationDuration = 0.5f;

static NSString * const kCellID = @"UITextFieldHistoryCell";
static void *tableView_historyKey = @"tableView_historyKey";

@interface UITextField ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong) UITableView *tableView_history;

@end

@implementation UITextField (BAHistory)

/**
 同步输入内容到 NSUserDefaults
 */
- (void)ba_textFieldHistoryArraySynchronize
{
    if (BAKit_stringIsBlank_pod(self.ba_textFieldID) || BAKit_stringIsBlank_pod(self.text))
    {
        return;
    }
    
    NSDictionary *dict = [BAKit_NSUserDefaults objectForKey:kCellID];
    NSArray *historyArray = dict[self.ba_textFieldID];
    NSMutableArray *historyArray_new = [NSMutableArray arrayWithArray:historyArray];
    
    __block BOOL isHaveSameRecord = false;
    BAKit_WeakSelf
    [historyArray_new enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BAKit_StrongSelf
        if ([(NSString *)obj isEqualToString:self.text])
        {
            *stop = true;
            isHaveSameRecord = true;
        }
        
    }];
    
    if (isHaveSameRecord)
    {
        return;
    }
    
    [historyArray_new addObject:self.text];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithDictionary:dict];
    [dict2 setObject:historyArray_new forKey:self.ba_textFieldID];
    
    [BAKit_NSUserDefaults setObject:dict2 forKey:kCellID];
}

/**
 显示 HistoryArray
 */
- (void)ba_textFieldHistoryArrayShow
{
    NSArray *history = self.ba_textFieldHistoryArray;
    if (self.tableView_history.superview != nil || history == nil || history.count == 0)
    {
        return;
    }
    
    CGRect frame1 = CGRectMake(self.x, self.bottom + 1, self.width, 1);
    CGRect frame2 = CGRectMake(self.x, self.bottom + 1, self.width, MIN(BAKit_Margin_150_pod * 2, BAKit_Margin_40_pod * (self.ba_textFieldHistoryArray.count + 1)));

    self.tableView_history.frame = frame1;
    [self.superview addSubview:self.tableView_history];

    BAKit_WeakSelf
    [UIView animateWithDuration:kBAAnimationDuration animations:^{
        BAKit_StrongSelf
        self.tableView_history.frame = frame2;
    }];
    [self.tableView_history reloadData];
}

/**
 隐藏 HistoryArray
 */
- (void)ba_textFieldHistoryArrayHide
{
    if (self.tableView_history.superview == nil)
    {
        return;
    }
    
    CGRect frame1 = CGRectMake(self.x, self.bottom + 1, self.width, 1);
    
    BAKit_WeakSelf
    [UIView animateWithDuration:kBAAnimationDuration animations:^{
        BAKit_StrongSelf
        self.tableView_history.frame = frame1;
    } completion:^(BOOL finished) {
        BAKit_StrongSelf
        [self.tableView_history removeFromSuperview];
    }];
}

/**
 清除 HistoryArray
 */
- (void)ba_textFieldHistoryArrayClear
{
    [BAKit_UserDefaults ba_archive_removeObjectForKey:kCellID];
}

- (void)handleButtonAction:(UIButton *)sender
{
    [self ba_textFieldHistoryArrayClear];
    [self ba_textFieldHistoryArrayHide];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ba_textFieldHistoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
    }
    cell.textLabel.text = self.ba_textFieldHistoryArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.text = self.ba_textFieldHistoryArray[indexPath.row];
    [self ba_textFieldHistoryArrayHide];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return BAKit_Margin_40_pod;
}

#pragma clang diagnostic pop
#pragma mark tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (BAKit_stringIsBlank_pod(self.ba_clearButtonTitle))
    {
        self.ba_clearButtonTitle = @"清楚历史内容";
    }
    if (!self.ba_clearButtonTitleColor)
    {
        self.ba_clearButtonTitleColor = [[UIColor blueColor] colorWithAlphaComponent:0.5f];
    }
    [clearButton setTitle:self.ba_clearButtonTitle forState:UIControlStateNormal];
    [clearButton setTitleColor:self.ba_clearButtonTitleColor forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return clearButton;
}

#pragma mark - setter / getter

- (void)setBa_textFieldID:(NSString *)ba_textFieldID
{
    BAKit_Objc_setObj(@selector(ba_textFieldID), ba_textFieldID);
}

- (NSString *)ba_textFieldID
{
    return BAKit_Objc_getObj;
}

- (NSArray *)ba_textFieldHistoryArray
{
    if (BAKit_stringIsBlank_pod(self.ba_textFieldID))
    {
        return nil;
    }
    
    NSDictionary *dict = [BAKit_NSUserDefaults objectForKey:kCellID];
    
    if (dict != nil)
    {
        return dict[self.ba_textFieldID];
    }
    return nil;
}

- (void)setBa_clearButtonTitle:(NSString *)ba_clearButtonTitle
{
    BAKit_Objc_setObj(@selector(ba_clearButtonTitle), ba_clearButtonTitle);
}

- (NSString *)ba_clearButtonTitle
{
    return BAKit_Objc_getObj;
}

- (void)setBa_clearButtonTitleColor:(UIColor *)ba_clearButtonTitleColor
{
    BAKit_Objc_setObj(@selector(ba_clearButtonTitleColor), ba_clearButtonTitleColor);
}

- (UIColor *)ba_clearButtonTitleColor
{
    return BAKit_Objc_getObj;
}

- (UITableView *)tableView_history
{
    UITableView *tableView2 = objc_getAssociatedObject(self, tableView_historyKey);

    if (!tableView2)
    {
        tableView2 = [[UITableView alloc] init];
        tableView2.backgroundColor = BAKit_Color_Gray_11_pod;
        tableView2.delegate = self;
        tableView2.dataSource = self;
        
//        tableView2.estimatedRowHeight = BAKit_Margin_40;
//        tableView2.rowHeight = UITableViewAutomaticDimension;
        
        tableView2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tableView2.layer.borderWidth = 1;
        
        [tableView2 registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
        
        objc_setAssociatedObject(self, tableView_historyKey, tableView2, OBJC_ASSOCIATION_RETAIN);
    }
    return tableView2;
}

@end
