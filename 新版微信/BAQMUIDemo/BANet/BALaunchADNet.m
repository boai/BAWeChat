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
- (void)ba_launchADNet_getImageDataCompletionHandle:(void (^)(id data, NSError *))completionHandle
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSData *jsonData = BAKit_GetDataWithContentsOfFile(@"LaunchImageAd", @"json");
        NSDictionary *dict = BAKit_GetDictionaryWithData(jsonData);
        if (completionHandle)
        {
            completionHandle(dict, nil);
        }
    });
}

#pragma mark - 此处模拟广告数据请求,实际项目中请做真实请求
- (void)ba_launchADNet_getVideoDataCompletionHandle:(void (^)(id data, NSError *))completionHandle
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSData *jsonData = BAKit_GetDataWithContentsOfFile(@"LaunchVideoAd", @"json");
        NSDictionary *dict = BAKit_GetDictionaryWithData(jsonData);
        if (completionHandle)
        {
            completionHandle(dict, nil);
        }
    });
    
}

/*!
 *  示例1：DemoVC1中的网络获取示例
 *
 *  @param startIndex index
 *
 *  @return DemoVC1中的网络获取示例
 */
- (id)ba_getVideosWithStartIndex:(NSInteger)startIndex completionHandle:(void (^)(BAVideoModel *data, NSError *))completionHandle
{
    NSString *path = [NSString stringWithFormat:KVideoPath, startIndex];
    
    return [BANetManager ba_request_GETWithUrlString:path isNeedCache:NO parameters:nil successBlock:^(id response) {
        completionHandle([BAVideoModel yy_modelWithJSON:response], nil);
        
    } failureBlock:^(NSError *error) {
        NSLog(@"error：%@", error);
        completionHandle(nil, error);
        
    } progress:nil];
}

- (id)ba_getThoughtworksWithCompletionHandle:(void (^)(BAThoughtworksModel *data, NSError *))completionHandle
{
    NSString *path = KthoughtworksPath;
    
    return [BANetManager ba_request_GETWithUrlString:path isNeedCache:NO parameters:nil successBlock:^(id response) {
        
        completionHandle([BAThoughtworksModel yy_modelWithJSON:response], nil);
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"error：%@", error);
        completionHandle(nil, error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
