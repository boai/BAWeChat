//
//  BABaseNet.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <BANetManager_OC.h>
#import "BAURLsPath.h"

typedef void (^BABaseNetManagerBlock)(id data, NSError *error);

typedef NS_ENUM(NSUInteger, BANetManagerErrorCodeType) {
    BANetManagerErrorCodeTypeSuccess,
    BANetManagerErrorCodeTypeError,
    BANetManagerErrorCodeTypeFalse,
    BANetManagerErrorCodeTypeNoNet
};

@interface BABaseNet : BANetManager

/**
 请求类型：Get
 
 @param entity entity description
 @param completionHandle completionHandle description
 */
- (void)ba_net_getWithEntity:(BADataEntity *)entity
            completionHandle:(BABaseNetManagerBlock)completionHandle;

/**
 请求类型：Post
 
 @param entity entity description
 @param completionHandle completionHandle description
 */
- (void)ba_net_postWithEntity:(BADataEntity *)entity
             completionHandle:(BABaseNetManagerBlock)completionHandle;

/**
 请求类型：upload image
 
 @param entity entity description
 @param completionHandle completionHandle description
 */
- (void)ba_net_uploadImageWithEntity:(BADataEntity *)entity
                    completionHandle:(BABaseNetManagerBlock)completionHandle;

@end
