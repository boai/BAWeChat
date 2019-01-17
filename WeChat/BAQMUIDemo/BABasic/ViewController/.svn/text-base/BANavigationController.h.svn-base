//
//  BANavigationController.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface BANavigationController : QMUINavigationController

/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

/*!
 *  返回指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 *
 *  @return 类，没找到返回空
 */
-(instancetype)backToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;


/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName;

@end
