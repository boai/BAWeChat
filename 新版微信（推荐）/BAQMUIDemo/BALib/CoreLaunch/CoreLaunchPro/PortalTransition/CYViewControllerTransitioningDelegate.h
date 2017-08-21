//
//  CYViewControllerTransitioningDelegate.h
//  PortalTransitionExample
//
//  Created by Ce Yang on 24/05/2015.
//  Copyright (c) 2015 Ce Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYViewControllerTransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) UIViewController *viewController;

@end
