//
//  UIView+BAAnimation.m
//  BAAnimation
//
//  Created by 博爱 on 2016/12/19.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import "UIView+BAAnimation.h"

#import "CALayer+BAAnimation.h"

@implementation UIView (BAAnimation)

/*!
 *  缩放显示动画
 *
 *  @param duration    持续时间，默认：1.0f
 *  @param scaleRatio  缩放比率，默认：1.6f
 *  @param finishBlock 缩放完成回调
 */
- (void)ba_animation_scaleShowWithDuration:(CGFloat)duration
                                 ratio:(CGFloat)scaleRatio
                           finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.0f;
    }
    if (!scaleRatio)
    {
        scaleRatio = 1.6f;
    }

    self.transform = CGAffineTransformScale(self.transform, 0.01f, 0.01f);
    
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformIdentity;
//            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        } completion:^(BOOL finished) {
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

/*!
 *  缩放消失动画
 *
 *  @param duration    持续时间，默认：1.0f
 *  @param scaleRatio  缩放比率，默认：1.6f
 *  @param finishBlock 缩放完成回调
 */
- (void)ba_animation_scaleDismissWithDuration:(CGFloat)duration
                                 ratio:(CGFloat)scaleRatio
                           finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.0f;
    }
    if (!scaleRatio)
    {
        scaleRatio = 1.6f;
    }

    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformMakeScale(0.0001f, 0.0001f);
        } completion:^(BOOL finished) {
            if (finishBlock) {
                finishBlock();
            }
        }];
    }];
}

/*!
 *  透明度动画
 *
 *  @param duration    持续时间，默认：1.5f
 *  @param startAlpha  开始的 alpha，默认：0.2f
 *  @param finishAlpha 结束的 alpha，默认：1.0f
 */
- (void)ba_animation_alphaWithDuration:(CGFloat)duration
                            startAlpha:(CGFloat)startAlpha
                           finishAlpha:(CGFloat)finishAlpha
{
    if (!duration)
    {
        duration = 1.5f;
    }
    if (!startAlpha)
    {
        startAlpha = 0.2f;
    }
    if (!finishAlpha)
    {
        finishAlpha = 1.0f;
    }
    [UIView animateWithDuration:duration animations:^{
        self.alpha = startAlpha;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.alpha = finishAlpha;
        }];
    }];
}

/*!
 *  转场动画
 *
 *  @param duration      持续时间，默认：1.5f
 *  @param startOptions  开始转场动画样式
 *  @param finishOptions 结束转场动画样式
 *  @param finishBlock   转场结束回调
 */
