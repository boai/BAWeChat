//
//  BAWebViewModel.h
//  BAQMUIDemo
//
//  Created by boai on 2017/3/18.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BAWebViewModel : NSObject

/**
 *  请求地址
 */
@property (copy, nonatomic) NSString *requestURL;

/**
 加载的本地 htmlString
 */
@property(nonatomic, strong) NSString *htmlString;

/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;

/**
 *  加载时是否显示HUD提示层(默认YES)
 */
@property (nonatomic, assign) BOOL showHudWhenLoading;

/**
 *  是否显示加载进度 (默认YES)
 */
@property (nonatomic, assign) BOOL shouldShowProgress;

/**
 *  是否使用WebPage的title作为导航栏title（默认YES）
 */
@property (nonatomic, assign) BOOL isUseWebPageTitle;

/**
 *  是否支持滚动（默认YES）
 */
@property (nonatomic, assign) BOOL scrollEnabled;


- (instancetype)initWithParams:(NSDictionary *)params;


@end
