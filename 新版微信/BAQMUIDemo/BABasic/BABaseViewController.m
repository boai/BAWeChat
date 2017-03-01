//
//  BABaseViewController.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseViewController.h"

@interface BABaseViewController ()


@end

@implementation BABaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorWhite;
    
    [self setupUI];
    [self setupNavi];
    
    [BAKit_FPSLabel ba_showInWindow:[UIApplication sharedApplication].keyWindow];

}

- (void)setupUI
{
    
}

- (void)setupNavi
{
    
}




/*！
 自定义动画样式
 
 @param type 动画样式
 @param animationView 需要动画的 View
 */
- (void)ba_animationWithBATransitionType:(BATransitionType)type
                           animationView:(UIView *)animationView
{
    switch (type) {
        case 0:
            [self ba_transitonWithType:BATransitionTypeFade view:animationView];
            break;
            
        case 1:
            [self ba_transitonWithType:BATransitionTypePush view:animationView];
            break;
            
        case 2:
            [self ba_transitonWithType:BATransitionTypeReveal view:animationView];
            break;
            
        case 3:
            [self ba_transitonWithType:BATransitionTypeMoveIn view:animationView];
            break;
            
        case 4:
            [self ba_transitonWithType:BATransitionTypeCube view:animationView];
            break;
            
        case 5:
            [self ba_transitonWithType:BATransitionTypeSuckEffect view:animationView];
            break;
            
        case 6:
            [self ba_transitonWithType:BATransitionTypeOglFlip view:animationView];
            break;
            
        case 7:
            [self ba_transitonWithType:BATransitionTypeRippleEffect view:animationView];
            break;
            
        case 8:
            [self ba_transitonWithType:BATransitionTypePageCurl view:animationView];
            break;
            
        case 9:
            [self ba_transitonWithType:BATransitionTypePageUnCurl view:animationView];
            break;
            
        case 10:
            [self ba_transitonWithType:BATransitionTypeCameraIrisHollowOpen view:animationView];
            break;
            
        case 11:
            [self ba_transitonWithType:BATransitionTypeCameraIrisHollowClose view:animationView];
            break;
            
        case 12:
            [animationView ba_transitionViewWithDuration:0.8f
                                       animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionCurlDown
                                              forView:animationView];
            break;
            
        case 13:
            [animationView ba_transitionViewWithDuration:0.8f
                                       animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionCurlUp
                                              forView:animationView];
            break;
            
        case 14:
            [animationView ba_transitionViewWithDuration:0.8f
                                       animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionFlipFromLeft
                                              forView:animationView];
            break;
            
        case 15:
            [animationView ba_transitionViewWithDuration:0.8f
                                       animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionFlipFromRight
                                              forView:animationView];
            break;
            
        default:
            break;
    }
    
}

- (void)ba_transitonWithType:(BATransitionType)type view:(UIView *)animationView
{
    [animationView ba_transitionWithType:type
                              subType:BATransitionSubtypeFromLeft
                             duration:0.8f
                       timingFunction:BATransitionTimingFunctionTypeEaseInEaseOut
                  removedOnCompletion:YES
                              forView:animationView];
}

#pragma mark - 清理缓存
- (void)ba_clearCache
{
    BAKit_ClearCacheManager *clearCacheManager = [BAKit_ClearCacheManager ba_sharedCache];
    CGFloat cacheSize = [clearCacheManager ba_loadCacheSize];
    
    NSString *clearMessage = [NSString stringWithFormat:@"缓存大小为：%.2fM，确定要清理吗?", cacheSize];
    
    [UIAlertController ba_alertControllerShowAlertInViewController:self withTitle:@"博爱温馨提示：" mutableAttributedTitle:nil message:clearMessage mutableAttributedMessage:nil buttonTitlesArray:@[@"取 消", @"确 定"] buttonTitleColorArray:@[UIColorGreen, UIColorRed] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == 0)
        {
            return ;
        }
        if (buttonIndex == 1)
        {
            [clearCacheManager ba_myClearCacheAction];
            NSString *msg = [NSString stringWithFormat:@"成功清除缓存：%.2fM",  cacheSize];
            BAKit_ShowAlertWithMsg(msg);
        }

        return;
    }];


}


@end
