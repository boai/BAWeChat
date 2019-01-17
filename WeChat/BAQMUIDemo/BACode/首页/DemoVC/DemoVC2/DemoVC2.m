//
//  DemoVC2.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/10.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "DemoVC2.h"
#import "BACustomToastAnimator.h"
#import "BACustomToastContentView.h"

@interface DemoVC2 ()

@end

@implementation DemoVC2

- (void)initDataSource
{
    self.dataSourceArray = @[@"Loading",
                             @"Loading With Text",
                             @"Tips For Succeed",
                             @"Tips For Error",
                             @"Tips For Info",
                             @"Custom TintColor",
                             @"Custom BackgroundView Style",
                             @"Custom Content View"];
}

- (void)didSelectCellWithTitle:(NSString *)title
{
    UIView *contentView = self.navigationController.view;

    if ([title isEqualToString:@"Loading"])
    {
        QMUITips *tips = [QMUITips createTipsToView:contentView];
        QMUIToastContentView *tostContentView = (QMUIToastContentView *)tips.contentView;
        tostContentView.backgroundColor = UIColorRed;
        tostContentView.minimumSize = CGSizeMake(90, 90);
        tostContentView.layer.masksToBounds = YES;
        tostContentView.layer.cornerRadius = 5.0f;
        
        [tips showLoadingHideAfterDelay:2.0f];
    }
    else if ([title isEqualToString:@"Loading With Text"])
    {
        [QMUITips showLoading:@"加载中..." inView:contentView hideAfterDelay:2.0f];
    }
    else if ([title isEqualToString:@"Tips For Succeed"])
    {
        [QMUITips showSucceed:@"Succeess" inView:contentView hideAfterDelay:2.0f];
    }
    else if ([title isEqualToString:@"Tips For Error"])
    {
        [QMUITips showError:@"又没网了，联通好坑爹啊..." inView:contentView hideAfterDelay:2.0f];
    }
    else if ([title isEqualToString:@"Tips For Info"])
    {
        [QMUITips showInfo:@"欢迎来到 boaihome.com" detailText:@"2017年1月14日直播，欢迎各位小白前来探讨！" inView:contentView hideAfterDelay:2.0f];
    }
    else if ([title isEqualToString:@"Custom TintColor"])
    {
        QMUITips *tips =[QMUITips showInfo:@"欢迎来到 boaihome.com" detailText:@"2017年1月14日直播，欢迎各位小白前来探讨！" inView:contentView];
        tips.tintColor = UIColorGreen;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tips removeFromSuperview];
        });
    }
    else if ([title isEqualToString:@"Custom BackgroundView Style"])
    {
        QMUITips *tips = [QMUITips showInfo:@"欢迎来到 boaihome.com" detailText:@"2017年1月14日直播，欢迎各位小白前来探讨！" inView:contentView];
        tips.tintColor = UIColorRed;
        
        QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
        /*! 是否需要磨砂，默认NO。仅支持iOS8及以上版本。 */
        backgroundView.shouldBlurBackgroundView = YES;
        /*! 如果不设置磨砂，则styleColor直接作为`QMUIToastBackgroundView`的backgroundColor；如果需要磨砂，则会新增加一个`UIVisualEffectView`放在`QMUIToastBackgroundView`上面
         */
        backgroundView.styleColor = UIColorMakeWithRGBA(232, 232, 232, 1.0f);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tips removeFromSuperview];
        });
    }
    else if ([title isEqualToString:@"Custom Content View"])
    {
        QMUITips *tips = [QMUITips createTipsToView:contentView];
        tips.toastPosition = QMUIToastViewPositionTop;
        
        BACustomToastAnimator *customAnimator = [[BACustomToastAnimator alloc] initWithToastView:tips];
        tips.toastAnimator = customAnimator;
        
        BACustomToastContentView *customContentView = [[BACustomToastContentView alloc] init];
        [customContentView ba_renderWitherImage:UIImageMake(@"icon2.jpg") title:@"什么是QMUIToastView" detailText:@"QMUIToastView用于临时显示某些信息，并且会在数秒后自动消失。这些信息通常是轻量级操作的成功信息。"];
        tips.contentView = customContentView;
        tips.tintColor = UIColorBlue;
        [tips showAnimated:YES];
        
        [tips hideAnimated:YES afterDelay:3.0f];
    }
    
}


@end
