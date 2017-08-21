//
//  BATimeLineRefreshHeader.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/24.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BARefreshHelper.h"

@interface BATimeLineRefreshHeader : BARefreshHelper

/** 创建header */
+ (instancetype)ba_headerWithRefreshingBlock:(BARefreshingBlock)refreshingBlock;

@end
