//
//  AppDelegate.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+BAQMUI.h"
#import "AppDelegate+BALaunch.h"
#import "AppDelegate+BAAuthorization.h"

//#import "BAHomeVC.h"
//#import "BAMeVC.h"

#import "BAHomeViewController.h"
#import "BAContactViewController.h"
#import "BADiscoveryViewController.h"
#import "BAProfileViewController.h"


#import "BANavigationController.h"
#import "BATabBarViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self ba_setupAppDelegate];
    
    return YES;
}

#pragma mark - 系统配置
- (void)ba_setupAppDelegate
{
    /*! QMUI 的配置 */
    [self ba_setupQMUI];
    /*! 界面 */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self ba_creatTabbarController];
    
    /*! 自定义启动动画 */
//    [self ba_setupLaunch];
    [self ba_launchAnimationWithType:BAKit_RandomNumber(4)];
    
    /*! 自定义授权 */
    [self ba_authorizationAll];
}

- (void)ba_creatTabbarController
{
    BATabBarViewController *tabbarController = [[BATabBarViewController alloc] init];
    
       /*! homeVC */
    BAHomeViewController *homeVC = [[BAHomeViewController alloc] init];
    homeVC.hidesBottomBarWhenPushed = NO;
    BANavigationController *homeNavi = [[BANavigationController alloc] initWithRootViewController:homeVC];
    homeNavi.tabBarItem = [BAUIHelper ba_uiHelper_tabbarItemWithTitle:@"微信" image:[UIImageMake(@"BATabBundle.bundle/tabbar_mainframe") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"BATabBundle.bundle/tabbar_mainframeHL")  selectedTitleColor:nil tag:0];
    homeVC.title = homeNavi.tabBarItem.title;

    /*! 通讯录VC */
    BAContactViewController *contactVC = [[BAContactViewController alloc] init];
    contactVC.hidesBottomBarWhenPushed = NO;
    BANavigationController *contactNavi = [[BANavigationController alloc] initWithRootViewController:contactVC];
    contactNavi.tabBarItem = [BAUIHelper ba_uiHelper_tabbarItemWithTitle:@"通讯录" image:[UIImageMake(@"BATabBundle.bundle/tabbar_contacts") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"BATabBundle.bundle/tabbar_contactsHL")  selectedTitleColor:nil tag:1];
    contactVC.title = contactNavi.tabBarItem.title;
    
    /*! 发现VC */
    BADiscoveryViewController *discoveryVC = [[BADiscoveryViewController alloc] init];
    discoveryVC.hidesBottomBarWhenPushed = NO;
    BANavigationController *discoveryNavi = [[BANavigationController alloc] initWithRootViewController:discoveryVC];
    discoveryNavi.tabBarItem = [BAUIHelper ba_uiHelper_tabbarItemWithTitle:@"发现" image:[UIImageMake(@"BATabBundle.bundle/tabbar_discover") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"BATabBundle.bundle/tabbar_discoverHL")  selectedTitleColor:nil tag:2];
    discoveryVC.title = discoveryNavi.tabBarItem.title;
    
    /*! meVC */
    BAProfileViewController *meVC = [[BAProfileViewController alloc] init];
    meVC.hidesBottomBarWhenPushed = NO;
    BANavigationController *meNavi = [[BANavigationController alloc] initWithRootViewController:meVC];
    meNavi.tabBarItem = [BAUIHelper ba_uiHelper_tabbarItemWithTitle:@"我" image:[UIImageMake(@"BATabBundle.bundle/tabbar_me") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"BATabBundle.bundle/tabbar_meHL")  selectedTitleColor:nil tag:3];
    meVC.title = meNavi.tabBarItem.title;

    tabbarController.viewControllers = @[homeNavi, contactNavi, discoveryNavi, meNavi];
    tabbarController.selectedIndex = 2;
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
}

#pragma mark - 内存处理，当app收到内存警告时
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    // 1.取消正在下载的操作
    [manager cancelAll];
    // 2.清除内存缓存
    [manager.imageCache clearMemory];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
