//
//  CYViewControllerTransitioningDelegate.m
//  PortalTransitionExample
//
//  Created by Ce Yang on 24/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import "CYViewControllerTransitioningDelegate.h"
#import "CYPortalTransitionAnimator.h"

@interface CYViewControllerTransitioningDelegate ()

@property (nonatomic, strong) CYPortalTransitionAnimator *animator;

@end

@implementation CYViewControllerTransitioningDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animator = [[CYPortalTransitionAnimator alloc] init];
    }
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;{
    return self.animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;{
    return nil;
}

-(void)setViewController:(UIViewController *)viewController{
    _viewController = viewController;
    _viewController.transitioningDelegate = self;
}

@end
