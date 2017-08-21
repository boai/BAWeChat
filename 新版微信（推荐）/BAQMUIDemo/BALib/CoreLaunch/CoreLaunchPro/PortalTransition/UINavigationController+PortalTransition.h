//
//  UINavigationController+PortalTransition.h
//  PortalTransitionExample
//
//  Created by Ce Yang on 23/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (PortalTransition)

-(void)pushPortalTransitionViewController:(UIViewController *)viewControllerToPush completion:(void (^)(void))completion;

@end
