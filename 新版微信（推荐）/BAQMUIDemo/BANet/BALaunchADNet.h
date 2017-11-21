//
//  BALaunchADNet.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseNet.h"
#import "BAVideoModel.h"
#import "BAThoughtworksModel.h"

@interface BALaunchADNet : BABaseNet
BAKit_SingletonH(BALaunchADNet)

#pragma mark - 此处模拟广告数据请求,实际项目中请做真实请求
- (void)ba_launchADNet_getImageDataWithBlock:(BABaseNetManagerBlock)block;

#pragma mark - 此处模拟广告数据请求,实际项目中请做真实请求
- (void)ba_launchADNet_getVideoDataWithBlock:(BABaseNetManagerBlock)block;

/*!
 *  示例1：DemoVC1 中的网络获取示例
 *
 *  @param startIndex index
 *  @param block block
 */
- (void)ba_getVideosWithStartIndex:(NSInteger)startIndex block:(BABaseNetManagerBlock)block;

- (void)ba_getThoughtworksWithBlock:(BABaseNetManagerBlock)block;

@end
