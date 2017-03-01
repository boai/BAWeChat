//
//  AppDelegate+BAQMUI.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/11.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate+BAQMUI.h"


@implementation AppDelegate (BAQMUI)

/*! QMUI 的配置 */
- (void)ba_setupQMUI
{
    /*! 启动 QMUI 的配置模板 */
    //    [QMUIConfigurationTemplate setupConfigurationTemplate];
    
    /*! 自定义 QMUI 的配置模板 */
    [BAUIHelper ba_setupConfigurationTemplate];
    
    /*! 将全局的控件样式渲染出来 */
    [QMUIConfigurationManager renderGlobalAppearances];
    
    /*! 博爱自定义的全局样式渲染 */
    [BAUIHelper ba_renderGlobalAppearances];
    
    /*! 将状态栏设置为希望的样式 */
    [QMUIHelper renderStatusBarStyleLight];
    
    /*! 预加载 QQ 表情，避免第一次使用时卡顿 */
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [QMUIQQEmotionManager emotionsForQQ];
    });
}

@end
