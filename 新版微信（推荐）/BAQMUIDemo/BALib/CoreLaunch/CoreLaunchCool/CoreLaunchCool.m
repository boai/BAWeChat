//
//  CoreLaunchLite.m
//  CoreLaunch
//
//  Created by 冯成林 on 15/10/16.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "CoreLaunchCool.h"
#import "CALayer+Cool.h"

#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)

@implementation CoreLaunchCool


/** 执行动画 */
+(void)animWithWindow:(UIWindow *)window image:(UIImage *)image{
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    imageV.image = image==nil?[self launchImage]:image;
    
    [window.rootViewController.view addSubview:imageV];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [imageV removeFromSuperview];
        
        [window.layer transitionWithAnimType:TransitionAnimTypeRamdom subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:1.6];
    });
}




/**
 *  获取启动图片
 */
+(UIImage *)launchImage{
    
    NSString *imageName=@"LaunchImage-700";
    
    if(iphone5x_4_0) imageName=@"LaunchImage-700-568h";
    
    if(iphone6_4_7) imageName = @"LaunchImage-800-667h";
    
    if(iphone6Plus_5_5) imageName = @"LaunchImage-800-Portrait-736h";
    
    UIImage *image = [UIImage imageNamed:imageName];
    
//    NSAssert(image != nil, @"boai 提示您：请添加启动图片！");
    
    return image;
}


@end
