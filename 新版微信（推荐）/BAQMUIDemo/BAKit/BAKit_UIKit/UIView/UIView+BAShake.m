//
//  UIView+BAShake.m
//  BAKit
//
//  Created by boai on 2017/6/10.
//  Copyright © 2017年 boai. All rights reserved.
//


#import "UIView+BAShake.h"

@implementation UIView (BAShake)

- (void)ba_shake
{
    [self ba_shake:10 withDelta:5 completion:nil];
}

- (void)ba_shake:(int)times
       withDelta:(CGFloat)delta
{
    [self ba_shake:times withDelta:delta completion:nil];
}

- (void)ba_shake:(int)times
       withDelta:(CGFloat)delta
      completion:(nullable void (^)(void))handler
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:BAKit_ShakeDirectionHorizontal completion:handler];
}

- (void)ba_shake:(int)times
       withDelta:(CGFloat)delta
           speed:(NSTimeInterval)interval
{
    [self ba_shake:times withDelta:delta speed:interval completion:nil];
}

- (void)ba_shake:(int)times
       withDelta:(CGFloat)delta
           speed:(NSTimeInterval)interval
      completion:(nullable void (^)(void))handler
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:BAKit_ShakeDirectionHorizontal completion:handler];
}

- (void)ba_shake:(int)times
       withDelta:(CGFloat)delta
           speed:(NSTimeInterval)interval
  shakeDirection:(BAKit_ShakeDirection)shakeDirection
{
    [self ba_shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)ba_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(BAKit_ShakeDirection)shakeDirection completion:(nullable void (^)(void))handler
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)_shake:(int)times
     direction:(int)direction
  currentTimes:(int)current
     withDelta:(CGFloat)delta
         speed:(NSTimeInterval)interval
shakeDirection:(BAKit_ShakeDirection)shakeDirection
    completion:(nullable void (^)())handler
{
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == BAKit_ShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self _shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:handler];
    }];
}

@end
