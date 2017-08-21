//
//  BAKit_HudManager.m
//  TestMBProgressHUD
//
//  Created by pdc on 16/9/13.
//  Copyright © 2016年 RealsCloud. All rights reserved.
//

#import "BAKit_HudManager.h"
#import <MBProgressHUD.h>
#import <SVProgressHUD.h>
#import "UIView+HUD.h"

static BAKit_HudManager *hudManager = nil;

@interface BAKit_HudManager()

@property (nonatomic, weak) UIView *showView;
@property (nonatomic, assign) BOOL canShow;

@end

@implementation BAKit_HudManager

+ (instancetype )hudManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (hudManager == nil)
        {
            hudManager = [BAKit_HudManager new];
            hudManager.canShow = YES;
        }
    });
    return hudManager;
}

+ (void)ba_overlookThisShow
{
    [BAKit_HudManager hudManager].canShow = NO;
}

+ (void)ba_hudShow
{
    [BAKit_HudManager hudManager].showView = [hudManager topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController].view;
    if ([BAKit_HudManager hudManager].showView && [BAKit_HudManager hudManager].canShow)
    {
        [[BAKit_HudManager hudManager].showView showHUD];
    }
}

+ (void)ba_hudShowWithText:(NSString *)text
{
    [BAKit_HudManager hudManager].showView = [hudManager topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController].view;
    if ([BAKit_HudManager hudManager].showView && [BAKit_HudManager hudManager].canShow)
    {
        [[BAKit_HudManager hudManager].showView ba_showHudWithText:text];
    }
}

+ (void)ba_hudShowWithTextHideAfterTime:(NSString *)text
{
    [BAKit_HudManager hudManager].showView = [hudManager topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController].view;
    if ([BAKit_HudManager hudManager].showView && [BAKit_HudManager hudManager].canShow)
    {
        [[BAKit_HudManager hudManager].showView ba_showHudWithText:text hideAfterTime:2.0f];
    }
}

+ (void)ba_hudShowWithCustomviewWithText:(NSString *)text
{
    [BAKit_HudManager hudManager].showView = [hudManager topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController].view;
    if ([BAKit_HudManager hudManager].showView && [BAKit_HudManager hudManager].canShow)
    {
        NSMutableArray *imageArr = [NSMutableArray array];
        for (int i = 1; i < 12; i ++ )
        {
            
            [imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_1_%d",i]]];
        }
        UIImageView *showImageView = [[UIImageView alloc] init];
        showImageView.animationImages = imageArr;
        [showImageView setAnimationRepeatCount:0];
        [showImageView setAnimationDuration:(imageArr.count + 1) * 0.075];
        [showImageView startAnimating];

        [[BAKit_HudManager hudManager].showView ba_showHudWithCustomview:showImageView text:text hideAfterTime:2.0f];
    }
}

+ (void)ba_hudHidden
{
    if ([BAKit_HudManager hudManager].showView)
    {
        [[BAKit_HudManager hudManager].showView hiddenHUD];
    }
    [BAKit_HudManager hudManager].canShow = YES;
}

/** 获取当前界面的ViewController */
- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    }
    else
    {
        return rootViewController;
    }
    
}
@end


#pragma mark - 用于处理控制器消失时hud还存在
#import <objc/runtime.h>
@interface UIViewController(HUDManager)

@end

@implementation UIViewController(HUDManager)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSEL = @selector(viewDidDisappear:);
        SEL swizzledSEL = @selector(hud_viewDidDisappear:);
        [class exchangeMethod:originalSEL method:swizzledSEL];
        
        //设置HUD样式
        if (IOS9_SDK_ALLOWED)
        {
            [SVProgressHUD setMinimumDismissTimeInterval:1.618];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
    });
}

//处理控制器消失时hud不能移除问题
-(void )hud_viewDidDisappear:(BOOL )animated
{
    //控制器视图消失前有未隐藏的hud，则移除
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MBProgressHUD class]])
        {
            [BAKit_HudManager hudManager].canShow = YES;
            [obj removeFromSuperview];
        }
    }];
    [self hud_viewDidDisappear:animated];
}
@end
