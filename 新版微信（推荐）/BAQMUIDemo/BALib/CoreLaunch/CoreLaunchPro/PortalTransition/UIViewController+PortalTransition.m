//
//  UIViewController+PortalTransition.m
//  PortalTransitionExample
//
//  Created by Ce Yang on 23/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import "UIViewController+PortalTransition.h"
#import "CYPortalTransitionContext.h"
#import "CYPortalTransitionAnimator.h"

@implementation UIViewController (PortalTransition)

- (void) presentPortalTransitionViewController: (UIViewController *)viewControllerToPresent completion:(void (^)(void))completion
{
    //Get up most parentViewController
    UIViewController *fromViewController = self;
    while (nil != [fromViewController parentViewController]) {
        fromViewController = [fromViewController parentViewController];
    }
    CYPortalTransitionContext *transitionContext = [[CYPortalTransitionContext alloc] initWithFromViewController:fromViewController toViewController:viewControllerToPresent];
    transitionContext.animated = YES;
    transitionContext.interactive = NO;
    transitionContext.completionBlock = ^(BOOL didCompleted){
        if (didCompleted) {
            [viewControllerToPresent didMoveToParentViewController:self];
            
            if (completion) {
                completion();
            }
        }
    };
    
    CYPortalTransitionAnimator *animator = [CYPortalTransitionAnimator new];
    animator.portalTransitionStyle = CYPortalTransitionStylePresent;
    [animator animateTransition:transitionContext];
}

@end
