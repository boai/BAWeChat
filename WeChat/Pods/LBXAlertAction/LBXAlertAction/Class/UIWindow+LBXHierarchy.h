//
//  UIWindow+LBXHierarchy
//
//
//  Created by lbxia on 15/10/27.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIViewController;

/**
 UIWindow hierarchy category.
 */
@interface UIWindow (LBXHierarchy)


//获取当前显示
- (UIViewController*)currentTopViewController;



@end
