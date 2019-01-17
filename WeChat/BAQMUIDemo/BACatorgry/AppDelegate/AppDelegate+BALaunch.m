//
//  AppDelegate+BALaunch.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/11.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate+BALaunch.h"
#import "CoreLaunchLite.h"
#import "CoreLaunchCool.h"
#import "CoreLaunchPro.h"
#import "CoreLaunchPlus.h"


@implementation AppDelegate (BALaunch)


- (UIView *)ba_getLaunchView
{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIView *launchView = viewController.view;
    
    launchView.frame = self.window.bounds;
    [self.window addSubview:launchView];
    
    return launchView;
}

- (void)ba_setupLaunch
{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIView *launchView = viewController.view;
    
    launchView.frame = self.window.bounds;
    [self.window addSubview:launchView];
    
#pragma mark - 第一种动画
    UIImageView *backgroundImageView = launchView.subviews[0];
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = YES;
    backgroundImageView.frame = launchView.bounds;
    backgroundImageView.clipsToBounds = YES;
    
//    UIImageView *logoImageView = launchView.subviews[1];
//    UILabel *copyrightLabel = launchView.subviews[2];
//    copyrightLabel.alpha = 0;
//    logoImageView = logoImageView;
//    UIView *maskView = [[UIView alloc] initWithFrame:launchView.bounds];
//    maskView.backgroundColor = UIColorWhite;
//    [launchView insertSubview:maskView belowSubview:backgroundImageView];
//
//    [UIView animateWithDuration:.15 delay:0.9 options:QMUIViewAnimationOptionsCurveOut animations:^{
//        backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(backgroundImageView.bounds), 64);
//        logoImageView.alpha = 0.0;
//        copyrightLabel.alpha = 0;
//    } completion:nil];
//    [UIView animateWithDuration:1.2 delay:0.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        maskView.alpha = 0;
//        backgroundImageView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [launchView removeFromSuperview];
//    }];

#pragma mark - 第二种动画
    
    [UIView animateWithDuration:0.8f delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionCurveEaseOut animations:^{
            launchView.alpha = 0.0f;
            launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
         } completion:^(BOOL finished) {
                [launchView removeFromSuperview];
         }];
    }];
    
}

- (void)ba_launchAnimationWithType:(BALaunchAnimationType)type
{
    switch (type) {
        case BALaunchAnimationTypeLite:
            [CoreLaunchLite animWithWindow:self.window image:UIImageMake(@"launch_background2")];
            break;
        case BALaunchAnimationTypePlus:
            [CoreLaunchPlus animWithWindow:self.window image:UIImageMake(@"launch_background2")];
            break;
        case BALaunchAnimationTypeCool:
            [CoreLaunchCool animWithWindow:self.window image:UIImageMake(@"launch_background2")];
            break;
        case BALaunchAnimationTypePro:
            [CoreLaunchPro animWithWindow:self.window image:UIImageMake(@"launch_background2")];
            break;
            
        default:
            break;
    }
}



@end
