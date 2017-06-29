//
//  UIBarButtonItem+BAKit.m
//  BAKit
//
//  Created by 孙博岩 on 15/8/1.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "UIBarButtonItem+BAKit.h"

@implementation UIBarButtonItem (BAKit)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image
                                  highImage:(UIImage *)highImage
                                     target:(id)target
                                     action:(SEL)action
                           forControlEvents:(UIControlEvents)controlEvents

{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
