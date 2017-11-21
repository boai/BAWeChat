//
//  BALaunchADNet.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BALaunchADNet.h"
#import "YYModel.h"

@implementation BALaunchADNet
BAKit_SingletonM(BALaunchADNet)

#pragma mark - 此处模拟广告数据请求,实际项目中请做真实请求
- (void)ba_launchADNet_getImageDataWithBlock:(BABaseNetManagerBlock)block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSData *jsonData = BAKit_GetDataWithContentsOfFile(@"LaunchImageAd", @"json");
        NSDictionary *dict = BAKit_GetDictionaryWithData(jsonData);
        if (block)
        {
            block(dict, nil);
        }
    });
}

#pragma mark - 此处模拟广告数据请求,实际项目中请做真实请求
- (void)ba_launchADNet_getVideoDataWithBlock:(BABaseNetManagerBlock)block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSData *jsonData = BAKit_GetDataWithContentsOfFile(@"LaunchVideoAd", @"json");
        NSDictionary *dict = BAKit_GetDictionaryWithData(jsonData);
        if (block)
        {
            block(dict, nil);
        }
    });
    
}

/*!
 *  示例1：DemoVC1 中的网络获取示例
 *
 *  @param startIndex index
 *  @param block block
 */
- (void)ba_getVideosWithStartIndex:(NSInteger)startIndex block:(BABaseNetManagerBlock)block
{
    //  version 2.3.8 的写法
    BABaseNet *net = [BABaseNet new];
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:KVideoPath, startIndex];
    entity.needCache = NO;
    
    [net ba_net_postWithEntity:entity completionHandle:^(id data, NSError *error) {
        if (block)
        {
            block([BAVideoModel yy_modelWithJSON:data], error);
        }
    }];
}

- (void)ba_getThoughtworksWithBlock:(BABaseNetManagerBlock)block
{
    //  version 2.3.8 的写法
    BABaseNet *net = [BABaseNet new];
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = KthoughtworksPath;
    entity.needCache = NO;
    
    [net ba_net_getWithEntity:entity completionHandle:^(id data, NSError *error) {
        if (block)
        {
            block([BAVideoModel yy_modelWithJSON:data], error);
        }
    }];
//  version 2.3.6 的写法
//    return [BANetManager ba_request_GETWithUrlString:path isNeedCache:NO parameters:nil successBlock:^(id response) {
//
//        completionHandle([BAThoughtworksModel yy_modelWithJSON:response], nil);
//
//    } failureBlock:^(NSError *error) {
//
//        NSLog(@"error：%@", error);
//        completionHandle(nil, error);
//
//    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//
//    }];
}

@end
