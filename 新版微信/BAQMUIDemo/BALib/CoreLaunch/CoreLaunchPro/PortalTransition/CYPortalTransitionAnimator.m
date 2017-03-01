//
//  CYPortalTransition.m
//  PortalTransitionExample
//
//  Created by Ce Yang on 23/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import "CYPortalTransitionAnimator.h"

@implementation CYPortalTransitionAnimator

-(instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _reflectionGap = 10.0f;
    _reflectionScale = 0.f;
    _reflectionAlpha = 0.5f;
    _targetViewScale = 0.1f;
    _portalAnimationDuration = 1.6f;
    _scaleAnimationDuration = 1.6f;
    _delay = 0.5f;
}

- (UIImageView *)setupReflectionViewWithReferenceView: (UIView *)toView {
    CGRect frame = toView.bounds;
    frame.size.height = frame.size.height / 2;
    UIImageView *reflectionView = [[UIImageView alloc] initWithFrame:frame];
    reflectionView.userInteractionEnabled = NO;
    
    CGSize reflectionViewSize = CGSizeMake(toView.bounds.size.width, toView.bounds.size.height * _reflectionScale);
    if (reflectionViewSize.width > 0 && reflectionViewSize.height > 0) {
        UIGraphicsBeginImageContextWithOptions(reflectionViewSize, YES, 0.0f);
        CGContextRef gradientContext = UIGraphicsGetCurrentContext();
        CGFloat colors[] = {1.0f ,1.0f, 0.0f, 1.0f};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        
        CGGradientRef gradient =CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
        CGPoint gradientStartPoint = CGPointMake(0.0f,0.0f);
        CGPoint gradientEndPoint = CGPointMake(0.0f, reflectionViewSize.height);
        CGContextDrawLinearGradient(gradientContext, gradient, gradientStartPoint, gradientEndPoint,kCGGradientDrawsAfterEndLocation);
        CGImageRef gradientMask = CGBitmapContextCreateImage(gradientContext);
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorSpace);
        UIGraphicsEndImageContext();
        
        UIGraphicsBeginImageContextWithOptions(reflectionViewSize, NO, 0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -toView.bounds.size.height);
        
        CGContextClipToMask(context, CGRectMake(0.0f, toView.bounds.size.height - reflectionViewSize.height, reflectionViewSize.width, reflectionViewSize.height), gradientMask);
        CGImageRelease(gradientMask);
        
        [toView.layer renderInContext:context];
        
        reflectionView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return reflectionView;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;
{
    return MAX(_portalAnimationDuration, _scaleAnimationDuration);
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    CGSize fromViewSize = fromView.bounds.size;
    
    /**
     *  FromView and portal animation
     */
    // Take a screenshot, take screen scale into consideration
    CGFloat screenScale = [UIScreen mainScreen].scale;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(fromView.window.bounds.size, NO, screenScale);
    else
        UIGraphicsBeginImageContext(fromView.window.bounds.size);
    
    [fromView.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Seperate image into 2 door side
    CGRect clippedLeftRect = CGRectMake(0, 0, screenImage.size.width / 2 * screenScale, screenImage.size.height * screenScale);
    CGRect clippedRightRect = CGRectMake(screenImage.size.width/2 * screenScale, 0, screenImage.size.width / 2 * screenScale, screenImage.size.height * screenScale);
    CGRect clippedLeftRectBis = CGRectMake(0, 0, screenImage.size.width/2, screenImage.size.height);
    CGRect clippedRightRectBis = CGRectMake(screenImage.size.width/2, 0, screenImage.size.width/2, screenImage.size.height);
    CGImageRef leftImageRef = CGImageCreateWithImageInRect(screenImage.CGImage, clippedLeftRect);
    CGImageRef rightImageRef = CGImageCreateWithImageInRect(screenImage.CGImage, clippedRightRect);
    UIImage *leftImage = [UIImage imageWithCGImage:leftImageRef];
    UIImage *rightImage = [UIImage imageWithCGImage:rightImageRef];
    CGImageRelease(leftImageRef);
    CGImageRelease(rightImageRef);
    
    // Add 2 image views
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:clippedLeftRectBis];
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:clippedRightRectBis];
    leftImageView.image = leftImage;
    rightImageView.image = rightImage;
    
    //Add left and right doorside over fromView so that it will not be covered by fromView
    [fromView.superview addSubview:leftImageView];
    [fromView.superview addSubview:rightImageView];
    
    leftImageView.layer.anchorPoint = CGPointMake(0, 0.5);
    leftImageView.layer.position = CGPointMake(0, leftImageView.frame.size.height/2);
    
    rightImageView.layer.anchorPoint = CGPointMake(1, 0.5);
    rightImageView.layer.position = CGPointMake(rightImageView.frame.size.width * 2, rightImageView.frame.size.height/2);
    
    //Add Transform for rotate along Y Axis
    CATransform3D leftScaleTransform = CATransform3DScale(CATransform3DIdentity, 2, 2, 1);
    CATransform3D rightScaleTransform = CATransform3DScale(CATransform3DIdentity, 2, 2, 1);
    CATransform3D leftRotateTransform = CATransform3DRotate(leftScaleTransform,M_PI/2, 0, 1, 0);
    CATransform3D rightRotateTransform = CATransform3DRotate(rightScaleTransform,-M_PI/2, 0, 1, 0);
    
    CATransform3D leftTranslate = CATransform3DTranslate(leftRotateTransform, -fromViewSize.width,0,0);
    CATransform3D rightTranslate = CATransform3DTranslate(rightRotateTransform, fromViewSize.width,0,0);
    
    CAAnimation *leftAnimation = [self getAnimationWithToValue:leftTranslate];
    [leftImageView.layer addAnimation:leftAnimation forKey:@"transform"];
    
    CAAnimation *transfomationRight = [self getAnimationWithToValue:rightTranslate];
    [rightImageView.layer addAnimation:transfomationRight forKey:@"transform"];
    
    /**
     *  toView and reflectionView animation
     */
    UIImageView *reflectionView = [self setupReflectionViewWithReferenceView:toView];
    //Add all the views related to transition to container View
    [[transitionContext containerView] addSubview:toView];
    [[transitionContext containerView] addSubview:reflectionView];
    
    //Apply scale for toView and its reflection
    toView.transform = CGAffineTransformMakeScale(_targetViewScale,_targetViewScale);
    reflectionView.transform = CGAffineTransformMakeScale(_targetViewScale, _targetViewScale);
    
    //Adjust reflectionView frame
    CGRect reflectionViewFrame = reflectionView.frame;
    reflectionViewFrame.origin.y = CGRectGetMaxY(toView.frame) + _reflectionGap;
    reflectionView.frame = reflectionViewFrame;
    
    toView.alpha = 0.4;
    reflectionView.alpha = 0.4;
    fromView.hidden = YES;
    
    [UIView animateWithDuration:_scaleAnimationDuration delay:_delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toView.alpha = 1;
        reflectionView.alpha = 1;
        reflectionView.transform = CGAffineTransformMakeScale(1, 1);
        toView.transform = CGAffineTransformMakeScale(1, 1);
        leftImageView.alpha = 0.4;
        rightImageView.alpha = 0.4;
        leftImageView.layer.position = CGPointMake(-200.f, leftImageView.frame.size.height/2);
        rightImageView.layer.position = CGPointMake(200.f + 2 * rightImageView.frame.size.width, rightImageView.frame.size.height/2);
        
        reflectionView.frame = CGRectMake(0, fromViewSize.height + _reflectionGap, fromViewSize.width, fromViewSize.height/2);
        
        if (_portalTransitionStyle == CYPortalTransitionStylePush) {
            // Push view controller to navigation view controller stack
            // In animation block so that nav bar will take final state into consideration thus create a smooth animation
            NSMutableArray *currentViewControllerStack =  [NSMutableArray arrayWithArray:fromViewController.navigationController.viewControllers];
            [currentViewControllerStack addObject:toViewController];
            fromViewController.navigationController.viewControllers  = currentViewControllerStack;
        }
        
    } completion:^(BOOL finished) {
        //Remove left right imageview and reflection
        [leftImageView removeFromSuperview];
        [rightImageView removeFromSuperview];
        [reflectionView removeFromSuperview];
        fromView.hidden = NO;
        
        if (_portalTransitionStyle == CYPortalTransitionStylePresent) {
            // Call native presentViewController to apply the view hierachy change
            [fromViewController presentViewController:toViewController animated:NO completion:nil];
        }
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

- (CAAnimation *)getAnimationWithToValue:(CATransform3D)transform {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.duration = _portalAnimationDuration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}


@end
