//
//  UIView+BATransition.m
//  BAAnimation
//
//  Created by 博爱 on 2017/1/5.
//  Copyright © 2017年 DS-Team. All rights reserved.
//

#import "UIView+BATransition.h"

@implementation UIView (BATransition)

#pragma mark - CATransition动画实现
/*!
 *  CATransition动画实现
 *
 *  @param type                转场动画类型【过渡效果】，默认：BATransitionTypeFade
 *  @param subType             转场动画将去的方向，默认：BATransitionSubtypeFromRight
 *  @param duration            转场动画持续时间，默认：0.8f
 *  @param timingFunction      计时函数，从头到尾的流畅度，默认：BATransitionTimingFunctionTypeDefault
 *  @param removedOnCompletion 在动画执行完时是否被移除，默认：YES
 *  @param forView             添加动画（转场动画是添加在层上的动画）
 */
- (void)ba_transitionWithType:(BATransitionType)type
                      subType:(BATransitionSubtype)subType
                     duration:(CFTimeInterval)duration
               timingFunction:(BATransitionTimingFunctionType)timingFunction
          removedOnCompletion:(BOOL)removedOnCompletion
                      forView:(UIView *)forView
{
    if (!duration)
    {
        duration = 0.8f;
    }
    /*! 定义个转场动画 */
    CATransition *transition = [CATransition animation];
    
    /*! 转场动画持续时间 */
    transition.duration = duration;
    /*! 转场动画类型【过渡效果】 */
    [self ba_selectTransitionType:type subType:subType timingFunction:timingFunction transition:transition];
    
    /*! 计时函数，从头到尾的流畅度 */
//    transition.timingFunction = timingFunction;
    /*! 在动画执行完时是否被移除 */
    transition.removedOnCompletion = removedOnCompletion;
    /*! 暂时不知,感觉与Progress一起用的,如果不加,Progress好像没有效果  */
//    transition.fillMode = fillMode;
    
//    transition.beginTime = beginTime;
    /*!
     图层的速率。 用于将父时间缩放为本地时间，例如
     *如果rate为2，本地时间的进度是父时间的两倍。
     *默认为1.  */
//    transition.speed = beginTime;
    /*! 动画停止(在整体动画的百分比).  */
//    transition.endProgress = beginTime;
    /*! 动画开始(在整体动画的百分比).   */
//    transition.startProgress = beginTime;
    
    /*! 添加动画（转场动画是添加在层上的动画） */
    [forView.layer addAnimation:transition forKey:nil];
}

#pragma - UIView实现动画
/*!
 *  UIView实现动画
 *
 *  @param duration       转场动画持续时间，默认：0.8f
 *  @param animationCurve 动画曲线，默认：UIViewAnimationCurveEaseInOut
 *  @param transition     动画过渡，默认：UIViewAnimationTransitionNone
 *  @param forView        添加动画（转场动画是添加在层上的动画）
 */
- (void)ba_transitionViewWithDuration:(CFTimeInterval)duration
                       animationCurve:(UIViewAnimationCurve)animationCurve
                           transition:(UIViewAnimationTransition)transition
                              forView:(UIView *)forView
{
    if (!duration)
    {
        duration = 0.8f;
    }
    if (!animationCurve)
    {
        animationCurve = UIViewAnimationCurveEaseInOut;
    }
    if (!transition)
    {
        transition = UIViewAnimationTransitionNone;
    }
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:animationCurve];
        [UIView setAnimationTransition:transition forView:forView cache:YES];
    }];
}

- (void)ba_selectTransitionType:(BATransitionType)type
                        subType:(BATransitionSubtype)subType
                 timingFunction:(BATransitionTimingFunctionType)timingFunction
                     transition:(CATransition *)transition
{
    if (!type)
    {
        type = BATransitionTypeFade;
    }
    switch (type) {
        case BATransitionTypeFade:
            transition.type = kCATransitionFade;
            break;
            
        case BATransitionTypePush:
            transition.type = kCATransitionPush;
            break;
            
        case BATransitionTypeReveal:
            transition.type = kCATransitionReveal;
            break;
            
        case BATransitionTypeMoveIn:
            transition.type = kCATransitionMoveIn;
            break;
            
        case BATransitionTypeCube:
            transition.type = @"cube";
            break;
            
        case BATransitionTypeSuckEffect:
            transition.type = @"suckEffect";
            break;
            
        case BATransitionTypeOglFlip:
            transition.type = @"oglFlip";
            break;
            
        case BATransitionTypeRippleEffect:
            transition.type = @"rippleEffect";
            break;
            
        case BATransitionTypePageCurl:
            transition.type = @"pageCurl";
            break;
            
        case BATransitionTypePageUnCurl:
            transition.type = @"pageUnCurl";
            break;
            
        case BATransitionTypeCameraIrisHollowOpen:
            transition.type = @"cameraIrisHollowOpen";
            break;
            
        case BATransitionTypeCameraIrisHollowClose:
            transition.type = @"cameraIrisHollowClose";
            break;
            
        default:
            break;
    }
    
    if (!subType)
    {
        subType = BATransitionSubtypeFromRight;
    }
    switch (subType) {
        case BATransitionSubtypeFromTop:
            transition.subtype = kCATransitionFromTop;
            break;
        case BATransitionSubtypeFromBottom:
            transition.subtype = kCATransitionFromBottom;
            break;
        case BATransitionSubtypeFromLeft:
            transition.subtype = kCATransitionFromLeft;
            break;
        case BATransitionSubtypeFromRight:
            transition.subtype = kCATransitionFromRight;
            break;
            
        default:
            break;
    }
    
    if (!timingFunction)
    {
        timingFunction = BATransitionTimingFunctionTypeDefault;
    }
    switch (timingFunction) {
        case BATransitionTimingFunctionTypeDefault:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            break;
            
        case BATransitionTimingFunctionTypeLinear:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
        case BATransitionTimingFunctionTypeEaseIn:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
        case BATransitionTimingFunctionTypeEaseOut:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case BATransitionTimingFunctionTypeEaseInEaseOut:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;

        default:
            break;
    }
}


@end
