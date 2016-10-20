//
//  BABaseNavigationController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BABaseNavigationController.h"

@interface BABaseNavigationController ()

@end

@implementation BABaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
}

- (void)setupBase
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UINavigationBar *naviBar = [UINavigationBar appearance];
    naviBar.barTintColor = BA_RGBAColor(0.1, 0.1, 0.1, 0.9);
    naviBar.tintColor = [UIColor whiteColor];
    naviBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
