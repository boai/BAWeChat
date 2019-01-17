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
    while ([topController presentedViewController])
        topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)presentedWithController:(UIViewController*)vc
{
    while ([vc presentedViewController])
        vc = vc.presentedViewController;
    return vc;
}


- (UIViewController*)currentTopViewController
{
    UIViewController *currentViewController = [self topRootController];
    
    if ([currentViewController isKindOfClass:[UITabBarController class]]
        && ((UITabBarController*)currentViewController).selectedViewController != nil )
    {
        currentViewController = ((UITabBarController*)currentViewController).selectedViewController;
    }
    
    currentViewController = [self presentedWithController:currentViewController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]]
           && [(UINavigationController*)currentViewController topViewController])
    {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
        currentViewController = [self presentedWithController:currentViewController];
        
    }
    
    
    currentViewController = [self presentedWithController:currentViewController];
    
    
    return currentViewController;
}

@end
