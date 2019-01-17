//
//  UINavigationController+PortalTransition.m
//  PortalTransitionExample
//
//  Created by Ce Yang on 23/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import "UINavigationController+PortalTransition.h"
#import "CYPortalTransitionAnimator.h"
#import "CYPortalTransitionContext.h"

@implementation UINavigationController (PortalTransition)

-(void)pushPortalTransitionViewController:(UIViewController *)viewControllerToPush completion:(void (^)(void))completion {
    UIViewController *fromViewController =  self.topViewController;
    CYPortalTransitionContext *transitionContext = [[CYPortalTransitionContext alloc] initWithFromViewController:fromViewController toViewController:viewControllerToPush];
    transitionContext.animated = YES;
    transitionContext.interactive = NO;
    transitionContext.completionBlock = ^(BOOL didCompleted){
        if (didCompleted && completion) {
            completion();
        }
    };
    
    CYPortalTransitionAnimator *animator = [CYPortalTransitionAnimator new];
    animator.portalTransitionStyle = CYPortalTransitionStylePush;
    [animator animateTransition:transitionContext];
}
@end