- (void)ba_animation_transitionWithDuration:(CGFloat)duration
                               startOptions:(UIViewAnimationOptions)startOptions
                               finishOptions:(UIViewAnimationOptions)finishOptions
                                finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView transitionWithView:self duration:duration options:startOptions animations:^{
        
    } completion:^(BOOL finished) {
        [UIView transitionWithView:self duration:duration options:finishOptions animations:^{
            
        } completion:^(BOOL finished) {
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

/*!
 *  改变 frame 动画
 *
 *  @param duration      持续时间，默认：1.5f
 *  @param originalFrame 原始 frame
 *  @param newFrame      更改后的 frame
 *  @param finishBlock   结束回调
 */
- (void)ba_animation_changFrameWithDuration:(CGFloat)duration
                              originalFrame:(CGRect)originalFrame
                                   newFrame:(CGRect)newFrame
                                finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView animateWithDuration:duration animations:^{
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = originalFrame;
        } completion:^(BOOL finished) {
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

/*!
 *  改变 Bounds 动画
 *
 *  @param duration       持续时间，默认：1.5f
 *  @param originalBounds 原始 Bounds
 *  @param newBounds      更改后的 Bounds
 *  @param finishBlock    结束回调
 */
- (void)ba_animation_changBoundsWithDuration:(CGFloat)duration
                              originalBounds:(CGRect)originalBounds
                                   newBounds:(CGRect)newBounds
                                finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView animateWithDuration:duration animations:^{
        self.bounds = newBounds;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.bounds = originalBounds;
        } completion:^(BOOL finished) {
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

/*!
 *  改变 Center 动画
 *
 *  @param duration       持续时间，默认：1.5f
 *  @param originalCenter 原始 Center
 *  @param newCenter      更改后的 Center
 *  @param finishBlock    结束回调
 */
- (void)ba_animation_changCenterWithDuration:(CGFloat)duration
                              originalCenter:(CGPoint)originalCenter
                                   newCenter:(CGPoint)newCenter
                                 finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView animateWithDuration:duration animations:^{
        self.center = newCenter;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.center = originalCenter;
        } completion:^(BOOL finished) {
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

/**
 弹簧动画

 @param duration 持续时间，默认：1.5f
 @param delay delay
 @param damping 震动效果，范围0~1，数值越小震动效果越明显
 @param initialSpringVelocity 初始速度，数值越大初始速度越快，默认：1.0f
 @param startOptions 动画的过渡效果
 @param finishOptions 动画的过渡效果
 @param startBlock 开始动画回调
 @param finishBlock 结束动画回调
 */
- (void)ba_animation_springWithDuration:(CGFloat)duration
                                  delay:(CGFloat)delay
                                damping:(CGFloat)damping
                  initialSpringVelocity:(CGFloat)initialSpringVelocity
                           startOptions:(UIViewAnimationOptions)startOptions
                          finishOptions:(UIViewAnimationOptions)finishOptions
                            startBlock:(void(^)())startBlock
                            finishBlock:(void(^)())finishBlock
{
    if (!duration)
    {
        duration = 1.5f;
    }
    if (!damping)
    {
        damping = 1.0f;
    }
    if (!initialSpringVelocity)
    {
        initialSpringVelocity = 1.0f;
    }
    [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:damping initialSpringVelocity:initialSpringVelocity options:startOptions animations:^{
        if (startBlock)
        {
            startBlock();
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:0.f usingSpringWithDamping:damping initialSpringVelocity:initialSpringVelocity options:finishOptions animations:^{
        } completion:^(BOOL finished) {
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

/**
 view 出现动画
 
 @param positionType 位置类型
 @param duration duration 默认：1.0f
 @param finishBlock finishBlock
 */
- (void)ba_animation_showFromPositionType:(BAKit_ViewAnimationEnterDirectionType)positionType
                                 duration:(CGFloat)duration
                              finishBlock:(void(^)())finishBlock
{
    CGPoint min_center = self.center;
    CGPoint min_center2 = self.center;
    CGRect  min_frame  = self.frame;
    CGSize  min_screen_size = [UIScreen mainScreen].bounds.size;

    switch (positionType) {
        case BAKit_ViewAnimationEnterDirectionTypeTop:
        {
            // From
            min_center.y = -min_frame.size.height;
            self.center = min_center;
            
            // TO
//            min_center.y = (min_screen_size.height - min_frame.size.height) * 0.5;
            min_center.y = min_center2.y;
        }
            break;
        case BAKit_ViewAnimationEnterDirectionTypeLeft:
        {
            // From
            min_center.x = - min_center.x - min_screen_size.width * 0.5;
            self.center = min_center;
            
            // TO
            //            min_center.x = (min_screen_size.width - min_frame.size.width) * 0.5;
            min_center.x = min_center2.x;
        }
            break;
        case BAKit_ViewAnimationEnterDirectionTypeBottom:
        {
            // From
            min_center.y = min_screen_size.height + min_frame.size.height;
            self.center = min_center;
            
            // TO
//            min_center.y = (min_screen_size.height - min_frame.size.height) * 0.5;
            min_center.y = min_center2.y;
        }
            break;
        case BAKit_ViewAnimationEnterDirectionTypeRitht:
        {
            // From
            min_center.x = min_screen_size.width + min_frame.size.width;
            self.center = min_center;
            
            // TO
//            min_center.x = (min_screen_size.width - min_frame.size.width) * 0.5;
            min_center.x = min_center2.x;
        }
            break;
            
        default:
            break;
    }
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView animateWithDuration:duration animations:^{
//        self.alpha = 0.3f;
        self.center = min_center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.f animations:^{
//            self.alpha = 1.0f;
            if (finishBlock)
            {
                finishBlock();
            }
        }];
    }];
}

- (void)ba_view_showFromScreenBottom
{
    CGRect frame = self.frame;
    
    // frame.origin.x = 0;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    self.frame = frame;
    
    // TO POS
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

/**
 view 消失动画
 
 @param positionType 位置类型
 @param duration duration 默认：1.0f
 @param finishBlock finishBlock
 */
- (void)ba_animation_dismissFromPositionType:(BAKit_ViewAnimationEnterDirectionType)positionType
                                    duration:(CGFloat)duration
                                 finishBlock:(void(^)())finishBlock
{
    CGPoint min_center = self.center;
    CGRect  min_frame  = self.frame;
    CGSize  min_screen_size = [UIScreen mainScreen].bounds.size;
    
    switch (positionType) {
        case BAKit_ViewAnimationEnterDirectionTypeTop:
        {
            min_center.y = - min_frame.size.height * 0.5;
        }
            break;
        case BAKit_ViewAnimationEnterDirectionTypeBottom:
        {
            min_center.y = min_screen_size.height + min_frame.size.height * 0.5;
        }
            break;
        case BAKit_ViewAnimationEnterDirectionTypeLeft:
        {
            min_center.x = - min_center.x - min_screen_size.width * 0.5;
        }
            break;
        case BAKit_ViewAnimationEnterDirectionTypeRitht:
        {
            min_center.x = min_screen_size.width + min_frame.size.width;
        }
            break;
            
        default:
            break;
    }
    if (!duration)
    {
        duration = 1.5f;
    }
    [UIView animateWithDuration:duration animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.center = min_center;
        } completion:^(BOOL finished) {
            if (finishBlock) {
                finishBlock();
            }
        }];
    }];
}

/**
 view 翻转动画
 
 @param duration 位置类型
 @param direction duration 默认：1.0f
 */
- (void)ba_animation_flipWithDuration:(NSTimeInterval)duration
                            direction:(BAKit_ViewAnimationFlipDirectionType)direction
{
    if (!duration)
    {
        duration = 1.5f;
    }
    NSString *subtype = nil;
    
    switch(direction)
    {
        case BAKit_ViewAnimationFlipDirectionTypeTop:
            subtype = @"fromTop";
            break;
        case BAKit_ViewAnimationFlipDirectionTypeLeft:
            subtype = @"fromLeft";
            break;
        case BAKit_ViewAnimationFlipDirectionTypeBottom:
            subtype = @"fromBottom";
            break;
        case BAKit_ViewAnimationFlipDirectionTypeRight:
        default:
            subtype = @"fromRight";
            break;
    }
    
    CATransition *transition = [CATransition animation];
    
    transition.startProgress = 0;
    transition.endProgress = 1.0;
    transition.type = @"flip";
    transition.subtype = subtype;
    transition.duration = duration;
    transition.repeatCount = 1;
    transition.autoreverses = 1;
    
    [self.layer addAnimation:transition forKey:@"flip"];
}

- (void)ba_animation_translateAroundTheView:(UIView *)topView
                      duration:(CGFloat)duration
                     direction:(UIViewAnimationTranslationDirection)direction
                        repeat:(BOOL)repeat
                 startFromEdge:(BOOL)startFromEdge
{
    CGFloat startPosition = self.center.x, endPosition;
    switch(direction)
    {
        case UIViewAnimationTranslationDirectionFromLeftToRight:
        {
            startPosition = self.frame.size.width / 2;
            endPosition = -(self.frame.size.width / 2) + topView.frame.size.width;
            break;
        }
        case UIViewAnimationTranslationDirectionFromRightToLeft:
        default:
        {
            startPosition = -(self.frame.size.width / 2) + topView.frame.size.width;
            endPosition = self.frame.size.width / 2;
            break;
        }
    }
    
    if(startFromEdge)
    {
        [self setCenter:CGPointMake(startPosition, self.center.y)];
    }
    
    [UIView animateWithDuration:duration / 2 delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self setCenter:CGPointMake(endPosition, self.center.y)];
    } completion:^(BOOL finished) {
        if(finished)
        {
            [UIView animateWithDuration:duration / 2 delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setCenter:CGPointMake(startPosition, self.center.y)];
            } completion:^(BOOL finished) {
                if(finished)
                {
                    if(repeat)
                    {
                        [self ba_animation_translateAroundTheView:topView duration:duration direction:direction repeat:repeat startFromEdge:startFromEdge];
                    }
                }
            }];
        }
    }];
}

/**
 线性梯度：渐变色，注意：渐变颜色必须要有两个及两个以上颜色，否则设置无效！

 @param colorArray 颜色数组，至少两个
 @param frame frame
 @param direction 方向，横向还是纵向
 */
- (void)ba_animation_createGradientWithColorArray:(NSArray *)colorArray
                                  frame:(CGRect)frame
                              direction:(UIViewLinearGradientDirection)direction
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    
    NSMutableArray *mutableColors = colorArray.mutableCopy;
    if (colorArray.count < 2)
    {
        NSLog(@"%s，渐变颜色必须要有两个及两个以上颜色，否则设置无效！", __func__);
        return;
    }
    for(int i = 0; i < colorArray.count; i++)
    {
        UIColor *currentColor = colorArray[i];
        [mutableColors replaceObjectAtIndex:i withObject:(id)currentColor.CGColor];
    }
    gradient.colors = mutableColors;
    
    switch (direction)
    {
        case UIViewLinearGradientDirectionVertical:
        {
            gradient.startPoint = CGPointMake(0.5f, 0.0f);
            gradient.endPoint = CGPointMake(0.5f, 1.0f);
            break;
        }
        case UIViewLinearGradientDirectionHorizontal:
        {
            gradient.startPoint = CGPointMake(0.0f, 0.5f);
            gradient.endPoint = CGPointMake(1.0f, 0.5f);
            break;
        }
        case UIViewLinearGradientDirectionDiagonalFromLeftToRightAndTopToDown:
        {
            gradient.startPoint = CGPointMake(0.0f, 0.0f);
            gradient.endPoint = CGPointMake(1.0f, 1.0f);
            break;
        }
        case UIViewLinearGradientDirectionDiagonalFromLeftToRightAndDownToTop:
        {
            gradient.startPoint = CGPointMake(0.0f, 1.0f);
            gradient.endPoint = CGPointMake(1.0f, 0.0f);
            break;
        }
        case UIViewLinearGradientDirectionDiagonalFromRightToLeftAndTopToDown:
        {
            gradient.startPoint = CGPointMake(1.0f, 0.0f);
            gradient.endPoint = CGPointMake(0.0f, 1.0f);
            break;
        }
        case UIViewLinearGradientDirectionDiagonalFromRightToLeftAndDownToTop:
        {
            gradient.startPoint = CGPointMake(1.0f, 1.0f);
            gradient.endPoint = CGPointMake(0.0f, 0.0f);
            break;
        }
        default:
        {
            break;
        }
    }
    [self.layer insertSublayer:gradient atIndex:0];
}

/**
 *  摇晃动画：用于错误提示，晃动的幅度，默认：5.0f，晃动的次数，默认：5.0f
 */
- (void)ba_animation_viewAnimationShake
{
    [self.layer ba_layer_animationShakeWithValue:5.0f repeatCount:2.0f];
}

/**
 脉冲动画

 @param duration duration
 */
- (void)ba_animation_pulseViewWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration / 6 animations:^{
        [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    } completion:^(BOOL finished) {
        if(finished)
        {
            [UIView animateWithDuration:duration / 6 animations:^{
                [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
            } completion:^(BOOL finished) {
                if(finished)
                {
                    [UIView animateWithDuration:duration / 6 animations:^{
                        [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
                    } completion:^(BOOL finished) {
                        if(finished)
                        {
                            [UIView animateWithDuration:duration / 6 animations:^{
                                [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
                            } completion:^(BOOL finished) {
                                if(finished)
                                {
                                    [UIView animateWithDuration:duration / 6 animations:^{
                                        [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
                                    } completion:^(BOOL finished) {
                                        if(finished)
                                        {
                                            [UIView animateWithDuration:duration / 6 animations:^{
                                                [self setTransform:CGAffineTransformMakeScale(1, 1)];
                                            } completion:nil];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

/**
 心跳动画

 @param duration duration
 */
- (void)ba_animation_heartbeatViewWithDuration:(CGFloat)duration
{
    float maxSize = 1.4f, durationPerBeat = 0.5f;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.8, 0.8, 1);
    CATransform3D scale2 = CATransform3DMakeScale(maxSize, maxSize, 1);
    CATransform3D scale3 = CATransform3DMakeScale(maxSize - 0.3f, maxSize - 0.3f, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:scale1], [NSValue valueWithCATransform3D:scale2], [NSValue valueWithCATransform3D:scale3], [NSValue valueWithCATransform3D:scale4], nil];
    
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.05], [NSNumber numberWithFloat:0.2], [NSNumber numberWithFloat:0.6], [NSNumber numberWithFloat:1.0], nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.duration = durationPerBeat;
    animation.repeatCount = duration / durationPerBeat;
    
    [self.layer addAnimation:animation forKey:@"heartbeat"];
}

/**
 运动效果
 */
- (void)ba_animation_applyMotionEffects
{
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(-10.0f);
    horizontalEffect.maximumRelativeValue = @(10.0f);
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(-10.0f);
    verticalEffect.maximumRelativeValue = @(10.0f);
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
    
    [self addMotionEffect:motionEffectGroup];
}

/**
 UIView：简单的 alpha 动画

 @param alpha alpha description
 @param duration duration description
 @param animated animated description
 */
- (void)ba_animationWithAlpha:(CGFloat)alpha
                     duration:(NSTimeInterval)duration
                     animated:(BOOL)animated
{
    CGFloat effectiveAlpha = (alpha < 0 || alpha > 1) ? (alpha < 0 ? 0 : 1) : alpha;
    
    if (animated)
    {
        [UIView animateWithDuration:duration animations:^{
            self.alpha = effectiveAlpha;
        }];
    }
    else
    {
        self.alpha = alpha;
    }
}


@end
