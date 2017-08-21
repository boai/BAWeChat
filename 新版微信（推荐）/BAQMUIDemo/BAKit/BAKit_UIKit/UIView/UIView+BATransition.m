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
 *  @param type                转场动画类型【过渡效果】，默认：BAKit_ViewTransitionTypeFade
 *  @param subType             转场动画将去的方向，默认：BAKit_ViewTransitionSubtypeFromRight
 *  @param duration            转场动画持续时间，默认：0.8f
 *  @param timingFunction      计时函数，从头到尾的流畅度，默认：BAKit_ViewTransitionTimingFunctionTypeDefault
 *  @param removedOnCompletion 在动画执行完时是否被移除，默认：YES
 *  @param forView             添加动画（转场动画是添加在层上的动画）
 */
- (void)ba_transitionWithType:(BAKit_ViewTransitionType)type
                      subType:(BAKit_ViewTransitionSubtype)subType
                     duration:(CFTimeInterval)duration
               timingFunction:(BAKit_ViewTransitionTimingFunctionType)timingFunction
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

- (void)ba_selectTransitionType:(BAKit_ViewTransitionType)type
                        subType:(BAKit_ViewTransitionSubtype)subType
                 timingFunction:(BAKit_ViewTransitionTimingFunctionType)timingFunction
                     transition:(CATransition *)transition
{
    if (!type)
    {
        type = BAKit_ViewTransitionTypeFade;
    }
    switch (type) {
        case BAKit_ViewTransitionTypeFade:
            transition.type = kCATransitionFade;
            break;
            
        case BAKit_ViewTransitionTypePush:
            transition.type = kCATransitionPush;
            break;
            
        case BAKit_ViewTransitionTypeReveal:
            transition.type = kCATransitionReveal;
            break;
            
        case BAKit_ViewTransitionTypeMoveIn:
            transition.type = kCATransitionMoveIn;
            break;
            
        case BAKit_ViewTransitionTypeCube:
            transition.type = @"cube";
            break;
            
        case BAKit_ViewTransitionTypeSuckEffect:
            transition.type = @"suckEffect";
            break;
            
        case BAKit_ViewTransitionTypeOglFlip:
            transition.type = @"oglFlip";
            break;
            
        case BAKit_ViewTransitionTypeRippleEffect:
            transition.type = @"rippleEffect";
            break;
            
        case BAKit_ViewTransitionTypePageCurl:
            transition.type = @"pageCurl";
            break;
            
        case BAKit_ViewTransitionTypePageUnCurl:
            transition.type = @"pageUnCurl";
            break;
            
        case BAKit_ViewTransitionTypeCameraIrisHollowOpen:
            transition.type = @"cameraIrisHollowOpen";
            break;
            
        case BAKit_ViewTransitionTypeCameraIrisHollowClose:
            transition.type = @"cameraIrisHollowClose";
            break;
            
        default:
            break;
    }
    
    if (!subType)
    {
        subType = BAKit_ViewTransitionSubtypeFromRight;
    }
    switch (subType) {
        case BAKit_ViewTransitionSubtypeFromTop:
            transition.subtype = kCATransitionFromTop;
            break;
        case BAKit_ViewTransitionSubtypeFromBottom:
            transition.subtype = kCATransitionFromBottom;
            break;
        case BAKit_ViewTransitionSubtypeFromLeft:
            transition.subtype = kCATransitionFromLeft;
            break;
        case BAKit_ViewTransitionSubtypeFromRight:
            transition.subtype = kCATransitionFromRight;
            break;
            
        default:
            break;
    }
    
    if (!timingFunction)
    {
        timingFunction = BAKit_ViewTransitionTimingFunctionTypeDefault;
    }
    switch (timingFunction) {
        case BAKit_ViewTransitionTimingFunctionTypeDefault:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            break;
            
        case BAKit_ViewTransitionTimingFunctionTypeLinear:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
        case BAKit_ViewTransitionTimingFunctionTypeEaseIn:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
        case BAKit_ViewTransitionTimingFunctionTypeEaseOut:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case BAKit_ViewTransitionTimingFunctionTypeEaseInEaseOut:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;

        default:
            break;
    }
}


@end
