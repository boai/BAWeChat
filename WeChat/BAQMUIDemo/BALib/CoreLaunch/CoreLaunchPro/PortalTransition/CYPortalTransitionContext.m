//
//  CYPortalTransitionContext.m
//  PortalTransitionExample
//
//  Created by Ce Yang on 23/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import "CYPortalTransitionContext.h"

@interface CYPortalTransitionContext ()

@property (nonatomic, strong) NSDictionary *privateViewControllersDictionary;
@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;

@end

@implementation CYPortalTransitionContext

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    if (self = [super init]) {
        self.privateViewControllersDictionary = @{
                                                  UITransitionContextFromViewControllerKey:fromViewController,
                                                  UITransitionContextToViewControllerKey: toViewController};
        self.containerView = [fromViewController.view superview];
    }
    return self;
}


- (UIViewController *)viewControllerForKey:(NSString *)key{
    return self.privateViewControllersDictionary[key];
}

-(void)completeTransition:(BOOL)didComplete{
    if (self.completionBlock) {
        self.completionBlock(didComplete);
    }
}

- (CGRect)initialFrameForViewController:(UIViewController *)vc;{
    return self.containerView.bounds;
}

- (CGRect)finalFrameForViewController:(UIViewController *)vc;{
    return self.containerView.bounds;
}

//Can not be canceled
-(BOOL)transitionWasCancelled {
    return NO;
}

// Supress warnings by implementing empty interaction methods for the remainder of the protocol:
// Currently interactive transition not supported
- (void)updateInteractiveTransition:(CGFloat)percentComplete {}
- (void)finishInteractiveTransition {}
- (void)cancelInteractiveTransition {}

@end
