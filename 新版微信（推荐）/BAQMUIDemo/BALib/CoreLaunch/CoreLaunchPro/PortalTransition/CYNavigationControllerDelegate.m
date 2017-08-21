//
//  CYNavigationControllerDelegate.m
//  PortalTransitionExample
//
//  Created by Ce Yang on 24/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import "CYNavigationControllerDelegate.h"
#import "CYPortalTransitionAnimator.h"

@interface CYNavigationControllerDelegate ()

@property (nonatomic, strong) CYPortalTransitionAnimator *animator;

@end

@implementation CYNavigationControllerDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animator = [[CYPortalTransitionAnimator alloc] init];
    }
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return self.animator;
    }else {
        return nil;
    }
}

-(void)setNavController:(UINavigationController *)navController{
    _navController = navController;
    _navController.delegate = self;
}

@end
