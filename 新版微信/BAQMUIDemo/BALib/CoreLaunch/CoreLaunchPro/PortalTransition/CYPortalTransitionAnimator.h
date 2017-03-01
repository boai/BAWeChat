//
//  CYPortalTransition.h
//  PortalTransitionExample
//
//  Created by Ce Yang on 23/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CYPortalTransitionStyleDelegate,
    CYPortalTransitionStylePresent,
    CYPortalTransitionStylePush,
} CYPortalTransitionStyle;


@interface CYPortalTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  Gap between the target view and reflection, default is 8.0
 */
@property (nonatomic, assign) CGFloat reflectionGap;


/**
 *  ReflectionHeight / targetViewHeight, default is 0.5
 */
@property (nonatomic, assign) CGFloat reflectionScale;

/**
 *  Opacity of reflectionView, default is 0.5
 */
@property (nonatomic, assign) CGFloat reflectionAlpha;

/**
 *  Target view size / origin view size, default is 0.5
 */
@property (nonatomic, assign) CGFloat targetViewScale;

/**
 *  Portal animation duration, default is 2.0
 */
@property (nonatomic, assign) CGFloat portalAnimationDuration;

/**
 *  Animation duration, default is 3.O
 */
@property (nonatomic, assign) CGFloat scaleAnimationDuration;

/**
 *  Target view scale animation delay after portal animation, default is 0.5
 */
@property (nonatomic, assign) CGFloat delay;

/**
 *  UIViewController Transition Style, support UINavigationViewController Push, UIViewController present
 */
@property (nonatomic, assign) CYPortalTransitionStyle portalTransitionStyle;


@end
