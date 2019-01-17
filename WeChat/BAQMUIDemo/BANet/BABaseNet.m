//
//  BABaseNet.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseNet.h"
#import "AFNetworkReachabilityManager.h"

@implementation BABaseNet

/**
 请求类型：Get
 
 @param entity entity description
 @param completionHandle completionHandle description
 */
- (void)ba_net_getWithEntity:(BADataEntity *)entity
            completionHandle:(BABaseNetManagerBlock)completionHandle
{
    [self ba_net_isHaveNetWithUrlString:entity.urlString completionHandle:completionHandle];

    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        if (response)
        {
            completionHandle(response, nil);
        }
    } failureBlock:^(NSError *error) {
        if (error)
        {
            completionHandle(nil, error);
        }
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

/**
 请求类型：Post
 
 @param entity entity description
 @param completionHandle completionHandle description
 */
- (void)ba_net_postWithEntity:(BADataEntity *)entity
             completionHandle:(BABaseNetManagerBlock)completionHandle
{
    [self ba_net_isHaveNetWithUrlString:entity.urlString completionHandle:completionHandle];
    
    if ([entity.parameters isKindOfClass:[NSDictionary class]])
    {
        
    }
    else
    {
        
    }

    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        if (response)
        {
            completionHandle(response, nil);
        }
    } failureBlock:^(NSError *error) {
        if (error)
        {
            completionHandle(nil, error);
        }
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

/**
 请求类型：upload image
 
 @param entity entity description
 @param completionHandle completionHandle description
 */
- (void)ba_net_uploadImageWithEntity:(BADataEntity *)entity
                    completionHandle:(BABaseNetManagerBlock)completionHandle
{
    [self ba_net_isHaveNetWithUrlString:entity.urlString completionHandle:completionHandle];
    
    [BANetManager ba_uploadImageWithEntity:entity successBlock:^(id response) {
        completionHandle(response, nil);
    } failurBlock:^(NSError *error) {
        completionHandle(nil, error);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)ba_net_isHaveNetWithUrlString:(NSString *)urlString
                     completionHandle:(BABaseNetManagerBlock)completionHandle
{
    [self setupHTTPHeader];
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==AFNetworkReachabilityStatusNotReachable)
    {
        completionHandle(@"无网络！", [NSError errorWithDomain:urlString code:BANetManagerErrorCodeTypeNoNet userInfo:nil]);
        //        [BAKit_HudManager ba_hudShowWithTextHideAfterTime:@"无网络！"];
        return;
    }
}

- (void)setupHTTPHeader
{
//    BANetManagerShare.httpHeaderFieldDictionary = BaseHeaderDict;
    //     自定义更改 requestSerializer
    BANetManagerShare.requestSerializer = BAHttpRequestSerializerJSON;
    //     自定义更改 responseSerializer
    BANetManagerShare.responseSerializer = BAHttpRequestSerializerJSON;
    
}

@end
