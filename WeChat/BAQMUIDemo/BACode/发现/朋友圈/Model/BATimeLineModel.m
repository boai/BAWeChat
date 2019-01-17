//
//  BATimeLineModel.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BATimeLineModel.h"

@implementation BATimeLineModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"comments":[BATimeLineCommentModel class]};
}

@end

@implementation BATimeLineCommentModel

@end
