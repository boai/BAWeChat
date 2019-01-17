//
//  BAThoughtworksModel.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/18.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAThoughtworksModel.h"

@implementation BAThoughtworksModel


+ (NSDictionary *)objectClassInArray{
    return @{@"rows" : [BAThoughtworksModelRows class]};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"rows" : [BAThoughtworksModelRows class]};
}

@end

@implementation BAThoughtworksModelRows

+ (NSDictionary *)modelCustomPropertyMapper {
    return@{@"desc" :@"description"};
}

@end


