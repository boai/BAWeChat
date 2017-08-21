//
//  ProVC.m
//  CoreLaunch
//
//  Created by 冯成林 on 15/10/16.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "ProVC.h"
#import "UIViewController+PortalTransition.h"
#import "CYViewControllerTransitioningDelegate.h"

@interface ProVC ()

@property (nonatomic, strong) CYViewControllerTransitioningDelegate *viewControllerTransitionDelegate;

@end

@implementation ProVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf=self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        weakSelf.rootVC.modalPresentationStyle = UIModalPresentationCustom;
        
        weakSelf.viewControllerTransitionDelegate.viewController = weakSelf.rootVC;
        
        [weakSelf presentPortalTransitionViewController:self.rootVC completion:^{
            
            [weakSelf.rootVC dismissViewControllerAnimated:NO completion:^{
                weakSelf.window.rootViewController = weakSelf.rootVC;
            }];
        }];
    });
    
}

-(UIImageView *)imageV{
    
    if(_imageV == nil){
        
        _imageV = [[UIImageView alloc] init];
        _imageV.frame = [UIScreen mainScreen].bounds;
        [self.view addSubview:_imageV];
    }
    
    return _imageV;
}

-(void)dealloc{
    NSLog(@"ProVC dealloc");
}

@end
