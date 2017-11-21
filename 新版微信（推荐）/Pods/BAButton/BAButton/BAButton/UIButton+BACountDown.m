//
//  UIButton+BACountDown.m
//  BAButton
//
//  Created by 任子丰 on 16/6/17.
//  Copyright © 2016年 任子丰. All rights reserved.
//

#import "UIButton+BACountDown.h"
#import "BAKit_ConfigurationDefine.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, assign) NSTimeInterval leaveTime;
@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *countDownFormat;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation UIButton (BACountDown)

- (void)setTimer:(dispatch_source_t)timer {
    BAKit_Objc_setObj(@selector(timer), timer);
}

- (dispatch_source_t)timer {
    return BAKit_Objc_getObj;
}

- (void)setLeaveTime:(NSTimeInterval)leaveTime {
    BAKit_Objc_setObj(@selector(leaveTime), @(leaveTime));
}

- (NSTimeInterval)leaveTime {
     return  [BAKit_Objc_getObj doubleValue];
}

- (void)setCountDownFormat:(NSString *)countDownFormat {
    BAKit_Objc_setObjCOPY(@selector(countDownFormat), countDownFormat);
}

- (NSString *)countDownFormat {
    return BAKit_Objc_getObj;
}

- (void)setTimeStoppedCallback:(void (^)())timeStoppedCallback {
    BAKit_Objc_setObjCOPY(@selector(timeStoppedCallback), timeStoppedCallback);
}

- (void (^)())timeStoppedCallback {
    return BAKit_Objc_getObj;
}

- (void)setNormalTitle:(NSString *)normalTitle {
    BAKit_Objc_setObjCOPY(@selector(normalTitle), normalTitle);
}

- (NSString *)normalTitle {
    return BAKit_Objc_getObj;
}

#pragma mark - public
/**
 倒计时：带 title，返回时间，title，具体使用看 demo

 @param duration 倒计时时间
 @param format 可选，传nil默认为 @"%zd秒"
 */
- (void)ba_countDownWithTimeInterval:(NSTimeInterval)duration
                     countDownFormat:(NSString *)format
{
    if (!format)
    {
        self.countDownFormat = @"%zd秒";
    }
    else
    {
        self.countDownFormat = format;
    }
    self.normalTitle = self.titleLabel.text;
    __block NSInteger timeOut = duration; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    BAKit_WeakSelf
    dispatch_source_set_event_handler(self.timer, ^{
        BAKit_StrongSelf
        dispatch_async(dispatch_get_main_queue(), ^{
            if (timeOut <= 0) { // 倒计时结束，关闭
                [self ba_cancelTimer];
            } else {
                NSString *title = [NSString stringWithFormat:self.countDownFormat, timeOut];
                [self setTitle:title forState:UIControlStateNormal];
                timeOut--;
            }
        });
    });
    dispatch_resume(self.timer);
}

/**
 倒计时：返回当前时间，可以自定义 title 和 image，具体使用看 demo

 @param duration 倒计时时间
 @param block 返回当前时间
 */
- (void)ba_countDownCustomWithTimeInterval:(NSTimeInterval)duration
                                     block:(BAKit_BAButtonCountDownBlock)block
{
    __block NSInteger timeOut = duration; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    BAKit_WeakSelf
    dispatch_source_set_event_handler(self.timer, ^{
        BAKit_StrongSelf
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block)
            {
                block(timeOut);
            }
            if (timeOut <= 0)
            {
                // 倒计时结束，关闭
                [self ba_cancelTimer];
            }
            else
            {
                timeOut--;
            }
        });
        
    });
    dispatch_resume(self.timer);
}

/**
 * 倒计时：结束，取消倒计时
 */
- (void)ba_cancelTimer
{
    if (!self.timer)
    {
        return;
    }
    BAKit_WeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
        BAKit_StrongSelf
        dispatch_source_cancel(self.timer);
        self.timer = nil;

        // 设置界面的按钮显示 根据自己需求设置
        [self setTitle:self.normalTitle forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        if (self.timeStoppedCallback) { self.timeStoppedCallback(); }
    });
}

@end
