//
//  BATabBarViewController.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/20.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BATabBarViewController.h"
#import "BABaseNavigationController.h"



#define BATab_TitleKey      @"title"
#define BATab_ClassKey      @"rootVCName"
#define BATab_ImaeNormalKey @"imageNameNormal"
#define BATab_ImaeSelectKey @"imageNameSelect"
#define BATab_TitleColorKey @"titleColor"


@interface BATabBarViewController ()

@end

@implementation BATabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
    
}

- (void)setupBase
{
    NSArray *dataArray = @[
                   @{BATab_ClassKey      : @"BAHomeViewController",
                     BATab_TitleKey      : @"微信",
                     BATab_ImaeNormalKey : @"BATabBundle.bundle/tabbar_mainframe",
                     BATab_ImaeSelectKey : @"BATabBundle.bundle/tabbar_mainframeHL",
                     BATab_TitleColorKey : BA_WeXin_greenColor
                     },
                   @{BATab_ClassKey      : @"BAContactViewController",
                     BATab_TitleKey      : @"通讯录",
                     BATab_ImaeNormalKey : @"BATabBundle.bundle/tabbar_contacts",
                     BATab_ImaeSelectKey : @"BATabBundle.bundle/tabbar_contactsHL",
                     BATab_TitleColorKey : BA_WeXin_greenColor
                     },
                   @{BATab_ClassKey      : @"BADiscoveryViewController",
                     BATab_TitleKey      : @"发现",
                     BATab_ImaeNormalKey : @"BATabBundle.bundle/tabbar_discover",
                     BATab_ImaeSelectKey : @"BATabBundle.bundle/tabbar_discoverHL",
                     BATab_TitleColorKey : BA_WeXin_greenColor
                     },
                   @{BATab_ClassKey      : @"BAProfileViewController",
                     BATab_TitleKey      : @"我",
                     BATab_ImaeNormalKey : @"BATabBundle.bundle/tabbar_me",
                     BATab_ImaeSelectKey : @"BATabBundle.bundle/tabbar_meHL",
                     BATab_TitleColorKey : BA_WeXin_greenColor
                     }
                   ];
    BA_WEAKSELF;
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[BATab_ClassKey]) new];
        vc.title = dict[BATab_TitleKey];

        BABaseNavigationController *navi = [[BABaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = navi.tabBarItem;
        item.title = dict[BATab_TitleKey];
        item.image = [UIImage imageNamed:dict[BATab_ImaeNormalKey]];
        item.selectedImage = [[UIImage imageNamed:dict[BATab_ImaeSelectKey]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSUnderlineColorAttributeName:dict[BATab_TitleColorKey], NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle), NSForegroundColorAttributeName : dict[BATab_TitleColorKey]} forState:UIControlStateSelected];

        [weakSelf addChildViewController:navi];
    }];
    self.selectedIndex = 0;
}



@end
