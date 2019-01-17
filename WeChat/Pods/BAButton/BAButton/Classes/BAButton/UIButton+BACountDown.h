//
//  UIButton+BACountDown.h
//  BAButton
//
//  Created by 任子丰 on 16/6/17.
//  Copyright © 2016年 任子丰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BAKit_BAButtonCountDownBlock)(NSInteger currentTime);

@interface UIButton (BACountDown)

@property (nonatomic, copy) void(^timeStoppedCallback)(void);

/**
 倒计时: 一行代码快速使用
 
 @param duration 倒计时时间
 @param format 可选，传nil默认为 @"%zd秒"
 @param title 结束后显示文字
 */
- (void)ba_countDownWithTimeInterval:(NSTimeInterval)duration
                     countDownFormat:(NSString *)format
                            endTitle:(NSString *)title;

/**
 倒计时：带 title，返回时间，title，具体使用看 demo

 @param duration 倒计时时间
 @param format 可选，传nil默认为 @"%zd秒"
 */
- (void)ba_countDownWithTimeInterval:(NSTimeInterval)duration
                     countDownFormat:(NSString *)format;

/**
 倒计时：返回当前时间，可以自定义 title 和 image，具体使用看 demo
 
 @param duration 倒计时时间
 @param block 返回当前时间
 */
- (void)ba_countDownCustomWithTimeInterval:(NSTimeInterval)duration
                                     block:(BAKit_BAButtonCountDownBlock)block;

/** 
 * 倒计时：结束，取消倒计时
 */
- (void)ba_cancelTimer;

@end
