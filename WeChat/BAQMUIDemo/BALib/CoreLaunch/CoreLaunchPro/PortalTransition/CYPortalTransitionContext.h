//
//  CYPortalTransitionContext.h
//  PortalTransitionExample
//
//  Created by Ce Yang on 23/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYPortalTransitionContext : NSObject <UIViewControllerContextTransitioning>

@property (nonatomic, copy) void(^completionBlock)(BOOL compeleted);
//Designed Initilizer
- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, getter=isInteractive) BOOL interactive;
@property (nonatomic, getter=isAnimated) BOOL animated;

@end
