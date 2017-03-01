//
//  BABaseViewController.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface BABaseViewController : QMUICommonViewController

- (void)setupUI;
- (void)setupNavi;


/*！
 自定义动画样式

 @param type 动画样式
 @param animationView 需要动画的 View
 */
- (void)ba_animationWithBATransitionType:(BATransitionType)type
                           animationView:(UIView *)animationView;

#pragma mark - 清理缓存
- (void)ba_clearCache;

@end
