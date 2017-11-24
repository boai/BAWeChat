//
//  UIWindow+LBXHierarchy
//
//
//  Created by lbxia on 15/10/27.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "UIWindow+LBXHierarchy.h"

@implementation UIWindow (LBXHierarchy)

- (UIViewController*)topRootController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
	
    //  Returning topMost ViewController
    return topController;
}


- (UIViewController*)currentTopViewController
{
    UIViewController *currentTopViewController = [self topRootController];
    
    if ([currentTopViewController isKindOfClass:[UITabBarController class]]
        && ((UITabBarController*)currentTopViewController).selectedViewController != nil )
    {
        currentTopViewController = ((UITabBarController*)currentTopViewController).selectedViewController;
    }
    
    while ([currentTopViewController isKindOfClass:[UINavigationController class]]
           && [(UINavigationController*)currentTopViewController topViewController])
    {
        currentTopViewController = [(UINavigationController*)currentTopViewController topViewController];
    }
    
    return currentTopViewController;
}


@end
