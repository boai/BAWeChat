//
//  UIBarButtonItem+BAKit.h
//  BAKit
//
//  Created by 孙博岩 on 15/8/1.
//  Copyright © 2015年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BAKit)

/**
 创建 自定义 UIBarButtonItem

 @param image image
 @param highImage highImage
 @param target target
 @param action action
 @param controlEvents controlEvents
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image
                                  highImage:(UIImage *)highImage
                                     target:(id)target
                                     action:(SEL)action
                           forControlEvents:(UIControlEvents)controlEvents;


@end
